# CI / CD Strategy with Docker


## Run Jenkins-Docker Locally
```bash
$ docker compose up -d --force-recreate
```


## Instalar cluster k3d
```bash
$ k3d cluster create scalian-training-cluster \
    --api-port 6443 --servers 1 \
    --agents 2 -p 30000-30100:30000-30100@server:0
```

## Install Helm
```bash
$ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
$ chmod 700 get_helm.sh
$ ./get_helm.sh
```




## Instalar Jenkins Operator 
```bash
$ kubectl create namespace jenkins-operator
$ helm repo add jenkins https://raw.githubusercontent.com/jenkinsci/kubernetes-operator/master/chart
$ helm install jenkins-operator jenkins/jenkins-operator -n jenkins-operator --set jenkins.enabled=false
$ kubectl -n jenkins-operator get pods 
```

## Subir imagen de Jenkins a DockerHub
```bash
$ docker build -t <Docker_hub_username>/jenkins-docker:lts-jdk11 .
$ docker push <Docker_hub_username>/jenkins-docker:lts-jdk11
```

## Instalar Jenkins
```bash
$ kubectl create ns jenkins
$ kubectl apply -n jenkins-operator -f jenkins-operator-rbac.yaml
$ kubectl create -f jenkins-instance.yaml -n jenkins
```


### SONNAR

# TEST SCANNER WITH PYTHON APP
```bash
docker run \
    --rm \
    -e SONAR_HOST_URL="http://172.16.235.10:9000" \
    -e SONAR_SCANNER_OPTS="-Dsonar.projectKey=flask-app" \
    -e SONAR_LOGIN="sqp_93dcdd4b8cc81c7a0c1217b37f94634bfb4e7b97" \
    -v "c:/Users/a.contreras/Documents/workspaces/training/scalian_training/docker/practica/app:/usr/src" \
    --network jenkins_scalian_training-net \
    sonarsource/sonar-scanner-cli
```

