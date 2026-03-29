## 1. Management API — per-service chaos path
- [ ] 1.1 Add `ChaosConfig` interface (`errorRate: number`, `latencyMs: number`) to TypeScript server state types
- [ ] 1.2 Add `chaosConfigs: Map<string, ChaosConfig>` to server state
- [ ] 1.3 Add `GET/PUT/DELETE /_ldk/chaos/:service` routes to management router
- [ ] 1.4 Add chaos middleware function that reads config and intercepts provider requests

## 2. Management API — per-service capacity path
- [ ] 2.1 Add `CapacityConfig` interface (`slots: number | null`) to server state types
- [ ] 2.2 Add `capacityConfigs: Map<string, CapacityConfig>` to server state
- [ ] 2.3 Add `GET/PUT/DELETE /_ldk/capacity/:service` routes to management router
- [ ] 2.4 Add `isCapacityExhausted(service: string): boolean` helper
- [ ] 2.5 Apply capacity guard to all 19 provider handlers

## 3. Management API — lifecycle rules
- [ ] 3.1 Verify `/_ldk/lifecycle` route — add if missing (port from Go/Python)
- [ ] 3.2 Add `LifecycleRule` interface (`enabled: boolean`, `createDwellMs: number`, `deleteDwellMs: number`)
- [ ] 3.3 Add lifecycle rules store to server state
- [ ] 3.4 Wire lifecycle dwell into cluster handlers (RDS, DocDB, Neptune, ElastiCache, MemoryDB)

## 4. Management API — fake server instances (`/_ldk/fake`)
- [ ] 4.1 Add `fakeServers: Map<string, string>` (name → endpoint) to server state
- [ ] 4.2 Add `POST /_ldk/fake`, `GET /_ldk/fake`, `GET /_ldk/fake/:name` routes to management router
- [ ] 4.3 Create `lang/typescript/core/src/providers/fakeserver/` provider module

## 5. Management API — state injection (`/_ldk/state`)
- [ ] 5.1 Add `injectedStates: Map<string, string>` (key: `service:resourceType:resourceId`) to server state
- [ ] 5.2 Add `GET/PUT/DELETE /_ldk/state/:service/:resourceType/:resourceId` routes to management router
- [ ] 5.3 Wire `getInjectedState` into StepFunctions provider (execution status override)
- [ ] 5.4 Wire `getInjectedState` into Lambda provider (invocation status override)

## 6. Provider handler parity (core TypeScript — 19 providers)
- [ ] 6.1 `apigateway` — duplicate API name guard; root-resource delete protection; deleteMethod/deleteIntegration errors; Cognito authorizer dispatch
- [ ] 6.2 `cognitoidp` — `RESET_REQUIRED` status; duplicate pool name guard; state-based operation guards
- [ ] 6.3 `docdb` — XML wire protocol responses (cluster/instance/snapshot)
- [ ] 6.4 `dynamodb` — DynamoDB Streams support; lifecycle dwell; capacity enforcement
- [ ] 6.5 `elasticache` — XML wire protocol; replication group / subnet group / snapshot XML types
- [ ] 6.6 `elasticsearch` — `deriveOperation(method, path)` dispatch refactor
- [ ] 6.7 `eventbridge` — additional event target routing
- [ ] 6.8 `glacier` — SNS notification-configuration routes; multipart upload operations
- [ ] 6.9 `lambda` — DynamoDB Streams port; remove-permission; tag/untag; `PutFunctionConcurrency`
- [ ] 6.10 `memorydb` — expanded CRUD coverage
- [ ] 6.11 `neptune` — XML wire protocol
- [ ] 6.12 `opensearch` — `deriveOperation(method, path)` dispatch refactor
- [ ] 6.13 `rds` — XML wire protocol (DB instance/snapshot)
- [ ] 6.14 `s3tables` — namespace/table/policy operations (CreateNamespace, DeleteNamespace, etc.)
- [ ] 6.15 `secretsmanager` — minor response fixes
- [ ] 6.16 `sns` — SNS→SQS and SNS→EventBus target notification dispatch
- [ ] 6.17 `sqs` — in-flight count helper; capacity enforcement
- [ ] 6.18 `ssm` — verify completeness vs Go (only minor refactoring done)
- [ ] 6.19 `stepfunctions` — update state machine; list-executions ARN filter; capacity enforcement; existence guards

## 7. SDK Helpers
- [ ] 7.1 Add `setChaos(service: string, errorRate: number, latencyMs: number): Promise<void>` to `session.ts`
- [ ] 7.2 Add `resetChaos(service: string): Promise<void>` to `session.ts`
- [ ] 7.3 Add `getChaosStatus(service: string): Promise<Record<string, unknown>>` to `session.ts`
- [ ] 7.4 Add `injectState(service, resourceType, resourceId, state): Promise<void>` to `session.ts`
- [ ] 7.5 Add `clearInjectedState(service, resourceType, resourceId): Promise<void>` to `session.ts`
- [ ] 7.6 Add `client("fake")` / `client("aws_fake")` cases to `client()` in `session.ts`

## 8. GitHub Actions — E2E suite parallelization
- [ ] 8.1 Add `typescript-sdk-e2e-suites` discovery job to `.github/workflows/ci.yml`
- [ ] 8.2 Add `typescript-sdk-e2e-test` matrix job with `fail-fast: false`
- [ ] 8.3 Verify `make e2e-test SUITE=<name>` works in `lang/typescript/sdk/` (add to Makefile if missing)
- [ ] 8.4 Confirm existing `typescript-sdk-lint` / `typescript-sdk-unit-test` jobs are preserved

## 9. Tests and Verification
- [ ] 9.1 Verify `chaos`, `aws_fake`, `fake`, `apigateway_cognito` E2E step files are not stubs
- [ ] 9.2 Add unit tests for chaos config and capacity config
- [ ] 9.3 Run `npm test` in `lang/typescript/core/` and `lang/typescript/sdk/` — all green
