# 🔌 Service Port Configuration

## ✅ All Services Configured with Ports

All microservices have been configured with their dedicated ports for local development and deployment.

---

## 📋 Service Port Configuration

| Service | Port | Application Name | Config File |
|---------|------|------------------|-------------|
| **API Gateway** | **8080** | api-gateway | `services/api-gateway/src/main/resources/application.properties` |
| **Auth Service** | **8081** | auth-service | `services/auth-service/src/main/resources/application.properties` |
| **KYC Service** | **8082** | kyc-service | `services/kyc-service/src/main/resources/application.properties` |
| **Fraud Detection Service** | **8083** | fraud-detection-service | `services/fraud-detection-service/src/main/resources/application.properties` |
| **AI Intelligence Service** | **8084** | ai-intelligence-service | `services/ai-intelligence-service/src/main/resources/application.properties` |

---

## 🌐 Service URLs

### Local Development Access

```
API Gateway:           http://localhost:8080
Auth Service:          http://localhost:8081
KYC Service:           http://localhost:8082
Fraud Detection:       http://localhost:8083
AI Intelligence:       http://localhost:8084
```

---

## 🔧 Configuration Details

### API Gateway (Port 8080)
```properties
spring.application.name=api-gateway
server.port=8080
```
**Role**: API Gateway service - Routes and authenticates requests

### Auth Service (Port 8081)
```properties
spring.application.name=auth-service
server.port=8081
```
**Role**: Authentication & Authorization Service

### KYC Service (Port 8082)
```properties
spring.application.name=kyc-service
server.port=8082
```
**Role**: Know Your Customer Service with AI Integration

### Fraud Detection Service (Port 8083)
```properties
spring.application.name=fraud-detection-service
server.port=8083
```
**Role**: Real-time Fraud Detection Service

### AI Intelligence Service (Port 8084)
```properties
spring.application.name=ai-intelligence-service
server.port=8084
```
**Role**: AI/ML Service for Intelligence Operations

---

## ✨ Port Allocation Strategy

- **8080** - API Gateway (Primary entry point)
- **8081-8084** - Individual microservices (Sequential allocation)

This allocation ensures:
✅ Easy to remember port numbers
✅ No port conflicts
✅ Sequential organization for clarity
✅ Scalable for additional services (8085+)

---

## 🚀 Running Services Locally

### Build All Services
```bash
./mvnw clean install
```

### Run Individual Service
```bash
# API Gateway
./mvnw -pl services/api-gateway spring-boot:run

# Auth Service
./mvnw -pl services/auth-service spring-boot:run

# KYC Service
./mvnw -pl services/kyc-service spring-boot:run

# Fraud Detection Service
./mvnw -pl services/fraud-detection-service spring-boot:run

# AI Intelligence Service
./mvnw -pl services/ai-intelligence-service spring-boot:run
```

---

## 🔐 Service Communication

### Internal Service-to-Service Communication
Services can call each other using:
```
http://localhost:NNNN/api/endpoint
```

Where NNNN is the service's port from the table above.

### Example OpenFeign Client
```java
@FeignClient(name = "auth-service", url = "http://localhost:8081")
public interface AuthServiceClient {
    @GetMapping("/api/auth/validate")
    ResponseEntity<?> validateToken(@RequestHeader String token);
}
```

---

## 📝 Notes

- All ports are configured in `application.properties` for each service
- Ports can be overridden at runtime using:
  ```bash
  ./mvnw -pl services/X spring-boot:run -Dspring-boot.run.arguments="--server.port=NNNN"
  ```
- Each service must run on a unique port to avoid conflicts
- Port 8080 is reserved for the API Gateway (entry point)

---

## ✅ Configuration Status

- ✅ API Gateway configured on port 8080
- ✅ Auth Service configured on port 8081
- ✅ KYC Service configured on port 8082
- ✅ Fraud Detection Service configured on port 8083
- ✅ AI Intelligence Service configured on port 8084

**All services ready to run!** 🎉


