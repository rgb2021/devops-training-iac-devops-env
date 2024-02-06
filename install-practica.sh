#!/bin/bash
function sep {
    echo "=============================================================="
}

function mark_text {
sep
echo $1
sep
}


mark_text "STARTING K3D CLUSTER WITH 3 WORKERS"
k3d cluster delete scalian_training-cluster

k3d cluster create scalian_training-cluster \
    --api-port 6443 --servers 1 \
    #--agents 3 -p "5001:5000@loadbalancer" \
    -p "8082:30080@agent:0" --agents 2
    -v /tmp/k3d-vol:/tmp/

kubectl config use-context k3d-scalian_training-cluster
kubectl cluster-info

mark_text "CREATING LOCAL PERSISTENT VOLUME"
kubectl apply -f local-persistent-volume.yaml
kubectl get pv # Should be bounded

mark_text "CREATING 'practica' NAMESPACE"
kubectl apply -f practica/0_namespace.yaml

# Config
mark_text "CREATING MySQL DB"
kubectl apply -n practica -f practica/1_database-config.yaml
kubectl apply -n practica -f practica/2_database-root-user-secret.yaml 
kubectl apply -n practica -f practica/3_database-pvc.yaml
kubectl get pvc -n practica # Should be bounded
kubectl apply -n practica -f practica/4_database-deployment.yaml
kubectl get deployment -n practica
kubectl apply -n practica -f practica/5_database-service.yaml
sleep 10 

mark_text "CREATING MY FLASK APP"
kubectl apply -n practica -f practica/6_my-app-deployment.yaml
kubectl apply -n practica -f practica/7_my-app-service.yaml
kubectl apply -n practica -f practica/8_my-app-ingress.yaml 
kubectl apply -n practica -f practica/9_my-app-nodeport.yaml 
sleep 40

mark_text "TEST APP"
kubectl run mycurlpod -n practica \
    --image=curlimages/curl -i --rm \
    -- curl my-flask-app-svc.practica:5000

kubectl logs -n practica -l app=my-flask-app

curl localhost:32001