# 🔧 Troubleshooting Guide - Fintech AI System

**Last Updated**: March 11, 2026

---

## 🎯 Common Issues & Solutions

### 1. PostgreSQL Connection Issues

#### Problem: "Connection refused" or "FATAL: password authentication failed"

**Symptoms**:
```
org.postgresql.util.PSQLException: Connection to localhost:5432 refused.
Exception: org.postgresql.util.PSQLException: FATAL: password authentication failed for user "root"
```

**Solutions**:

**Option A: Verify PostgreSQL is Running**
```bash
# Check if PostgreSQL is running
brew services list | grep postgresql

# If not running, start it
brew services start postgresql

# Verify connection
psql -U postgres -c "SELECT version();"
```

**Option B: Recreate Database and User**
```bash
# Connect as postgres user
psql -U postgres

# Drop existing database (if exists)
DROP DATABASE IF EXISTS "fintech-ai-system";

# Drop user (if exists)
DROP USER IF EXISTS root;

# Create new user
CREATE USER root WITH PASSWORD 'Samarthk@91';

# Create database
CREATE DATABASE "fintech-ai-system" OWNER root;

# Grant privileges
GRANT ALL PRIVILEGES ON DATABASE "fintech-ai-system" TO root;
GRANT ALL ON SCHEMA public TO root;

# Exit
\q
```

**Option C: Run Setup Script Again**
```bash
# Full reset
psql -U postgres -f setup-database.sql

# Verify
psql -U root -d fintech-ai-system -c "SELECT now();"
```

---

### 2. Port Already in Use

#### Problem: "Address already in use" or "port 8080 is already in use"

**Symptoms**:
```
org.springframework.boot.web.server.PortInUseException: Port 8080 is already in use
```

**Solutions**:

**Option A: Find and Kill Process on Port**
```bash
# Find process using port 8080
lsof -i :8080

# Output example:
# COMMAND    PID     USER   FD   TYPE             DEVICE SIZE/OFF NODE NAME
# java     12345  username   XX   IPv6 0x123...  0t0  51234 localhost:8080

# Kill the process
kill -9 12345

# Verify port is free
lsof -i :8080  # Should show nothing
```

**Option B: Kill All Java Processes**
```bash
# This will stop all Java processes (use with caution!)
pkill -f java

# Wait a moment then start services again
sleep 2
```

**Option C: Change Service Port (Temporary)**
Edit `services/kyc-service/src/main/resources/application.properties`:
```properties
server.port=8090  # Changed from 8082
```

---

### 3. Maven Build Failures

#### Problem: "BUILD FAILURE" or dependency download errors

**Symptoms**:
```
[ERROR] Could not resolve dependencies for project
[ERROR] Failed to execute goal org.apache.maven.plugins:maven-compiler-plugin
```

**Solutions**:

**Option A: Clean Maven Cache and Rebuild**
```bash
# Remove Maven repository
rm -rf ~/.m2/repository

# Rebuild with force update
./mvnw clean package -U -DskipTests

# If still failing, try offline mode
./mvnw clean package -DskipTests -o
```

**Option B: Check Java Version**
```bash
# Verify Java 21 is installed
java -version  # Should show openjdk version "21" or similar

# If wrong version, install Java 21
# macOS with Homebrew
brew install openjdk@21
```

**Option C: Update Maven Wrapper**
```bash
# Go to project root
cd /Users/samarthkamble/Freelance/fintech-ai-system

# Make mvnw executable
chmod +x mvnw

# Check Maven version
./mvnw --version  # Should be 3.6.0 or higher
```

**Option D: Skip Tests if Tests Fail**
```bash
# Build without running tests
./mvnw clean package -DskipTests

# If you need to run tests separately
./mvnw test -pl services/kyc-service
```

---

### 4. KYC Service Startup Error

#### Problem: "No qualifying bean of type 'EmbeddingModel'"

**Symptoms**:
```
Parameter 1 of method vectorStore in org.springframework.ai.vectorstore.pgvector.autoconfigure.PgVectorStoreAutoConfiguration required a bean of type 'org.springframework.ai.embedding.EmbeddingModel' that could not be found.
```

**Cause**: Spring AI PgVector is configured but no embedding model provider is set up.

**Solutions**:

**Option A: This is Expected (Current Setup) ✅**
The KYC service has this disabled intentionally:
```properties
# In services/kyc-service/src/main/resources/application.properties
spring.autoconfigure.exclude=org.springframework.ai.vectorstore.pgvector.autoconfigure.PgVectorStoreAutoConfiguration
```

