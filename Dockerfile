FROM eclipse-temurin:17.0.6_10-jdk-jammy
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
RUN addgroup --system springboot && adduser --system sbuser && adduser sbuser springboot
USER sbuser
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]