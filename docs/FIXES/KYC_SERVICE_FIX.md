# KYC Service Startup Error - Fix Documentation

## Issue Summary
The KYC Service was failing to start with the following error:
```
Parameter 1 of method vectorStore in org.springframework.ai.vectorstore.pgvector.autoconfigure.PgVectorStoreAutoConfiguration required a bean of type 'org.springframework.ai.embedding.EmbeddingModel' that could not be found.
```

## Root Cause
The pom.xml for kyc-service includes the Spring AI PgVector vector store dependency:
```xml
<dependency>
    <groupId>org.springframework.ai</groupId>
    <artifactId>spring-ai-starter-vector-store-pgvector</artifactId>
</dependency>
```

However, no `EmbeddingModel` bean was configured in the application. Spring Boot's auto-configuration was trying to auto-configure the PgVectorStore but failed because the required EmbeddingModel bean was missing.

## Solution Applied
Added the following property to `application.properties` to disable the PgVectorStoreAutoConfiguration:

```properties
# Disable PgVector Auto-configuration if EmbeddingModel is not configured
spring.autoconfigure.exclude=org.springframework.ai.vectorstore.pgvector.autoconfigure.PgVectorStoreAutoConfiguration
```

This tells Spring Boot to skip auto-configuring PgVectorStore when an EmbeddingModel bean is not available.

## When to Remove This Fix
If you plan to use the PgVector vector store with an embedding model (e.g., OpenAI, Hugging Face), you will need to:

1. Configure an `EmbeddingModel` bean (e.g., OpenAI Embedding API)
2. Add the corresponding Spring AI starter dependency
3. Remove the `spring.autoconfigure.exclude` property from application.properties

### Example: Adding OpenAI Embedding Model
1. Add dependency to pom.xml:
```xml
<dependency>
    <groupId>org.springframework.ai</groupId>
    <artifactId>spring-ai-starter-openai</artifactId>
</dependency>
```

2. Add configuration to application.properties:
```properties
spring.ai.openai.api-key=${OPENAI_API_KEY}
spring.ai.openai.embedding.options.model=text-embedding-3-small
```

3. Remove the exclusion property from application.properties

## File Modified
- `/services/kyc-service/src/main/resources/application.properties`

## Testing
After applying this fix, the KYC service should start successfully on port 8082 without the embedding model dependency error.

