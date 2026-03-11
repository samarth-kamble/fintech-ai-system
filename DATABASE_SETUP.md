# 🚀 Complete Database Setup Guide

## Overview

This guide walks you through setting up PostgreSQL for the Fintech AI System microservices.

---

## 📋 Database Credentials

```
Database Name: fintech-ai-system
Username: root
Password: Samarthk@91
Host: localhost
Port: 5432
```

---

## ⚙️ Step 1: Install PostgreSQL

### macOS (using Homebrew)
```bash
# Install PostgreSQL
brew install postgresql

# Start PostgreSQL service
brew services start postgresql

# Verify installation
psql --version
```

### Linux (Ubuntu/Debian)
```bash
# Install PostgreSQL
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib

# Start service
sudo systemctl start postgresql

# Verify
psql --version
```

### Windows
1. Download PostgreSQL from https://www.postgresql.org/download/windows/
2. Run the installer
3. Follow the installation wizard
4. Remember the postgres user password you set
5. PostgreSQL service will start automatically

---

## ⚙️ Step 2: Create Database and User

### Option A: Using the SQL Script (Easiest)

```bash
# From the root directory of fintech-ai-system
psql -U postgres -f setup-database.sql
```

You'll be prompted for the postgres password. Enter it and the script will:
- ✅ Create the database `fintech-ai-system`
- ✅ Create the user `root` with password `Samarthk@91`
- ✅ Grant all privileges

### Option B: Manual Setup (Step by Step)

```bash
# Connect to PostgreSQL as the default postgres user
psql -U postgres

# Inside psql, run these commands:
```

```sql
-- Create the database
CREATE DATABASE "fintech-ai-system";

-- Create the user
CREATE USER root WITH PASSWORD 'Samarthk@91';

-- Grant privileges on the database
GRANT ALL PRIVILEGES ON DATABASE "fintech-ai-system" TO root;

-- Connect to the database
\c fintech-ai-system

-- Grant schema privileges
GRANT ALL ON SCHEMA public TO root;

-- Set default privileges
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO root;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO root;

-- Verify (optional)
\du    -- Lists all users
\l     -- Lists all databases
\q     -- Quit psql
```

---

## ✅ Step 3: Verify Database Setup

### Test Connection Using psql

```bash
# Connect to the new database as root user
psql -U root -d fintech-ai-system -h localhost
```

If successful, you'll see:
```
psql (14.5)
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
Type "help" for help.

fintech-ai-system=>
```

Exit with `\q`

### Test Using PgAdmin (Optional)

1. Install PgAdmin: https://www.pgadmin.org/download/
2. Open PgAdmin
3. Create new server with:
   - Name: `fintech-ai-system`
   - Host: `localhost`
   - Port: `5432`
   - Username: `root`
   - Password: `Samarthk@91`
4. Connect and verify database exists

---

## 🔧 Step 4: Verify Service Configurations

All services already have database configuration in their `application.properties`:

### Auth Service (Port 8081)
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/fintech-ai-system
spring.datasource.username=root
spring.datasource.password=Samarthk@91
spring.datasource.driver-class-name=org.postgresql.Driver
spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.hibernate.ddl-auto=update
```

### KYC Service (Port 8082)
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/fintech-ai-system
spring.datasource.username=root
spring.datasource.password=Samarthk@91
spring.datasource.driver-class-name=org.postgresql.Driver
spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.hibernate.ddl-auto=update
```

### Fraud Detection Service (Port 8083)
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/fintech-ai-system
spring.datasource.username=root
spring.datasource.password=Samarthk@91
spring.datasource.driver-class-name=org.postgresql.Driver
spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.hibernate.ddl-auto=update
```

### AI Intelligence Service (Port 8084)
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/fintech-ai-system
spring.datasource.username=root
spring.datasource.password=Samarthk@91
spring.datasource.driver-class-name=org.postgresql.Driver
spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.hibernate.ddl-auto=update
```

---

## 🚀 Step 5: Run Services

### Build All Services
```bash
./mvnw clean install
```

### Run Individual Services

Terminal 1 - Start Auth Service:
```bash
./mvnw -pl services/auth-service spring-boot:run
```

Terminal 2 - Start KYC Service:
```bash
./mvnw -pl services/kyc-service spring-boot:run
```

Terminal 3 - Start Fraud Detection Service:
```bash
./mvnw -pl services/fraud-detection-service spring-boot:run
```

Terminal 4 - Start AI Intelligence Service:
```bash
./mvnw -pl services/ai-intelligence-service spring-boot:run
```

