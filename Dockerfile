FROm maven:3.8.4-openjdk-11 AS build
WORKDIR /app
COPY pom.xml /app
RUN mvn dependency:go-offline
COPY src /app/src
RUN mvn clean package

#stage 2
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/*.war /app/app.war
EXPOSE 8080
CMD ["java", "-war", "app.war"]
