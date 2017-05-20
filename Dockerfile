FROM maven:onbuild AS buildenv

FROM openjdk:jre-alpine
COPY --from=buildenv /usr/src/app/target/hello-boot-1.jar /hello.jar
EXPOSE 8080
CMD ["java", "-jar", "/hello.jar"]
