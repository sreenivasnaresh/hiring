# Stage 1: Build the application
FROM maven:3.8.4-openjdk-11 AS build
WORKDIR /app
COPY pom.xml /app/
RUN mvn dependency:go-offline
COPY src /app/src
RUN mvn clean package

# Stage 2: Create the final image
FROM tomcat:9-jre11-slim
WORKDIR /usr/local/tomcat/webapps
COPY --from=build /app/target/*.war .
EXPOSE 8080
CMD ["catalina.sh", "run"]
