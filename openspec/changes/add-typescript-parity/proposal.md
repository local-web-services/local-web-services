# Change: Add TypeScript parity with Python management API surface and CI parallelization

## Why

TypeScript has the largest implementation gap of any language on `parity-check`. Python implemented chaos injection, fake server management, lifecycle rules, state injection, capacity enforcement across all providers, and full cross-service dispatch routing. TypeScript received only: SSM provider minor refactoring, SDK port-retry logic, MemoryDB/Elasticsearch/EventBridge client additions, and a complete set of BDD E2E step definition files. The management API surface, provider dispatch improvements, and SDK management helpers are entirely absent.

## What's Already Done on `parity-check` (context only, not in scope)

| Area | Changes Already on Branch |
|------|--------------------------|
| `providers/ssm/index.ts` | Minor internal refactoring (8 insertions / 8 deletions — same API surface) |
| `sdk/src/session.ts` | Port-retry logic for `EADDRINUSE` race; added `MemoryDBClient`, `ElasticsearchServiceClient`, `EventBridgeClient` cases to `client()` (+23 lines) |
| `sdk/tests/steps/*.ts` | Full BDD E2E step definitions for all 92 service combinations (87 files, ~40K insertions) |
| `sdk/tests/support/world.ts` | World context expanded (+213 lines) |
| `sdk/tests/steps/user_common.ts` | New shared user steps (+84 lines) |
| `sdk/cucumber.js`, `package.json` | Cucumber configuration updates for new step files |
| CI `typescript-sdk-e2e-test` | Condition hardening (`always() && !cancelled()`, upstream core result guards) |

**TypeScript core providers that were NOT updated on parity-check** (in contrast with Go which updated all 19 handlers): only `ssm` was touched. Every other provider handler — apigateway, cognitoidp, docdb, dynamodb, elasticache, elasticsearch, eventbridge, glacier, lambda, memorydb, neptune, opensearch, rds, s3tables, secretsmanager, sns, sqs, stepfunctions — is unchanged from `main`.

## What Changes (in scope for this proposal)

### 1. Management API — per-service chaos path

Python exposes `GET/PUT/DELETE /_ldk/chaos/{service}`. TypeScript currently has no chaos API.

- Add chaos config store to TypeScript server state
- Add `GET/PUT/DELETE /_ldk/chaos/:service` routes to the management router
- `PUT` accepts `{"error_rate": number, "latency_ms": number}`
- `DELETE` resets chaos for that service
- Add chaos middleware that intercepts provider requests

### 2. Management API — per-service capacity path

Python exposes `GET/PUT/DELETE /_ldk/capacity/{service}`. TypeScript has no capacity API.

- Add capacity config store (slots per service) to server state
- Add `GET/PUT/DELETE /_ldk/capacity/:service` routes to the management router
- `PUT` accepts `{"slots": number | null}`
- Apply capacity guards to all 19 provider handlers

### 3. Management API — lifecycle rules

Python and Go both have `GET/POST /_ldk/lifecycle`. TypeScript has no lifecycle API.

- Add `LifecycleRule` interface and store to server state
- Add `GET/POST /_ldk/lifecycle` routes
- Wire lifecycle dwell into cluster provider handlers (RDS, DocDB, Neptune, ElastiCache, MemoryDB)

### 4. Management API — fake server instances (`/_ldk/fake`)

Python's `_management_fake.py` manages named fake server instances (name → endpoint URL). TypeScript has no equivalent.

- Add fake server record store to server state
- Add `POST /_ldk/fake`, `GET /_ldk/fake`, `GET /_ldk/fake/:name` routes
- Create `lang/typescript/core/src/providers/fakeserver/` provider module

### 5. Management API — state injection (`/_ldk/state`)

Python exposes `GET/PUT/DELETE /_ldk/state/{service}/{resource_type}/{resource_id}`. TypeScript has none.

- Add injected-state map to server state (key: `service:resourceType:resourceId`)
- Add `GET/PUT/DELETE /_ldk/state/:service/:resourceType/:resourceId` routes
- Wire into StepFunctions and Lambda provider handlers

### 6. Provider handler parity (core TypeScript providers)

All 19 TypeScript provider handlers need the same treatment Go received in `f5feadd8`:

