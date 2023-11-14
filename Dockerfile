FROM maven:3.8.3-openjdk-17 AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package -DskipTests

FROM amazoncorretto:17-alpine3.17-jdk
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
COPY opentelemetry-javaagent.jar ./opentelemetry-javaagent.jar
#COPY opentelemetry-javaagent-all.jar ./opentelemetry-javaagent-all.jar
EXPOSE 8080

ENTRYPOINT ["java", "-Dserver.port=8080", "-javaagent:opentelemetry-javaagent.jar","-jar", "app.jar"]

# ENTRYPOINT ["java", "-Dserver.port=8080", "-javaagent:opentelemetry-javaagent.jar", "-Dotel.traces.exporter=jaeger", "-Dotel.exporter.jaeger.endpoint=http://tempo.tracing.svc:14250" , "-Dotel.resource.attributes=service.name=new-days", "-Dotel.exporter.jaeger.timeout=30000", "-Dotel.javaagent.debug=false", "-jar", "app1.jar"]