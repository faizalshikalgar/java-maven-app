FROM openjdk:8-jre-alpine

EXPOSE 8080

COPY ./target/jb-hello-world-maven-*.jar /usr/app/

WORKDIR /usr/app

CMD java -jar jb-hello-world-maven-*.jar