| Provider | Changes Needed |
|----------|---------------|
| `apigateway` | Duplicate REST API name guard; root-resource delete protection; `deleteMethod`/`deleteIntegration` error returns; Cognito authorizer dispatch |
| `cognitoidp` | `RESET_REQUIRED` status; duplicate pool name guard; state-based operation guards |
| `docdb` | XML wire protocol responses |
| `dynamodb` | DynamoDB Streams support; lifecycle dwell tracking; capacity enforcement |
| `elasticache` | XML wire protocol responses |
| `elasticsearch` | `deriveOperation` dispatch refactor |
| `eventbridge` | Additional event routing |
| `glacier` | SNS notification-configuration routes; multipart upload operations |
| `lambda` | DynamoDB Streams port; remove-permission; tag/untag; `PutFunctionConcurrency` |
| `memorydb` | Expanded CRUD coverage |
| `neptune` | XML wire protocol responses |
| `opensearch` | `deriveOperation` dispatch refactor |
| `rds` | XML wire protocol responses |
| `s3tables` | Expanded namespace/table/policy operations |
| `secretsmanager` | Minor response fixes |
| `sns` | SNS target notification dispatch |
| `sqs` | In-flight count helper |
| `ssm` | Expanded parameter/document operations (partially done — verify completeness) |
| `stepfunctions` | State machine update; list-executions ARN filter; capacity enforcement; existence guards |

### 7. SDK helpers

Add to `lang/typescript/sdk/src/session.ts`:

- `setChaos(service: string, errorRate: number, latencyMs: number): Promise<void>`
- `resetChaos(service: string): Promise<void>`
- `getChaosStatus(service: string): Promise<Record<string, unknown>>`
- `injectState(service: string, resourceType: string, resourceId: string, state: string): Promise<void>`
- `clearInjectedState(service: string, resourceType: string, resourceId: string): Promise<void>`
- `client("fake")` / `client("aws_fake")` — return clients for registered fake server endpoints

### 8. GitHub Actions — E2E suite parallelization

Python's CI fans out `python-sdk-e2e-test` across 92 suites with `fail-fast: false`. TypeScript's `typescript-sdk-e2e-test` runs all suites sequentially in one job.

Add to `.github/workflows/ci.yml`:

```yaml
# Discovery job — emits the suite list as a matrix
typescript-sdk-e2e-suites:
  needs: [changes]
  if: always() && !cancelled() && needs.changes.outputs.typescript-sdk == 'true'
  runs-on: ubuntu-latest
  outputs:
    suites: ${{ steps.list.outputs.suites }}
  steps:
    - uses: actions/checkout@v4
    - id: list
      run: |
        suites=$(ls lang/typescript/sdk/tests/steps/*.ts | \
          sed 's|.*/||;s|\.ts$||' | \
          jq -R . | jq -sc .)
        echo "suites=$suites" >> $GITHUB_OUTPUT

# Per-suite job replacing the monolithic typescript-sdk-e2e-test
typescript-sdk-e2e-test:
  needs: [changes, typescript-sdk-e2e-suites, typescript-core-lint, typescript-core-integration-test, typescript-core-architecture-test]
  if: |
    always() && !cancelled() &&
    needs.changes.outputs.typescript-sdk == 'true' &&
    (needs.typescript-sdk-e2e-suites.result == 'success' || needs.typescript-sdk-e2e-suites.result == 'skipped') &&
    (needs.typescript-core-lint.result == 'success' || needs.typescript-core-lint.result == 'skipped') &&
    (needs.typescript-core-integration-test.result == 'success' || needs.typescript-core-integration-test.result == 'skipped') &&
    (needs.typescript-core-architecture-test.result == 'success' || needs.typescript-core-architecture-test.result == 'skipped')
  strategy:
    fail-fast: false
    matrix:
      suite: ${{ fromJSON(needs.typescript-sdk-e2e-suites.outputs.suites) }}
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v4
    - uses: actions/setup-node@v4
      with:
        node-version: "20"
    - name: Install and build core
      working-directory: lang/typescript/core
      run: npm ci && npm run build
    - name: Install sdk
      working-directory: lang/typescript/sdk
      run: npm ci
    - name: Run E2E suite
      working-directory: lang/typescript/sdk
      run: make e2e-test
      env:
        SUITE: ${{ matrix.suite }}
```

## Impact

- Affected specs: `python-fake-chaos-sdk-access`, `python-capacity-parity`, `python-async-state-injection`, `python-apigateway-cognito-authorizer`, `python-missing-service-features`
- Affected code: `lang/typescript/core/src/` (management router, all 19 providers), `lang/typescript/sdk/src/session.ts`, `.github/workflows/ci.yml`
- No breaking changes — new endpoints and provider features are additive
