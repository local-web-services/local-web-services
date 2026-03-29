## 1. Management API — chaos injection
- [ ] 1.1 Add `ChaosConfig` record (`double errorRate`, `int latencyMs`) to management types package
- [ ] 1.2 Add `Map<String, ChaosConfig> chaosConfigs` to server state
- [ ] 1.3 Add `GET /chaos/{service}`, `PUT /chaos/{service}`, `DELETE /chaos/{service}` routes to management controller
- [ ] 1.4 Add chaos interceptor helper; wire into all provider handler `handle()` methods

## 2. Management API — per-service capacity
- [ ] 2.1 Add `CapacityConfig` record (`Integer slots`) to management types
- [ ] 2.2 Add `Map<String, CapacityConfig> capacityConfigs` to server state
- [ ] 2.3 Add `GET /capacity/{service}`, `PUT /capacity/{service}`, `DELETE /capacity/{service}` routes
- [ ] 2.4 Add `isCapacityExhausted(String service)` helper method
- [ ] 2.5 Apply capacity guard to all 19 provider handlers

## 3. Management API — lifecycle rules
- [ ] 3.1 Add `LifecycleRule` record (`boolean enabled`, `int createDwellMs`, `int deleteDwellMs`)
- [ ] 3.2 Add lifecycle rules map to server state
- [ ] 3.3 Add `GET /lifecycle` and `POST /lifecycle` routes to management controller
- [ ] 3.4 Wire lifecycle dwell into cluster handlers (RDS, DocDB, Neptune, ElastiCache, MemoryDB)

## 4. Management API — fake server instances (`/_ldk/fake`)
- [ ] 4.1 Add `Map<String, String> fakeServers` (name → endpoint) to server state
- [ ] 4.2 Add `POST /fake`, `GET /fake`, `GET /fake/{name}` routes to management controller
- [ ] 4.3 Create `lang/java/core/src/main/java/io/localwebservices/lws/providers/fakeserver/` package with basic handler

## 5. Management API — state injection (`/_ldk/state`)
- [ ] 5.1 Add `Map<String, String> injectedStates` (key: `service:resourceType:resourceId`) to server state
- [ ] 5.2 Add `GET /state/{service}/{resourceType}/{resourceId}`, `PUT`, `DELETE` routes
- [ ] 5.3 Wire `getInjectedState("stepfunctions", ...)` into StepFunctionsHandler
- [ ] 5.4 Wire `getInjectedState("lambda", ...)` into LambdaHandler

## 6. Provider handler parity (7 remaining providers)
- [ ] 6.1 `cognitoidp` — `RESET_REQUIRED` status; duplicate pool name guard; state-based operation guards
- [ ] 6.2 `dynamodb` — DynamoDB Streams support; lifecycle dwell; capacity enforcement
- [ ] 6.3 `eventbridge` — additional event target routing
- [ ] 6.4 `lambda` — DynamoDB Streams port; remove-permission; tag/untag; `PutFunctionConcurrency`
- [ ] 6.5 `memorydb` — expanded CRUD coverage (compare to Go MemoryDB handler)
- [ ] 6.6 `sns` — SNS→SQS and SNS→EventBus target notification dispatch
- [ ] 6.7 `sqs` — in-flight count; capacity enforcement

## 7. SDK Helpers
- [ ] 7.1 Add `setChaos(String service, double errorRate, int latencyMs)` to Java SDK
- [ ] 7.2 Add `resetChaos(String service)` to Java SDK
- [ ] 7.3 Add `getChaosStatus(String service)` to Java SDK
- [ ] 7.4 Add `injectState(String service, String resourceType, String resourceId, String state)` to Java SDK
- [ ] 7.5 Add `clearInjectedState(String service, String resourceType, String resourceId)` to Java SDK
- [ ] 7.6 Add `client("fake")` / `client("aws_fake")` support to Java SDK session

## 8. GitHub Actions — E2E suite parallelization
- [ ] 8.1 Add `java-sdk-e2e-suites` discovery job to `.github/workflows/ci.yml`
- [ ] 8.2 Add `java-sdk-e2e-test` matrix job with `fail-fast: false`
- [ ] 8.3 Verify `make e2e-test SUITE=<suite>` works in `lang/java/sdk/` (add to Makefile if missing)
- [ ] 8.4 Confirm existing `java-sdk-lint` / `java-sdk-architecture-test` jobs are preserved

## 9. Tests and Verification
- [ ] 9.1 Add unit tests for chaos config in `lang/java/core/src/unitTest/`
- [ ] 9.2 Add unit tests for capacity enforcement
- [ ] 9.3 Add unit tests for state injection
- [ ] 9.4 Verify `chaos`, `aws_fake`, `fake` BDD step files in `lang/java/sdk/` are not stubs
- [ ] 9.5 Run `./gradlew test` in `lang/java/core/` — all green
- [ ] 9.6 Run `make e2e-test` in `lang/java/sdk/` — all suites green
