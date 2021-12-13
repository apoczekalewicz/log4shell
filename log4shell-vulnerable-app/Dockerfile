FROM docker.io/library/gradle:7.3.1-jdk17-alpine AS builder
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle bootJar --no-daemon


FROM docker.io/library/openjdk:8u181-jdk-alpine
EXPOSE 8080
RUN mkdir /app && apk add bash curl
COPY --from=builder /home/gradle/src/build/libs/*.jar /app/spring-boot-application.jar
CMD ["java", "-jar", "/app/spring-boot-application.jar"]
