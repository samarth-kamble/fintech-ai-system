# 🚀 Fintech AI System - Quick Start Guide

**Last Updated**: March 11, 2026

---

## 📋 Table of Contents
1. [Prerequisites](#prerequisites)
2. [Database Setup](#database-setup)
3. [Build Instructions](#build-instructions)
4. [Running Services](#running-services)
5. [Testing Services](#testing-services)
6. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### Required Software
- **Java**: 21 or higher
- **Maven**: 3.6.0 or higher (included: mvnw wrapper)
- **PostgreSQL**: 13 or higher
- **Terminal/Shell**: zsh (macOS)

### Verify Installation
```bash
# Check Java version
java -version  # Should show Java 21+

# Check Maven (using wrapper)
./mvnw --version

# Check PostgreSQL
psql --version
```

### System Setup
Ensure PostgreSQL is running:
```bash
# macOS with Homebrew
brew services start postgresql
brew services list | grep postgresql  # Verify running

# Or check if PostgreSQL is running
psql -U postgres -c "SELECT version();"
```

---

## 🗄️ Database Setup

### Step 1: Execute Database Setup Script

```bash
# Navigate to project root
cd /Users/samarthkamble/Freelance/fintech-ai-system

# Run the database setup script
psql -U postgres -f setup-database.sql
```

### Step 2: Verify Database Creation

```bash
# Connect to the database
psql -U root -d fintech-ai-system

# You should see the prompt:
# fintech-ai-system=>

# Exit
\q
```

### Database Credentials Reference
| Property | Value |
|----------|-------|
| Host | localhost |
| Port | 5432 |
| Database | fintech-ai-system |
| Username | root |
| Password | Samarthk@91 |

---

## 🔨 Build Instructions

### Option 1: Build Entire Project

```bash
# Navigate to project root
cd /Users/samarthkamble/Freelance/fintech-ai-system

# Clean and build all modules
./mvnw clean package -DskipTests

# Expected output: BUILD SUCCESS
```

### Option 2: Build Specific Service

```bash
# Example: Build only KYC Service
./mvnw clean package -DskipTests -pl services/kyc-service

# Example: Build API Gateway
./mvnw clean package -DskipTests -pl services/api-gateway
```

### Build Troubleshooting
```bash
# If mvnw is not executable
chmod +x mvnw

# Clean Maven cache
./mvnw clean

# Force update dependencies
./mvnw -U clean package -DskipTests
```

---

## 🎯 Running Services

### Service Ports Reference
| Service | Port | Command |
|---------|------|---------|
| API Gateway | 8080 | `mvn -pl services/api-gateway spring-boot:run` |
| Auth Service | 8081 | `mvn -pl services/auth-service spring-boot:run` |
| KYC Service | 8082 | `mvn -pl services/kyc-service spring-boot:run` |
| Fraud Detection | 8083 | `mvn -pl services/fraud-detection-service spring-boot:run` |
| AI Intelligence | 8084 | `mvn -pl services/ai-intelligence-service spring-boot:run` |

### Option 1: Run All Services (Manual - Separate Terminals)

**Terminal 1 - API Gateway**
```bash
cd /Users/samarthkamble/Freelance/fintech-ai-system
./mvnw -pl services/api-gateway spring-boot:run
```

Wait for: `Started ApiGatewayApplication in X.XXX seconds`

**Terminal 2 - Auth Service**
```bash
cd /Users/samarthkamble/Freelance/fintech-ai-system
./mvnw -pl services/auth-service spring-boot:run
```

Wait for: `Started AuthServiceApplication in X.XXX seconds`

**Terminal 3 - KYC Service**
```bash
cd /Users/samarthkamble/Freelance/fintech-ai-system
./mvnw -pl services/kyc-service spring-boot:run
```

Wait for: `Started KycServiceApplication in X.XXX seconds`

**Terminal 4 - Fraud Detection Service**
```bash
cd /Users/samarthkamble/Freelance/fintech-ai-system
./mvnw -pl services/fraud-detection-service spring-boot:run
```

Wait for: `Started FraudDetectionServiceApplication in X.XXX seconds`

**Terminal 5 - AI Intelligence Service**
```bash
cd /Users/samarthkamble/Freelance/fintech-ai-system
./mvnw -pl services/ai-intelligence-service spring-boot:run
```

Wait for: `Started AiIntelligenceServiceApplication in X.XXX seconds`

### Option 2: Run Using Script (Recommended)

Create `run-all-services.sh`:

```bash
#!/bin/bash

cd /Users/samarthkamble/Freelance/fintech-ai-system

echo "🚀 Starting Fintech AI System Services..."

# Start API Gateway
echo "📍 Starting API Gateway (Port 8080)..."
./mvnw -pl services/api-gateway spring-boot:run &
API_GATEWAY_PID=$!

# Wait for gateway to start
sleep 5

# Start Auth Service
echo "📍 Starting Auth Service (Port 8081)..."
./mvnw -pl services/auth-service spring-boot:run &
AUTH_SERVICE_PID=$!

# Start KYC Service
echo "📍 Starting KYC Service (Port 8082)..."
./mvnw -pl services/kyc-service spring-boot:run &
KYC_SERVICE_PID=$!

# Start Fraud Detection Service
echo "📍 Starting Fraud Detection Service (Port 8083)..."
./mvnw -pl services/fraud-detection-service spring-boot:run &
FRAUD_SERVICE_PID=$!

# Start AI Intelligence Service
echo "📍 Starting AI Intelligence Service (Port 8084)..."
./mvnw -pl services/ai-intelligence-service spring-boot:run &
AI_SERVICE_PID=$!

echo ""
echo "✅ All services started!"
echo ""
echo "Process IDs:"
echo "  API Gateway: $API_GATEWAY_PID"
echo "  Auth Service: $AUTH_SERVICE_PID"
echo "  KYC Service: $KYC_SERVICE_PID"
echo "  Fraud Detection: $FRAUD_SERVICE_PID"
echo "  AI Intelligence: $AI_SERVICE_PID"
echo ""
echo "Services are running. Press Ctrl+C to stop all services."
echo ""

# Wait for all processes
wait
```

Make it executable and run:
```bash
chmod +x run-all-services.sh
./run-all-services.sh
```

---

## ✅ Testing Services

### 1. Check Service Health

```bash
# API Gateway Health
curl -s http://localhost:8080/actuator/health | jq '.'

# Auth Service Health (direct)
curl -s http://localhost:8081/actuator/health | jq '.'

# KYC Service Health (direct)
curl -s http://localhost:8082/actuator/health | jq '.'

# Fraud Detection Service Health (direct)
curl -s http://localhost:8083/actuator/health | jq '.'

# AI Intelligence Service Health (direct)
curl -s http://localhost:8084/actuator/health | jq '.'
```

### 2. Test API Gateway Routing

```bash
# Test Auth Service route through gateway
curl -i -X GET http://localhost:8080/api/auth/status

# Test KYC Service route through gateway
curl -i -X GET http://localhost:8080/api/kyc/status

# Test Fraud Service route through gateway
curl -i -X GET http://localhost:8080/api/fraud/status

# Test AI Service route through gateway
curl -i -X GET http://localhost:8080/api/ai/status
```

### 3. Check Database Connection

```bash
# Connect to the database
psql -U root -d fintech-ai-system

# List tables created by Hibernate
\dt

# Exit
\q
```

---

## 🔧 Troubleshooting

### Issue: "Address already in use" Error

```bash
# Find process using port
lsof -i :8080   # For port 8080
lsof -i :8081   # For port 8081

# Kill the process
kill -9 <PID>
```

### Issue: Database Connection Refused

```bash
# Verify PostgreSQL is running
brew services list | grep postgresql

# Start PostgreSQL
brew services start postgresql

# Verify database exists
psql -U postgres -l | grep fintech-ai-system

# If not found, run setup again
psql -U postgres -f setup-database.sql
```

### Issue: "No qualifying bean of type 'EmbeddingModel'"

**Status**: This is expected and intentional for KYC Service
- The service has the Spring AI PgVector dependency but no EmbeddingModel configured
- This is disabled in `application.properties` with:
  ```properties
  spring.autoconfigure.exclude=org.springframework.ai.vectorstore.pgvector.autoconfigure.PgVectorStoreAutoConfiguration
  ```
- When you integrate an AI provider (e.g., OpenAI), remove this line and configure the provider

### Issue: Maven Build Fails

```bash
# Clear Maven cache
rm -rf ~/.m2/repository

# Force clean build
./mvnw clean package -U -DskipTests

# Check Java version
java -version  # Should be 21+

# Check Maven version
./mvnw --version  # Should be 3.6.0+
```

### Issue: Port Already in Use

```bash
# Kill all Java processes
pkill -f java

# Or kill specific port
lsof -ti:8080 | xargs kill -9
```

### View Application Logs

```bash
# Redirect logs to file for debugging
./mvnw -pl services/kyc-service spring-boot:run > kyc-service.log 2>&1

# View logs in real-time
tail -f kyc-service.log
```

---

## 📊 Service Endpoints Overview

### API Gateway (Port 8080)
- **Health Check**: `GET /actuator/health`
- **Metrics**: `GET /actuator/metrics`

### Auth Service (Port 8081)
- **Route through gateway**: `GET /api/auth/**`
- **Direct access**: `GET http://localhost:8081/**`

### KYC Service (Port 8082)
- **Route through gateway**: `GET /api/kyc/**`
- **Direct access**: `GET http://localhost:8082/**`

### Fraud Detection Service (Port 8083)
- **Route through gateway**: `GET /api/fraud/**`
- **Direct access**: `GET http://localhost:8083/**`

### AI Intelligence Service (Port 8084)
- **Route through gateway**: `GET /api/ai/**`
- **Direct access**: `GET http://localhost:8084/**`

---

## 🎓 Environment Variables (Optional)

Create `.env` file in project root:

```bash
# Database Configuration
DB_HOST=localhost
DB_PORT=5432
DB_NAME=fintech-ai-system
DB_USER=root
DB_PASSWORD=Samarthk@91

# Service Ports
GATEWAY_PORT=8080
AUTH_PORT=8081
KYC_PORT=8082
FRAUD_PORT=8083
AI_PORT=8084

# Java Configuration
JAVA_VERSION=21
MAVEN_VERSION=3.6.0+
```

Load in your shell:
```bash
export $(cat .env | xargs)
```

---

## 📝 Next Steps

1. ✅ **Database Setup**: Run `psql -U postgres -f setup-database.sql`
2. ✅ **Build Project**: Run `./mvnw clean package -DskipTests`
3. ✅ **Run Services**: Start all services in separate terminals
4. ✅ **Test Services**: Run health checks and API tests
5. 🔄 **Develop Features**: Add your business logic to services
6. 📦 **Deploy**: Use Docker/Kubernetes for production

---

## 📞 Quick Reference Commands

```bash
# Build all
./mvnw clean package -DskipTests

# Build specific service
./mvnw -pl services/kyc-service clean package -DskipTests

# Run service
./mvnw -pl services/kyc-service spring-boot:run

# Run tests
./mvnw test

# View dependency tree
./mvnw dependency:tree

# Check for security vulnerabilities
./mvnw org.owasp:dependency-check-maven:check
```

---

**Happy Coding! 🎉**

For more details, check `/docs/SETUP_VALIDATION_REPORT.md`

