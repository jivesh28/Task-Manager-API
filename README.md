## Task Manager API (Spring Boot)

### Prerequisites
- Java 21 (Temurin/Zulu recommended)
- Maven (wrapper included: `./mvnw`)

### Build & Run
```bash
./mvnw spring-boot:run
```

### Health check
```bash
curl http://localhost:8080/actuator/health
```

### Project structure
- `src/main/java` — application code
- `src/main/resources/application.yaml` — baseline config
- `pom.xml` — dependencies and plugins

### Notes
- DevTools is included for local hot reload.
- Actuator exposes `health` and `info` endpoints by default.


