# Multi-stage Dockerfile for Spring Boot (Java 17)
# Build stage: use Maven with Temurin JDK 17
FROM maven:3.9.8-eclipse-temurin-17 AS build
WORKDIR /app

# Leverage Docker layer caching: copy only pom first
COPY pom.xml ./
RUN mvn -B -q -e -DskipTests dependency:go-offline

# Then copy sources and build
COPY src ./src
RUN mvn -B -DskipTests clean package

# Runtime stage: slim JRE 17
FROM eclipse-temurin:17-jre-jammy AS runtime
WORKDIR /app

# Create non-root user
RUN groupadd -g 1001 app && useradd -r -g app -u 1001 app

# Copy the fat jar from build stage
COPY --from=build /app/target/*.jar /app/app.jar

# Default Spring Boot port
EXPOSE 8080

# Optional JVM flags via JAVA_OPTS and active profile via SPRING_PROFILES_ACTIVE
ENV JAVA_OPTS="" \
    SPRING_PROFILES_ACTIVE="default"

USER app

ENTRYPOINT ["sh", "-c", "exec java $JAVA_OPTS -jar /app/app.jar"]
