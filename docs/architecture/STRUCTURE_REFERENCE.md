# 🏗️ Monorepo Structure & Configuration Reference

## File Structure Overview

```
fintech-ai-system/                          ← Root directory
│
├── pom.xml                                 ← ROOT PARENT POM (1.0.0)
├── docs/                                   ← DOCUMENTATION FOLDER
│   ├── README.md                           ← Documentation index
│   ├── getting-started/
│   │   ├── QUICK_REFERENCE.md             ← 2-minute cheat sheet
│   │   ├── README_DOCUMENTATION.md        ← Navigation guide
│   │   └── COMPLETE_CHECKLIST.md          ← Verification checklist
│   ├── setup/
│   │   ├── MONOREPO_SETUP.md              ← Setup overview
│   │   ├── MAVEN_SETUP_REPORT.md          ← Technical report
│   │   └── CHANGELOG.md                   ← What changed
│   └── architecture/
│       ├── STRUCTURE_REFERENCE.md         ← Config reference (this file)
│       └── MAVEN_MONOREPO_ARCHITECTURE.md ← Advanced patterns
│
├── services/                               ← All microservices
│   │
│   ├── api-gateway/                        ← API Gateway Service
│   │   ├── pom.xml                         ✓ Parent: fintech-ai-system
│   │   ├── src/main/java/...
│   │   └── mvnw
│   │
│   ├── auth-service/                       ← Authentication Service
│   │   ├── pom.xml                         ✓ Parent: fintech-ai-system
│   │   ├── src/main/java/...
│   │   └── mvnw
│   │
│   ├── kyc-service/                        ← KYC Service
│   │   ├── pom.xml                         ✓ Parent: fintech-ai-system
│   │   ├── src/main/java/...
│   │   └── mvnw
│   │
│   ├── fraud-detection-service/            ← Fraud Detection Service
│   │   ├── pom.xml                         ✓ Parent: fintech-ai-system
│   │   ├── src/main/java/...
│   │   └── mvnw
│   │
│   └── ai-intelligence-service/            ← AI Intelligence Service
│       ├── pom.xml                         ✓ Parent: fintech-ai-system
│       ├── src/main/java/...
│       └── mvnw
│
├── shared/                                 ← Shared libraries
│   └── common-lib/                         ← Common Library
│       ├── pom.xml                         ✓ Parent: fintech-ai-system
│       ├── src/main/java/...
│       └── mvnw
│
├── docker/                                 ← Docker configs
├── ml-model/                               ← ML Models
└── frontend/                               ← Frontend code
```

---

## Root POM Configuration

### 📌 Parent Declaration
```xml
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>4.0.3</version>
    <relativePath/>
</parent>
```

### 📌 Key Properties
```xml
<properties>
    <java.version>21</java.version>
    <spring-cloud.version>2025.1.0</spring-cloud.version>
    <spring-ai.version>2.0.0-M2</spring-ai.version>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
</properties>
```

### 📌 Modules Declaration
```xml
<modules>
    <module>services/api-gateway</module>
    <module>services/auth-service</module>
    <module>services/kyc-service</module>
    <module>services/fraud-detection-service</module>
    <module>services/ai-intelligence-service</module>
    <module>shared/common-lib</module>
</modules>
```

### 📌 Dependency Management (BOMs)
```xml
<dependencyManagement>
    <dependencies>
        <!-- Spring Cloud -->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-dependencies</artifactId>
            <version>${spring-cloud.version}</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
        <!-- Spring AI -->
        <dependency>
            <groupId>org.springframework.ai</groupId>
            <artifactId>spring-ai-bom</artifactId>
            <version>${spring-ai.version}</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>
```

### 📌 Common Dependencies
```xml
<dependencies>
    <!-- Lombok -->
    <dependency>
        <groupId>org.projectlombok</groupId>
        <artifactId>lombok</artifactId>
        <optional>true</optional>
    </dependency>
    <!-- Testing -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-test</artifactId>
        <scope>test</scope>
    </dependency>
</dependencies>
```

### 📌 Build Plugins
```xml
<build>
    <plugins>
        <!-- Spring Boot Maven Plugin -->
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
            <configuration>
                <excludes>
                    <exclude>
                        <groupId>org.projectlombok</groupId>
                        <artifactId>lombok</artifactId>
                    </exclude>
                </excludes>
            </configuration>
        </plugin>
        <!-- Maven Compiler Plugin -->
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <configuration>
                <source>${java.version}</source>
                <target>${java.version}</target>
                <annotationProcessorPaths>
                    <path>
                        <groupId>org.projectlombok</groupId>
                        <artifactId>lombok</artifactId>
                    </path>
                </annotationProcessorPaths>
            </configuration>
        </plugin>
    </plugins>
</build>
```

---

## Service POM Template

Every service follows this structure:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" 
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
                             https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <!-- PARENT CONFIGURATION -->
    <parent>
        <groupId>com.fintech</groupId>
        <artifactId>fintech-ai-system</artifactId>
        <version>1.0.0</version>
        <relativePath>../../pom.xml</relativePath>
    </parent>

    <!-- SERVICE IDENTIFICATION -->
    <artifactId>service-name</artifactId>
    <name>Service Display Name</name>
    <description>Service Description</description>

    <!-- SERVICE-SPECIFIC DEPENDENCIES ONLY -->
    <dependencies>
        <!-- Add only service-specific dependencies here -->
        <!-- Inherited from parent: lombok, spring-boot-starter-test -->
    </dependencies>

    <!-- ❌ NO BUILD SECTION NEEDED -->
    <!-- ❌ NO PLUGIN CONFIGURATION -->
    <!-- ❌ NO DUPLICATE PROPERTIES -->
    <!-- Everything is inherited from parent POM -->
