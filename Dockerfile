FROM openjdk:8-jre-alpine

EXPOSE 8080

COPY ./target/jb-hello-world-maven-0.2.0.jar /usr/app/

WORKDIR /usr/app

ENTRYPOINT ["java", "-jar", "jb-hello-world-maven-0.2.0.jar"]