This is correct - the service will start without this error.

**Option B: When Ready to Use AI Embeddings**

1. Add OpenAI dependency to `services/kyc-service/pom.xml`:
```xml
<dependency>
    <groupId>org.springframework.ai</groupId>
    <artifactId>spring-ai-starter-openai</artifactId>
</dependency>
```

2. Remove the exclusion from `application.properties`:
```bash
# Delete or comment out this line:
# spring.autoconfigure.exclude=org.springframework.ai.vectorstore.pgvector.autoconfigure.PgVectorStoreAutoConfiguration
```

3. Add OpenAI configuration:
```properties
spring.ai.openai.api-key=${OPENAI_API_KEY}
spring.ai.openai.embedding.options.model=text-embedding-3-small
```

4. Rebuild and restart:
```bash
./mvnw -pl services/kyc-service clean package -DskipTests
./mvnw -pl services/kyc-service spring-boot:run
```

---

### 5. Database Table Not Creating

#### Problem: Tables not created even with `ddl-auto=update`

**Symptoms**:
- Service starts but no tables in database
- `SELECT * FROM users` returns "table does not exist"

**Solutions**:

**Option A: Verify JPA is Configured**
```bash
# Check application.properties has JPA configuration
grep -A 5 "jpa" services/kyc-service/src/main/resources/application.properties
```

**Should show**:
```properties
spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=false
spring.jpa.properties.hibernate.format_sql=true
```

**Option B: Force Table Creation**
```bash
# Change ddl-auto to 'create' temporarily
# Edit application.properties:
spring.jpa.hibernate.ddl-auto=create  # Changed from update

# Rebuild and run
./mvnw clean package -DskipTests
./mvnw -pl services/kyc-service spring-boot:run

# Wait for startup complete, then change back to 'update'
spring.jpa.hibernate.ddl-auto=update  # Change back

# Rebuild and restart
./mvnw clean package -DskipTests
./mvnw -pl services/kyc-service spring-boot:run
```

**Option C: Check Entities Are Scanned**
In your application class, add:
```java
@SpringBootApplication
@EntityScan("com.fintech.kyc_service.entity")  // Add this
@EnableJpaRepositories("com.fintech.kyc_service.repository")  // Add this
public class KycServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(KycServiceApplication.class, args);
    }
}
```

---

### 6. Service Not Starting - Logs Show No Error

#### Problem: Service seems to hang or start silently without error

**Solutions**:

**Option A: Check Actual Logs**
```bash
# Run service and capture full output
./mvnw -pl services/kyc-service spring-boot:run 2>&1 | tee kyc-service.log

# In another terminal, monitor the log
tail -f kyc-service.log

# Look for:
# - "Tomcat started on port 8082"
# - "Started KycServiceApplication in X.XXX seconds"
```

**Option B: Enable Debug Logging**
Add to `application.properties`:
```properties
logging.level.root=DEBUG
logging.level.org.springframework.boot=DEBUG
logging.level.org.springframework.web=DEBUG
```

**Option C: Check if Port is Actually Open**
```bash
# While service is "running"
lsof -i :8082

# Or use curl
curl -v http://localhost:8082/actuator/health

# Should return HTTP response, not connection refused
```

---

### 7. API Gateway Not Routing Correctly

#### Problem: Routes return 404 or "Cannot connect"

**Symptoms**:
```
curl http://localhost:8080/api/kyc/status
# Returns: 404 Not Found
```

**Solutions**:

**Option A: Verify Gateway Configuration**
```bash
# Check application.properties
cat services/api-gateway/src/main/resources/application.properties
```

Should include routes like:
```properties
spring.cloud.gateway.routes[0].id=auth-service
spring.cloud.gateway.routes[0].uri=http://localhost:8081
spring.cloud.gateway.routes[0].predicates[0]=Path=/api/auth/**
```

**Option B: Verify Backend Services Are Running**
```bash
# Check if each service is running on its port
curl -i http://localhost:8081/actuator/health
curl -i http://localhost:8082/actuator/health
curl -i http://localhost:8083/actuator/health
curl -i http://localhost:8084/actuator/health

# All should return HTTP 200 OK
```

**Option C: Test Direct Connection First**
```bash
# Test service directly without gateway
curl -i http://localhost:8082/api/kyc/status

# If this works, the service is fine
# If it returns 404, the service doesn't have that endpoint
```