Terminal 5 - Start API Gateway:
```bash
./mvnw -pl services/api-gateway spring-boot:run
```

---

## ✅ Verification

### Check Logs for Database Connection

Look for messages like:
```
HikariPool-1 - Connected to database [fintech-ai-system]
```

### Verify Tables Created

Connect to database and check tables:
```bash
psql -U root -d fintech-ai-system -c "\dt"
```

This will list all tables created by Hibernate.

### Test Service Health

```bash
# Test API Gateway
curl http://localhost:8080/health

# Test Auth Service
curl http://localhost:8081/health

# Test KYC Service
curl http://localhost:8082/health

# Test Fraud Detection Service
curl http://localhost:8083/health

# Test AI Intelligence Service
curl http://localhost:8084/health
```

---

## 🔐 Security Best Practices

### Development
✅ Current setup is good for local development

### Production
❌ Do NOT use these credentials in production:

Instead use:
1. **Environment Variables**
   ```bash
   export SPRING_DATASOURCE_URL=jdbc:postgresql://db-server:5432/fintech-ai-system
   export SPRING_DATASOURCE_USERNAME=prod_user
   export SPRING_DATASOURCE_PASSWORD=strong-password-here
   ```

2. **Docker Secrets** (for containerized deployments)

3. **AWS RDS** with IAM authentication

4. **Azure Database for PostgreSQL** with managed identity

5. **Strong Passwords**: Use 20+ character strong passwords in production

---

## 🛠️ Troubleshooting

### Issue: "psql: command not found"
**Solution:** PostgreSQL not installed or not in PATH
```bash
# macOS
brew install postgresql

# Linux
sudo apt-get install postgresql

# Windows: Add PostgreSQL bin to PATH
```

### Issue: "FATAL: role 'root' does not exist"
**Solution:** Create the user
```sql
CREATE USER root WITH PASSWORD 'Samarthk@91';
```

### Issue: "FATAL: database 'fintech-ai-system' does not exist"
**Solution:** Create the database
```sql
CREATE DATABASE "fintech-ai-system";
```

### Issue: "password authentication failed"
**Solution:** 
1. Verify password is correct
2. Check pg_hba.conf configuration
3. Reset user password:
   ```sql
   ALTER USER root WITH PASSWORD 'Samarthk@91';
   ```

### Issue: "Connection refused"
**Solution:** PostgreSQL service not running
```bash
# macOS
brew services start postgresql

# Linux
sudo systemctl start postgresql

# Windows: Start PostgreSQL service from Services
```

### Issue: Service can't connect to database
**Solution:** Verify connection details in application.properties
- Host: `localhost`
- Port: `5432` (default PostgreSQL port)
- Database: `fintech-ai-system`
- Username: `root`
- Password: `Samarthk@91`

---

## 📊 Database Architecture

```
PostgreSQL Server
│
└── Database: fintech-ai-system
    │
    ├── Public Schema
    │   ├── auth_service_tables (users, roles, etc.)
    │   ├── kyc_service_tables (kyc documents, verification, etc.)
    │   ├── fraud_detection_tables (transactions, fraud alerts, etc.)
    │   └── ai_intelligence_tables (ml models, predictions, etc.)
    │
    └── User: root
        └── Permissions: ALL ON DATABASE fintech-ai-system
```

---

## 📝 Files Modified/Created

```
✅ services/auth-service/src/main/resources/application.properties
✅ services/kyc-service/src/main/resources/application.properties
✅ services/fraud-detection-service/src/main/resources/application.properties
✅ services/ai-intelligence-service/src/main/resources/application.properties
✅ setup-database.sql (new)
✅ docs/setup/DATABASE_CONFIGURATION.md (new)
```

---

## ✅ Checklist

- [ ] PostgreSQL installed and running
- [ ] Database `fintech-ai-system` created
- [ ] User `root` created with password `Samarthk@91`
- [ ] Permissions granted
- [ ] Connection verified with psql
- [ ] Services built with `./mvnw clean install`
- [ ] Services started and logs show database connection
- [ ] Tables created in database
- [ ] Health endpoints responding

---

## 🎉 You're Ready!

Your PostgreSQL database is fully configured and all services are ready to connect. Start the services and begin development!

---

## 📞 Quick Reference

| Command | Purpose |
|---------|---------|
| `psql -U postgres` | Connect as postgres user |
| `psql -U root -d fintech-ai-system` | Connect as root user |
| `\l` | List all databases |
| `\du` | List all users |
| `\dt` | List all tables |
| `\q` | Quit psql |
| `psql -U postgres -f setup-database.sql` | Run setup script |


