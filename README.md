# docker-springframework

```
$ docker build -t test .
$ docker run -p 8080:8080 test
$ for i in {0..9}; do curl -s localhost:8080 ; echo "" ; sleep 1 ; done
```
