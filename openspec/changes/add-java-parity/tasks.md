## 1. Management API — Chaos Endpoint
- [ ] 1.1 Add `ChaosConfig` record (`double errorRate`, `int latencyMs`) to management types package
- [ ] 1.2 Add chaos config `Map<String, ChaosConfig>` to server state
- [ ] 1.3 Add `GET /chaos/{service}`, `PUT /chaos/{service}`, `DELETE /chaos/{service}` routes to management controller
- [ ] 1.4 Add chaos interceptor that checks config before each provider dispatch

## 2. Management API — Fake Server Endpoint
- [ ] 2.1 Add `FakeServerRecord` record to management types
- [ ] 2.2 Add `GET /fake`, `POST /fake`, `GET /fake/{name}` routes to management controller
- [ ] 2.3 Create `lang/java/core/src/main/java/io/localwebservices/lws/providers/fakeserver/` package

## 3. Management API — Lifecycle Rules Endpoint
- [ ] 3.1 Add `LifecycleRule` record (`boolean enabled`, `int createDwellMs`, `int deleteDwellMs`)
- [ ] 3.2 Add lifecycle rules map to server state
- [ ] 3.3 Add `GET /lifecycle` and `POST /lifecycle` routes to management controller
- [ ] 3.4 Wire lifecycle enforcement into cluster provider handlers

## 4. Management API — State Injection Endpoint
- [ ] 4.1 Add injected-state map to server state
- [ ] 4.2 Add `GET /state/{service}/{resourceType}/{resourceId}`, `PUT`, `DELETE` routes to management controller
- [ ] 4.3 Wire state injection into StepFunctions and Lambda provider handlers

## 5. Capacity Enforcement
- [ ] 5.1 Add `CapacityConfig` record and per-service capacity map to server state
- [ ] 5.2 Add capacity guard helper method
- [ ] 5.3 Apply capacity guard to all provider handlers (DynamoDB, Lambda, SQS, SNS, StepFunctions, Glacier, S3Tables, SecretsMgr, SSM, ElastiCache, MemoryDB, Neptune, DocDB, RDS, OpenSearch, Elasticsearch)

## 6. SDK Helpers
- [ ] 6.1 Add `setChaos(String service, double errorRate, int latencyMs)` to Java SDK
- [ ] 6.2 Add `resetChaos(String service)` to Java SDK
- [ ] 6.3 Add `getChaosStatus(String service)` to Java SDK
- [ ] 6.4 Add `injectState(String service, String resourceType, String resourceId, String state)` to Java SDK
- [ ] 6.5 Add `clearInjectedState(String service, String resourceType, String resourceId)` to Java SDK
- [ ] 6.6 Add `client("fake")` and `client("aws_fake")` support to Java SDK session

## 7. Tests
- [ ] 7.1 Add unit tests for chaos config in `lang/java/core/src/unitTest/`
- [ ] 7.2 Add unit tests for capacity enforcement
- [ ] 7.3 Add unit tests for state injection
- [ ] 7.4 Verify `chaos`, `aws_fake`, `fake` BDD step definitions in `lang/java/sdk/src/test/` are not stubs
- [ ] 7.5 Run `./gradlew test` and confirm all suites green
