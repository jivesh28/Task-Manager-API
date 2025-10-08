## Task Manager API (Spring Boot)

### Prerequisites
- Docker (and Docker Compose optional)

### Build & Run (Docker)
```bash
# build image
docker build -t task-manager-api:latest .

# run
docker run --rm -p 8080:8080 task-manager-api:latest
```

### Advanced run (profiles, JVM flags)
```bash
docker run --rm -p 8080:8080 \
  -e SPRING_PROFILES_ACTIVE=prod \
  -e JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75 -XX:InitialRAMPercentage=50 -XX:MaxMetaspaceSize=256m" \
  task-manager-api:latest
```

### Externalized configuration
```bash
# Mount a local config directory and point Spring to it
mkdir -p config
# Put application-*.yaml in ./config

docker run --rm -p 8080:8080 \
  -v $PWD/config:/config \
  -e SPRING_CONFIG_ADDITIONAL_LOCATION=file:/config/ \
  task-manager-api:latest
```

### Health check
```bash
curl http://localhost:8080/actuator/health
```

### Project structure
- `src/main/java` — application code
- `src/main/resources/application.yaml` — baseline config
- `pom.xml` — dependencies and plugins
- `Dockerfile` — container build
- `.dockerignore` — excludes for Docker context

### Notes
- DevTools is available but not used in container by default.
- Actuator exposes `health` and `info` endpoints by default.


