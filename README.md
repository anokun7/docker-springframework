# docker-springframework

## Pre-requisite:
- Install Docker for Mac or Docker for Windows
- Make sure Docker is running

```
$ docker build -t test .
$ docker run -p 8080:8080 test
$ for i in {0..9}; do curl -s localhost:8080 ; echo "" ; sleep 1 ; done
```

To run in swarm mode:
```
$ docker swarm init
$ docker build anoop/spring-boot-demo:latest .
$ docker push anoop/spring-boot-demo:latest
$ docker stack deploy -c stack.yml
$ for i in {0..9}; do curl -s localhost:8080 ; echo "" ; sleep 1 ; done
```
