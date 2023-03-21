FROM maven:3.9.0-eclipse-temurin-17 as build
COPY pom.xml pom.xml
RUN --mount=type=cache,target=/root/.m2 mvn dependency:go-offline
COPY src src
RUN --mount=type=cache,target=/root/.m2 mvn package

FROM eclipse-temurin:17.0.6_10-jdk-jammy
COPY --from=build "./target/*.jar" /app.jar
RUN addgroup --system springboot && adduser --system sbuser && adduser sbuser springboot
USER sbuser
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app.jar"]