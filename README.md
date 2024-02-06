
# Docker Registry, DockerHub

## Docker Login 
```bash
$ docker login
 username: contrerasadr
 password: ******

$ cat ~/.docker/config.json 
```
## Tag
```bash
$ docker tag scalian_training/bash-example:0.0.1 contrerasadr/scalian_training-bash-example:0.0.1
$ docker tag scalian_training/bash-example:0.0.1-alpine contrerasadr/scalian_training-bash-example:0.0.1-alpine
```

## Push
```bash
$ docker push contrerasadr/scalian_training-bash-example:0.0.1
$ docker push contrerasadr/scalian_training-bash-example:0.0.1-alpine
```