**Option D: Enable Gateway Debugging**
Add to gateway's `application.properties`:
```properties
logging.level.org.springframework.cloud.gateway=DEBUG
spring.cloud.gateway.routes.debug=true
```

---

### 8. OutOfMemory Error

#### Problem: "java.lang.OutOfMemoryError: Java heap space"

**Solutions**:

**Option A: Increase Heap Size**
```bash
# For running with Maven
./mvnw -pl services/kyc-service spring-boot:run \
  -Dspring-boot.run.jvmArguments="-Xmx2g -Xms1g"

# For running JAR directly
java -Xmx2g -Xms1g -jar target/kyc-service-1.0.0.jar
```

**Option B: Check Running Memory**
```bash
# See memory usage of all Java processes
jps -l  # List Java processes
jstat -gc <process_id>  # Show GC stats
```

---

### 9. Hibernate SQL Errors

#### Problem: "Relation does not exist" or SQL syntax errors

**Symptoms**:
```
ERROR: relation "users" does not exist
ERROR: column "password_hash" does not exist
```

**Solutions**:

**Option A: Check Entity Mapping**
Ensure entity class matches database:
```java
@Entity
@Table(name = "users")  // Ensure table name is correct
public class User {
    @Column(name = "password_hash")  // Ensure column name is correct
    private String passwordHash;
}
```

**Option B: Recreate Database**
```bash
# Drop and recreate
psql -U postgres -f setup-database.sql

# Change ddl-auto to 'create' to rebuild schema
spring.jpa.hibernate.ddl-auto=create

# Run service once
./mvnw -pl services/kyc-service spring-boot:run

# Change back to 'update'
spring.jpa.hibernate.ddl-auto=update
```

---

### 10. Network/Connectivity Issues

#### Problem: Services can't communicate with each other

**Symptoms**:
```
Connection refused to 127.0.0.1:8081
Cannot connect to auth-service
```

**Solutions**:

**Option A: Verify localhost Binding**
All services should bind to `localhost:port`:
```properties
# In each application.properties
server.port=8081
server.address=localhost
```

**Option B: Test Connectivity**
```bash
# From one service to another
curl http://localhost:8081/actuator/health
curl http://localhost:8082/actuator/health

# From gateway to backend
curl http://localhost:8080/api/auth/status
```

**Option C: Check Firewall**
```bash
# macOS firewall check
sudo pfctl -s all  # Show firewall rules

# Usually localhost should be allowed, but verify:
# - Port 8080-8084 are open
# - localhost (127.0.0.1) is not blocked
```

---

## 📊 Diagnostic Checklist

Use this checklist to diagnose issues:

```bash
# 1. Check PostgreSQL
brew services list | grep postgresql  # ✅ Must be running
psql -U postgres -c "SELECT version();"  # ✅ Should connect

# 2. Check Database
psql -U root -d fintech-ai-system -c "SELECT current_database();"  # ✅ Should be fintech-ai-system

# 3. Check Java
java -version  # ✅ Should be 21+

# 4. Check Maven
./mvnw --version  # ✅ Should be 3.6.0+

# 5. Check Ports
lsof -i :8080  # ✅ Should show process or be free
lsof -i :8081  # ✅ Should show process or be free
lsof -i :8082  # ✅ Should show process or be free

# 6. Check Services
curl -i http://localhost:8080/actuator/health  # ✅ Should return 200 OK
curl -i http://localhost:8081/actuator/health  # ✅ Should return 200 OK
curl -i http://localhost:8082/actuator/health  # ✅ Should return 200 OK

# 7. Check Build
./mvnw clean package -DskipTests  # ✅ Should show BUILD SUCCESS
```

---

## 🆘 Still Having Issues?

1. **Check Logs**: Most information is in the startup logs
   ```bash
   ./mvnw -pl services/kyc-service spring-boot:run 2>&1 | head -50
   ```

2. **Enable Debug Mode**:
   ```bash
   ./mvnw -pl services/kyc-service spring-boot:run --debug
   ```

3. **Check Documentation**:
   - `/docs/SETUP_VALIDATION_REPORT.md` - Full system validation
   - `/docs/getting-started/QUICK_START.md` - Getting started guide
   - Service-specific READMEs in each service folder

4. **Verify Configuration**:
   ```bash
   # View current configuration being used
   cat services/kyc-service/src/main/resources/application.properties
   ```

---

**Good luck! 🚀**

For more information, consult the main documentation in `/docs/`