</project>
```

---

## Service Details

### API Gateway
| Aspect | Value |
|--------|-------|
| Artifact ID | `api-gateway` |
| Port | 8080 (default) |
| Key Dependencies | Spring Cloud Gateway, Security, Actuator |
| Responsibility | Route requests to services |

### Auth Service
| Aspect | Value |
|--------|-------|
| Artifact ID | `auth-service` |
| Port | 8081 |
| Key Dependencies | JPA, Security, Validation, PostgreSQL |
| Responsibility | Authentication & Authorization |

### KYC Service
| Aspect | Value |
|--------|-------|
| Artifact ID | `kyc-service` |
| Port | 8082 |
| Key Dependencies | JPA, Spring AI, OpenFeign, PostgreSQL |
| Responsibility | Know Your Customer with AI |

### Fraud Detection Service
| Aspect | Value |
|--------|-------|
| Artifact ID | `fraud-detection-service` |
| Port | 8083 |
| Key Dependencies | JPA, Kafka, PostgreSQL |
| Responsibility | Real-time Fraud Detection |

### AI Intelligence Service
| Aspect | Value |
|--------|-------|
| Artifact ID | `ai-intelligence-service` |
| Port | 8084 |
| Key Dependencies | JPA, PostgreSQL |
| Responsibility | AI/ML Operations |

### Common Library
| Aspect | Value |
|--------|-------|
| Artifact ID | `common-lib` |
| Type | Shared Library |
| Key Dependencies | Spring Boot Starter |
| Responsibility | Shared utilities & code |

---

## Maven Commands Reference

### Build Operations
```bash
# Build entire project
./mvnw clean install

# Build specific service
./mvnw clean install -pl services/api-gateway

# Build multiple services
./mvnw clean install -pl services/api-gateway,services/auth-service

# Skip tests
./mvnw clean install -DskipTests

# Force update snapshots
./mvnw clean install -U
```

### Validation
```bash
# Validate POMs
./mvnw validate

# Check for dependency updates
./mvnw versions:display-dependency-updates

# Analyze dependencies
./mvnw dependency:analyze
```

### Reporting
```bash
# Show effective POM
./mvnw help:effective-pom

# Show dependencies tree
./mvnw dependency:tree

# Generate dependency report
./mvnw dependency:aggregate-report
```

### Run Service
```bash
# Run specific service
./mvnw -pl services/api-gateway spring-boot:run

# Run with specific profile
./mvnw -pl services/api-gateway spring-boot:run -Dspring-boot.run.arguments="--spring.profiles.active=dev"
```

---

## Inheritance Flow

```
Spring Boot 4.0.3 (Provides: plugins, common config, defaults)
    ↓ inherits from
Fintech AI System 1.0.0 (Provides: Cloud/AI BOMs, shared deps, plugins)
    ↓ inherited by
┌──────────────────────────────────────────────────────┐
│ All 6 Services (Use: Parent config + specific deps)  │
│                                                      │
│ ├─ api-gateway (Adds: Cloud Gateway)                 │
│ ├─ auth-service (Adds: Security, JPA, Validation)    │
│ ├─ kyc-service (Adds: Spring AI, OpenFeign)          │
│ ├─ fraud-detection-service (Adds: Kafka)             │
│ ├─ ai-intelligence-service (Adds: JPA)               │
│ └─ common-lib (Adds: —)                              │
└──────────────────────────────────────────────────────┘
```

---

## Checklist for Adding New Services

When adding a new service to the monorepo:

- [ ] Create `services/new-service/` directory
- [ ] Create `pom.xml` with parent referencing root (version 1.0.0)
- [ ] Add only service-specific dependencies
- [ ] DO NOT duplicate parent config
- [ ] DO NOT create custom properties for common settings
- [ ] Update root `pom.xml` modules section:
  ```xml
  <module>services/new-service</module>
  ```
- [ ] Validate: `./mvnw validate`
- [ ] Test build: `./mvnw clean install -pl services/new-service`

---

## Troubleshooting

### Issue: "Can't find parent POM"
**Solution**: Check relative path in service `pom.xml`:
```xml
<relativePath>../../pom.xml</relativePath>
```

### Issue: "Version not found for dependency"
**Solution**: Check if dependency is in `dependencyManagement` in root POM. If not, add it.

### Issue: "Lombok not working"
**Solution**: Check if annotation processor is configured in root POM (it is, inherited by all).

### Issue: Spring Cloud/AI dependencies not resolved
**Solution**: Ensure BOMs are imported in `dependencyManagement` (they are).

---

## 📊 Comparison: Before vs After

| Metric | Before | After |
|--------|--------|-------|
| Root POM lines | ~20 | 107 |
| Avg service POM lines | 100+ | 30-40 |
| Duplicate properties | 6 copies | 1 source |
| Duplicate plugins | 6 configs | 1 config |
| Version update locations | 6 files | 1 file |
| Total POM lines | 600+ | 300+ |
| Code duplication | HIGH | MINIMAL |
| Maintenance effort | HIGH | LOW |

---

**Setup completed and documented!** 🎉

