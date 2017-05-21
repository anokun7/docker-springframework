#!/bin/bash
printf "%100s\n" "------------------------ Starting Docker build --------------------"
printf "%100s\n" "==================== Building ONBUILD version  ===================="
docker build -t ${dockerid:-anoop}/spring-boot-demo:onbuild -f ../Dockerfile.maven ..
printf "%100s\n" "==================== Building MULTI-STAGE version  ================"
docker build -t ${dockerid:-anoop}/spring-boot-demo:latest ..
printf "%100s\n" "---------------------------- Finished Docker build -----------------"
printf "%100s\n" ""
printf "%100s\n" ""
printf "%100s\n" "========================== Pushing all images ======================"
docker push ${dockerid:-anoop}/spring-boot-demo:onbuild
docker push ${dockerid:-anoop}/spring-boot-demo
printf "%100s\n\n" "==================== Finished pushing all images ===================="
printf "%100s\n" "============================================ Deploying STACKS ======="
printf "%100s\n" "==================================================== Onbuild Stack =="
version=onbuild docker stack deploy -c ../stack.yml OnBuild
printf "%100s\n" "================================================= PRODUCTION STACK =="
docker stack deploy -c ../stack.yml Prod

printf "%100s\n" ""
printf "%100s\n" "================= Running Tests & generating stats ===================="
printf "%100s\n" "=================================== Services coming up, waiting .... =="
for e in OnBuild Prod;
do
  for i in {0..49};
  do
    until $(curl --output /dev/null --silent --head --fail $(docker service inspect --format '{{range .Endpoint.Ports }}localhost:{{ .PublishedPort }}{{ end }}' ${e}_boot)); 
    do
      printf '.'; sleep 5
    done
    curl -s -o /dev/null $(docker service inspect --format '{{range .Endpoint.Ports }}localhost:{{ .PublishedPort }}{{ end }}' ${e}_boot); printf "%2s" "=_"
  done;
  echo ""
done
for e in OnBuild Prod;
do
  echo "$e URL: http://$(docker service inspect --format '{{range .Endpoint.Ports }}localhost:{{ .PublishedPort }}{{ end }}' ${e}_boot)";
done
