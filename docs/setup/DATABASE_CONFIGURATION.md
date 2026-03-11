# 🗄️ PostgreSQL Database Configuration

## ✅ Database Setup Complete

All services have been configured to connect to a PostgreSQL database with the following credentials.

---

## 📋 Database Configuration Details

### Connection Information

| Property | Value |
|----------|-------|
| **Host** | localhost |
| **Port** | 5432 |
| **Database Name** | fintech-ai-system |
| **Username** | root |
| **Password** | Samarthk@91 |
| **Driver** | PostgreSQL JDBC |

---

## 🔧 Configuration in Services

All database services (auth-service, kyc-service, fraud-detection-service, ai-intelligence-service) are configured with:

```properties
# Database Configuration
spring.datasource.url=jdbc:postgresql://localhost:5432/fintech-ai-system
spring.datasource.username=root
spring.datasource.password=Samarthk@91
spring.datasource.driver-class-name=org.postgresql.Driver

# JPA Configuration
spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=false
spring.jpa.properties.hibernate.format_sql=true
```

---

## 📝 Service Configuration Files

The following services have been configured with PostgreSQL:

1. **Auth Service** (Port 8081)
   - File: `services/auth-service/src/main/resources/application.properties`
   - Status: ✅ Configured

2. **KYC Service** (Port 8082)
   - File: `services/kyc-service/src/main/resources/application.properties`
   - Status: ✅ Configured

3. **Fraud Detection Service** (Port 8083)
   - File: `services/fraud-detection-service/src/main/resources/application.properties`
   - Status: ✅ Configured

4. **AI Intelligence Service** (Port 8084)
   - File: `services/ai-intelligence-service/src/main/resources/application.properties`
   - Status: ✅ Configured

---

## 🚀 Setup Instructions

### Prerequisites

1. **PostgreSQL Installed**
   - Download from https://www.postgresql.org/download/
   - Version 12 or higher recommended

2. **PostgreSQL Running**
   - Ensure PostgreSQL server is running on port 5432
   - macOS: `brew services start postgresql`
   - Linux: `sudo systemctl start postgresql`
   - Windows: PostgreSQL service should be running

### Create Database

Open PostgreSQL command line or use a GUI tool (pgAdmin):

```sql
-- Connect as postgres user
psql -U postgres

-- Create database
CREATE DATABASE "fintech-ai-system";

-- Create user (if not exists)
CREATE USER root WITH PASSWORD 'Samarthk@91';

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE "fintech-ai-system" TO root;

-- Connect to the database
\c fintech-ai-system

-- Grant schema privileges
GRANT ALL ON SCHEMA public TO root;
```

---

## 📊 JPA Configuration Explained

| Property | Value | Purpose |
|----------|-------|---------|
| `ddl-auto` | `update` | Auto-update schema on startup |
| `show-sql` | `false` | Don't print SQL to console |
| `format_sql` | `true` | Format SQL output nicely |
| `database-platform` | `PostgreSQLDialect` | Use PostgreSQL dialect |

---

## 🔗 Database Connection URL

```
jdbc:postgresql://localhost:5432/fintech-ai-system
```

**Breakdown:**
- `jdbc:postgresql://` - PostgreSQL JDBC protocol
- `localhost:5432` - Host and port
- `/fintech-ai-system` - Database name

---

## ✅ Verification

### Test Database Connection

1. **Using psql (command line)**
   ```bash
   psql -U root -d fintech-ai-system -h localhost
   ```

2. **Using pgAdmin (GUI)**
   - Open pgAdmin
   - Create new server with connection details above
   - Connect and verify

3. **From Application**
   - Start the service: `./mvnw -pl services/auth-service spring-boot:run`
   - Check logs for successful connection
   - Look for: "HikariPool-1 - Connected to database"

---

## 🔐 Security Notes

⚠️ **Important Security Considerations:**

1. **Don't commit credentials to Git**
   - Use environment variables in production
   - Create `.env` file for local development (add to `.gitignore`)

2. **Environment Variables Setup**
   ```bash
   export DB_URL=jdbc:postgresql://localhost:5432/fintech-ai-system
   export DB_USERNAME=root
   export DB_PASSWORD=Samarthk@91
   ```

3. **Production Setup**
   - Use strong passwords
   - Use Docker secrets or managed services
   - Consider using environment-specific profiles

---

## 🔄 Using Environment Variables

### Option 1: System Environment Variables
```bash
export SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/fintech-ai-system
export SPRING_DATASOURCE_USERNAME=root
export SPRING_DATASOURCE_PASSWORD=Samarthk@91

# Run service
./mvnw -pl services/auth-service spring-boot:run
```

### Option 2: application-dev.properties
Create separate profiles for different environments:

```properties
# application-dev.properties
spring.datasource.url=jdbc:postgresql://localhost:5432/fintech-ai-system
spring.datasource.username=root
spring.datasource.password=Samarthk@91
```

Run with profile:
```bash
./mvnw -pl services/auth-service spring-boot:run \
  -Dspring-boot.run.arguments="--spring.profiles.active=dev"
```

---

## 🛠️ Troubleshooting

### Error: "Connection refused"
**Solution:** Ensure PostgreSQL is running
```bash
# macOS
brew services start postgresql

# Linux
sudo systemctl start postgresql

# Check status
sudo systemctl status postgresql
```

### Error: "Database does not exist"
**Solution:** Create the database as shown above
```sql
CREATE DATABASE "fintech-ai-system";
```

### Error: "FATAL: Ident authentication failed"
**Solution:** Use password authentication in `pg_hba.conf`
```bash
# Edit postgresql config
sudo nano /etc/postgresql/XX/main/pg_hba.conf

# Change ident to md5 or scram-sha-256
# Restart PostgreSQL
sudo systemctl restart postgresql
```

### Error: "password authentication failed"
**Solution:** Verify credentials and user exists
```sql
-- Check if user exists
\du

-- Reset password if needed
ALTER USER root WITH PASSWORD 'Samarthk@91';
```

---

## 📊 Database Diagram

```
PostgreSQL Server (localhost:5432)
    │
    └── Database: fintech-ai-system
            │
            ├── Auth Service tables
            ├── KYC Service tables
            ├── Fraud Detection Service tables
            └── AI Intelligence Service tables
```

---

## 🚀 Next Steps

1. **Install PostgreSQL** (if not already installed)
2. **Create the database** using the SQL script above
3. **Verify connection** using connection test
4. **Start services** and verify database tables are created
5. **Begin development** with data persistence ready

---

## 📝 Configuration Files Modified

```
✅ services/auth-service/src/main/resources/application.properties
✅ services/kyc-service/src/main/resources/application.properties
✅ services/fraud-detection-service/src/main/resources/application.properties
✅ services/ai-intelligence-service/src/main/resources/application.properties
```

---

## ✅ Status

- ✅ All services configured for PostgreSQL
- ✅ Database credentials set
- ✅ JPA/Hibernate configured
- ✅ Ready for development
- ⏳ Waiting for database creation (follow instructions above)

**Ready to run!** 🎉


