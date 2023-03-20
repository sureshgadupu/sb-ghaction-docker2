FROM maven:3.9.0-eclipse-temurin-11 as build
COPY pom.xml ./
COPY src src
RUN mvn --batch-mode clean package -DskipTests

FROM eclipse-temurin:11.0.18_10-jdk-focal
COPY --from=build "./target/*.jar" /app.jar
RUN addgroup --system springboot && adduser --system sbuser && adduser sbuser springboot
USER sbuser
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app.jar"]