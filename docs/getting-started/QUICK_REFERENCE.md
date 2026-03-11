# 🚀 QUICK REFERENCE - Maven Monorepo Cheat Sheet

## Folder Structure
```
fintech-ai-system/
├── pom.xml                    ← ROOT PARENT (update versions here!)
├── services/
│   ├── api-gateway/pom.xml
│   ├── auth-service/pom.xml
│   ├── kyc-service/pom.xml
│   ├── fraud-detection-service/pom.xml
│   └── ai-intelligence-service/pom.xml
└── shared/
    └── common-lib/pom.xml
```

---

## Most Important Files

| File | Purpose |
|------|---------|
| `pom.xml` | Version management, properties, plugins |
| `MONOREPO_SETUP.md` | Setup guide |
| `MAVEN_SETUP_REPORT.md` | Technical details |
| `STRUCTURE_REFERENCE.md` | Reference guide |

---

## Essential Maven Commands

```bash
# Build all services
./mvnw clean install

# Build one service only
./mvnw -pl services/auth-service clean install

# Build without tests (faster)
./mvnw clean install -DskipTests

# Run specific service
./mvnw -pl services/api-gateway spring-boot:run

# Validate POMs only
./mvnw validate
```

---

## Key Configuration in Root POM

```xml
<!-- Java Version -->
<java.version>21</java.version>

<!-- Spring Cloud Version -->
<spring-cloud.version>2025.1.0</spring-cloud.version>

<!-- Spring AI Version -->
<spring-ai.version>2.0.0-M2</spring-ai.version>
```

**Change versions here only!** All services inherit them.

---

## Service POM Template

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project>
    <modelVersion>4.0.0</modelVersion>
    
    <!-- Always point to root parent -->
    <parent>
        <groupId>com.fintech</groupId>
        <artifactId>fintech-ai-system</artifactId>
        <version>1.0.0</version>
        <relativePath>../../pom.xml</relativePath>
    </parent>
    
    <!-- Service-specific ID only -->
    <artifactId>my-service</artifactId>
    
    <!-- Add ONLY service-specific dependencies -->
    <dependencies>
        <!-- Your deps here -->
    </dependencies>
    
    <!-- NO build section needed - inherited from parent -->
</project>
```

---

## What Each Service Inherits

✓ Java 21 compiler settings
✓ Maven Compiler Plugin
✓ Spring Boot Maven Plugin
✓ Lombok annotation processor
✓ Spring Boot Test dependency
✓ Spring Cloud BOM (2025.1.0)
✓ Spring AI BOM (2.0.0-M2)

---

## Adding New Service

1. Create folder: `services/my-service/`
2. Create `pom.xml` with parent pointing to root
3. Add to root `pom.xml`:
   ```xml
   <module>services/my-service</module>
   ```
4. Test: `./mvnw validate`

---

## Troubleshooting

### "Can't find parent"
Check: `<relativePath>../../pom.xml</relativePath>` in service pom.xml

### "Dependency version not found"
Add to root `pom.xml` `<dependencyManagement>` section

### "Lombok not working"
Already configured in root pom - just use `@Data`, `@Slf4j`, etc.

### "Spring Cloud dependency not found"
It's in the BOM - just add without version:
```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-openfeign</artifactId>
</dependency>
```

---

## Service Ports

| Service | Port |
|---------|------|
| API Gateway | 8080 |
| Auth Service | 8081 |
| KYC Service | 8082 |
| Fraud Detection | 8083 |
| AI Intelligence | 8084 |

---

## Key Version Numbers

| Framework | Version |
|-----------|---------|
| Java | 21 |
| Spring Boot | 4.0.3 |
| Spring Cloud | 2025.1.0 |
| Spring AI | 2.0.0-M2 |

---

## File Sizes After Setup

| File | Size (lines) |
|------|--------------|
| Root pom.xml | 107 |
| api-gateway | 38 |
| auth-service | 43 |
| kyc-service | 46 |
| fraud-detection | 38 |
| ai-intelligence | 35 |
| common-lib | 26 |
| **TOTAL** | **~333** |

Compare to **600+** before! 🎉

---

## What NOT to Do

❌ Don't add Java version to service POMs
❌ Don't duplicate properties
❌ Don't create <build> sections in services
❌ Don't specify versions for Spring Boot starters
❌ Don't add Lombok as test dependency
❌ Don't create dependencyManagement in services

**Everything is inherited from root!**

---

## What TO Do

✅ Add service-specific dependencies only
✅ Use meaningful artifact IDs
✅ Keep service POMs simple
✅ Update versions in root pom.xml
✅ Add new modules to root pom.xml
✅ Reference parent with correct relative path

---

## Status Check

Run this to verify everything is working:
```bash
./mvnw validate
```

If you see no errors, you're good! ✅

---

## Support Documents

Need help? Check these files in docs folder:
- **Setup Questions?** → docs/setup/MONOREPO_SETUP.md
- **Technical Details?** → docs/setup/MAVEN_SETUP_REPORT.md
- **Structure Questions?** → docs/architecture/STRUCTURE_REFERENCE.md
- **What Changed?** → docs/setup/CHANGELOG.md

---

**Your monorepo is production-ready!** 🚀

