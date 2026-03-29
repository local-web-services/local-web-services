## 1. Management API — Chaos Endpoint
- [ ] 1.1 Add `ChaosConfig` interface (`errorRate: number`, `latencyMs: number`) to TypeScript management types
- [ ] 1.2 Add in-memory chaos config store to server state
- [ ] 1.3 Add `GET/PUT/DELETE /_ldk/chaos/:service` route to management router
- [ ] 1.4 Add chaos middleware that intercepts provider requests based on config

## 2. Management API — Fake Server Endpoint
- [ ] 2.1 Add `FakeServerRecord` interface and store to server state
- [ ] 2.2 Add `GET/POST /_ldk/fake` and `GET /_ldk/fake/:name` routes to management router
- [ ] 2.3 Create `lang/typescript/core/src/providers/fakeserver/` provider module

## 3. Management API — State Injection Endpoint
- [ ] 3.1 Add injected-state map to server state
- [ ] 3.2 Add `GET/PUT/DELETE /_ldk/state/:service/:resourceType/:resourceId` routes to management router
- [ ] 3.3 Wire state injection into StepFunctions and Lambda providers

## 4. Lifecycle Rules (verify/implement)
- [ ] 4.1 Check if `/_ldk/lifecycle` exists in TypeScript — if not, port from Go/Python
- [ ] 4.2 Add `LifecycleRule` interface and storage if missing
- [ ] 4.3 Wire lifecycle enforcement into cluster provider handlers

## 5. Capacity Enforcement
- [ ] 5.1 Add `CapacityConfig` interface and per-service capacity map to server state
- [ ] 5.2 Add capacity guard helper function
- [ ] 5.3 Apply capacity guard to all provider handlers (DynamoDB, Lambda, SQS, SNS, StepFunctions, Glacier, S3Tables, SecretsMgr, SSM, ElastiCache, MemoryDB, Neptune, DocDB, RDS, OpenSearch, Elasticsearch)

## 6. APIGateway → Cognito Authorizer
- [ ] 6.1 Port `_apigateway_v1_authorizers.py` to TypeScript
- [ ] 6.2 Wire Cognito authorizer into APIGateway dispatch for V1 REST APIs

## 7. SDK Helpers
- [ ] 7.1 Add `setChaos(service, errorRate, latencyMs)` to TypeScript SDK
- [ ] 7.2 Add `resetChaos(service)` to TypeScript SDK
- [ ] 7.3 Add `getChaosStatus(service)` to TypeScript SDK
- [ ] 7.4 Add `injectState(service, resourceType, resourceId, state)` to TypeScript SDK
- [ ] 7.5 Add `clearInjectedState(service, resourceType, resourceId)` to TypeScript SDK
- [ ] 7.6 Add `client("fake")` and `client("aws_fake")` support to TypeScript SDK session

## 8. Tests
- [ ] 8.1 Verify `chaos`, `aws_fake`, `fake`, `apigateway_cognito` E2E suites are not stubs
- [ ] 8.2 Add unit tests for chaos config
- [ ] 8.3 Run `npm test` in `lang/typescript/` and confirm all suites green
- [ ] 8.4 Verify CI matrix covers new test suites
