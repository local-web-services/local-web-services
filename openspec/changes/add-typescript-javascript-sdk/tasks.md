## Phase 1: TypeScript Core

### 1. Scaffold
- [ ] 1.1 Create `lang/typescript/core/` with `package.json`, `tsconfig.json`, `vitest.config.ts`, `Makefile`
- [ ] 1.2 Set up pnpm workspace root (`pnpm-workspace.yaml`) covering `lang/typescript/*` and `lang/javascript/*`
- [ ] 1.3 Add `lang/typescript/` to Bazel `MODULE.bazel`

### 2. Shared infrastructure
- [ ] 2.1 Implement provider lifecycle interface (`start`, `stop`, `healthCheck`, `flush`)
- [ ] 2.2 Implement Fastify plugin chain: RequestLogging → IamAuth → Chaos → OperationFake → route handler
- [ ] 2.3 Implement port allocator (base + offset, matching Python scheme)
- [ ] 2.4 Implement management API (`/_ldk/resources`, `/_ldk/status`, `/_ldk/invoke`, `/_ldk/reset`, `/_ldk/shutdown`)
- [ ] 2.5 Implement orchestrator (topological start/stop, health checks, signal handling)
- [ ] 2.6 Implement SDK env builder (`AWS_ENDPOINT_URL_*` vars)

### 3. Storage providers (20 services)
- [ ] 3.1 DynamoDB (better-sqlite3 backend)
- [ ] 3.2 SQS (in-memory)
- [ ] 3.3 S3 (filesystem)
- [ ] 3.4 SNS (in-memory)
- [ ] 3.5 EventBridge (in-memory, cron via `cron-parser`)
- [ ] 3.6 Step Functions (Amazon States Language interpreter)
- [ ] 3.7 Cognito IDP (better-sqlite3 backend, JWT via `jose`)
- [ ] 3.8 Lambda runtime (Python subprocess, Node.js subprocess, Docker)
- [ ] 3.9 API Gateway (CDK route proxy)
- [ ] 3.10 RDS (Docker-backed PostgreSQL)
- [ ] 3.11 DocumentDB (Docker-backed MongoDB)
- [ ] 3.12 SSM Parameter Store (in-memory)
- [ ] 3.13 Secrets Manager (in-memory)
- [ ] 3.14 ElastiCache (Docker-backed Redis)
- [ ] 3.15 Neptune (Docker-backed)
- [ ] 3.16 MemoryDB (Docker-backed Redis)
- [ ] 3.17 Glacier (filesystem)
- [ ] 3.18 Elasticsearch (Docker-backed)
- [ ] 3.19 OpenSearch (Docker-backed)
- [ ] 3.20 S3 Tables (filesystem)

### 4. CDK / Terraform parser
- [ ] 4.1 CloudFormation template parser (resource extraction)
- [ ] 4.2 CDK asset parser (Lambda code paths)
- [ ] 4.3 Ref/GetAtt/Sub intrinsic resolver
- [ ] 4.4 Terraform state reader

### 5. CLI
- [ ] 5.1 `ldk dev` command (start server)
- [ ] 5.2 `ldk stop`, `ldk invoke`, `ldk reset`
- [ ] 5.3 `lws` CLI client (service discovery + wire protocol helpers per service)

### 6. Tests
- [ ] 6.1 Unit tests for all providers (Vitest)
- [ ] 6.2 Integration tests using Fastify `inject()` transport (no running server)
- [ ] 6.3 Architecture tests (file naming, AAA comments, no magic strings)

### 7. CI
- [ ] 7.1 Add `typescript-core-lint`, `typescript-core-test-unit`, `typescript-core-test-architecture` jobs to `.github/workflows/ci.yml`

---

## Phase 2: TypeScript SDK + Example

### 8. TypeScript SDK (`lang/typescript/sdk/`)
- [ ] 8.1 Scaffold package: `package.json`, `tsconfig.json`, `vitest.config.ts`, `Makefile`
- [ ] 8.2 Implement `LwsSession` class (port allocation, provider start/stop, env injection)
- [ ] 8.3 Implement resource specs: `DynamoTable`, `SqsQueue`, `S3Bucket`, `SnsTopic`, `SsmParameter`, `Secret`, `StateMachine`
- [ ] 8.4 Implement `session.client(serviceName)` returning pre-configured `@aws-sdk` client
- [ ] 8.5 Implement `LwsSession.fromCdk()` and `LwsSession.fromHcl()` discovery
- [ ] 8.6 Implement Vitest fixture helpers (`lwsSession` fixture)
- [ ] 8.7 Implement management API client builders (chaos, fake, capacity, IAM)
- [ ] 8.8 Write e2e suites for all 20 services using cucumber-js + shared feature files
- [ ] 8.9 Architecture tests

### 9. TypeScript example (`lang/typescript/example/`)
- [ ] 9.1 Scaffold example app (order processing, same domain as Python example)
- [ ] 9.2 E2e acceptance tests via TypeScript SDK

### 10. CI
- [ ] 10.1 Add TypeScript SDK lint/unit/architecture/e2e jobs (matrix per suite)
- [ ] 10.2 Add TypeScript example lint/unit/e2e jobs

---

## Phase 3: JavaScript SDK + Example

### 11. JavaScript SDK (`lang/javascript/sdk/`)
- [ ] 11.1 Scaffold package: `package.json`, CJS + ESM dual build via `tsup`
- [ ] 11.2 Re-export all public symbols from `lang/typescript/sdk/`
- [ ] 11.3 Verify no `.d.ts` files in published JS package
- [ ] 11.4 Unit tests confirming CJS and ESM imports work
- [ ] 11.5 E2e smoke tests (subset of TypeScript e2e, plain JS)

### 12. JavaScript example (`lang/javascript/example/`)
- [ ] 12.1 Scaffold example app in plain JavaScript (no TypeScript)
- [ ] 12.2 E2e acceptance tests via JavaScript SDK

### 13. CI + Release
- [ ] 13.1 Add JavaScript SDK lint/unit/e2e jobs
- [ ] 13.2 Add `typescript-sdk/v*` and `javascript-sdk/v*` release workflows
- [ ] 13.3 Verify `lang/typescript/sdk/README.md` and `lang/javascript/sdk/README.md` match Python SDK README structure
