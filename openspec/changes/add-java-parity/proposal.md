# Change: Add Java parity with Python management API surface and CI parallelization

## Why

The Java implementation on `parity-check` received significant handler expansions across 12 providers (XML wire protocols, multipart uploads, deriveOperation refactors, expanded operations) and full BDD E2E step definitions for all 92 service combinations. However the management API surface is entirely absent: Java has no chaos injection endpoint, no fake server endpoint, no lifecycle rule endpoint, no state injection endpoint, and no capacity enforcement across its providers. CI runs all 92 E2E suites in one monolithic job with no parallelization.

## What's Already Done on `parity-check` (context only, not in scope)

| Provider | Changes Already on Branch |
|----------|--------------------------|
| `ApiGatewayHandler.java` | Minor API response fixes (7 insertions / 7 deletions) |
| `DocDbHandler.java` + `DocDbStore.java` | Full XML wire protocol (`buildClusterResponse`, `buildItemResponse`); cluster/instance/snapshot XML serialization (+203/+29) |
| `ElastiCacheHandler.java` + `ElastiCacheStore.java` | Full XML wire protocol; expanded replication group, subnet group, snapshot operations; tag operations (+324/+71) |
| `ElasticsearchHandler.java` | Refactored with `deriveOperation(method, path)` dispatch for IAM/chaos middleware integration (+196/-101) |
| `GlacierHandler.java` + `GlacierStore.java` | Multipart upload operations: `InitiateMultipartUpload`, `UploadMultipartPart`, `CompleteMultipartUpload`, `AbortMultipartUpload`, `ListMultipartUploads` (+53/+37) |
| `NeptuneHandler.java` | Full XML wire protocol; cluster/instance/snapshot XML serialization (+205/-50) |
| `OpenSearchHandler.java` | Refactored with `deriveOperation(method, path)` dispatch (+194/-101) |
| `RdsHandler.java` | Full XML wire protocol; DB instance/snapshot XML serialization (+159/-56) |
| `S3TablesHandler.java` | Expanded namespace/table/policy operations: `CreateNamespace`, `DeleteNamespace`, `ListNamespaces`, `CreateTable`, `ListTables`, `DeleteTablePolicy`, `PutTablePolicy` (+192/-78) |
| `SecretsManagerHandler.java` + `SecretsManagerStore.java` | Minor response fixes; `putRotation` operation (+2/+8) |
| `SsmHandler.java` + `SsmStore.java` | Expanded parameter/document operations (+4/+8) |
| `StepFunctionsHandler.java` | State machine existence checks; execution existence checks in describe/stop (+19/-9) |
| Unit tests (6 files) | `DocDbStoreModifyTest`, `ElastiCacheStoreExtendedOpsTest`, `ElastiCacheStoreTagTest`, `GlacierStoreMultipartTest`, `SecretsManagerStorePutRotateTest`, `SsmStorePutGetTest` |
| SDK E2E steps (90+ files) | Full BDD step definitions for all 92 service combinations (`StepfunctionsSteps.java` +790, `WorldContext.java` +23) |
| CI `java-sdk-e2e-test` | Condition hardening (`always() && !cancelled()`, upstream core result guards) |

**Providers NOT updated on parity-check** (in contrast with Go): `apigateway` (minor only), `cognitoidp`, `dynamodb`, `eventbridge`, `lambda`, `memorydb`, `secretsmanager` (minor), `sns`, `sqs`, `ssm` (minor).

## What Changes (in scope for this proposal)

### 1. Management API — chaos injection

Python exposes `GET/PUT/DELETE /_ldk/chaos/{service}`. Java has no chaos API.

- Add `ChaosConfig` record (`double errorRate`, `int latencyMs`) to management types
- Add `Map<String, ChaosConfig> chaosConfigs` to server state
- Add `GET /chaos/{service}`, `PUT /chaos/{service}`, `DELETE /chaos/{service}` routes to management controller
- Add chaos interceptor that checks config before each provider request dispatch

### 2. Management API — per-service capacity

Python exposes `GET/PUT/DELETE /_ldk/capacity/{service}`. Java has no capacity API.

- Add `CapacityConfig` record (`Integer slots`) to management types
- Add `Map<String, CapacityConfig> capacityConfigs` to server state
- Add `GET /capacity/{service}`, `PUT /capacity/{service}`, `DELETE /capacity/{service}` routes
- Add capacity guard helper; apply to all 19 provider handlers

### 3. Management API — lifecycle rules

Python and Go both have `GET/POST /_ldk/lifecycle`. Java has none.

- Add `LifecycleRule` record (`boolean enabled`, `int createDwellMs`, `int deleteDwellMs`)
- Add lifecycle rules map to server state
- Add `GET /lifecycle` and `POST /lifecycle` routes to management controller
- Wire lifecycle dwell into cluster provider handlers (RDS, DocDB, Neptune, ElastiCache, MemoryDB)

### 4. Management API — fake server instances (`/_ldk/fake`)

Python manages named fake server instances (name → endpoint URL). Java has no equivalent.

- Add `Map<String, String> fakeServers` to server state
- Add `GET /fake`, `POST /fake`, `GET /fake/{name}` routes to management controller
- Create `lang/java/core/src/main/java/io/localwebservices/lws/providers/fakeserver/` package

### 5. Management API — state injection (`/_ldk/state`)

Python exposes `GET/PUT/DELETE /_ldk/state/{service}/{resourceType}/{resourceId}`. Java has none.

- Add `Map<String, String> injectedStates` to server state (key: `service:resourceType:resourceId`)
- Add `GET /state/{service}/{resourceType}/{resourceId}`, `PUT`, `DELETE` routes
- Wire state injection into StepFunctions and Lambda provider handlers

### 6. Provider handler parity (remaining gaps)

The following providers were NOT updated in `f5feadd8` and need the same treatment as DocDB/ElastiCache/Neptune/RDS:

| Provider | Changes Needed |
|----------|---------------|
| `cognitoidp` | `RESET_REQUIRED` status; duplicate pool name guard; state-based operation guards (confirm, enable/disable, update attrs) |
| `dynamodb` | DynamoDB Streams support; lifecycle dwell tracking; capacity enforcement |
| `eventbridge` | Additional event target routing |
| `lambda` | DynamoDB Streams port; remove-permission; tag/untag; `PutFunctionConcurrency` |
| `memorydb` | Expanded CRUD coverage to match Go/Python |
| `sns` | SNS→SQS and SNS→EventBus target notification dispatch |
| `sqs` | In-flight count; capacity enforcement |

### 7. SDK helpers

Add to Java SDK `LwsSession`:

- `setChaos(String service, double errorRate, int latencyMs) throws IOException`
- `resetChaos(String service) throws IOException`
- `getChaosStatus(String service) throws IOException`
- `injectState(String service, String resourceType, String resourceId, String state) throws IOException`
- `clearInjectedState(String service, String resourceType, String resourceId) throws IOException`
- `client("fake")` / `client("aws_fake")` — return clients for registered fake server endpoints

### 8. GitHub Actions — E2E suite parallelization

Python's CI fans out `python-sdk-e2e-test` across 92 suites with `fail-fast: false`. Java's `java-sdk-e2e-test` runs all suites in one monolithic job.

Add to `.github/workflows/ci.yml`:

```yaml
# Discovery job — emits the suite list as a matrix
java-sdk-e2e-suites:
  needs: [changes]
  if: always() && !cancelled() && needs.changes.outputs.java-sdk == 'true'
  runs-on: ubuntu-latest
  outputs:
    suites: ${{ steps.list.outputs.suites }}
  steps:
    - uses: actions/checkout@v4
    - id: list
      run: |
        suites=$(find lang/java/sdk/src/test/java -name "*Steps.java" | \
          sed 's|.*/||;s|Steps\.java$||' | tr '[:upper:]' '[:lower:]' | \
          jq -R . | jq -sc .)
        echo "suites=$suites" >> $GITHUB_OUTPUT

# Per-suite job replacing the monolithic java-sdk-e2e-test
java-sdk-e2e-test:
  needs: [changes, java-sdk-e2e-suites, java-core-lint, java-core-integration-test, java-core-architecture-test, java-core-unit-test]
  if: |
    always() && !cancelled() &&
    needs.changes.outputs.java-sdk == 'true' &&
    (needs.java-sdk-e2e-suites.result == 'success' || needs.java-sdk-e2e-suites.result == 'skipped') &&
    (needs.java-core-lint.result == 'success' || needs.java-core-lint.result == 'skipped') &&
    (needs.java-core-integration-test.result == 'success' || needs.java-core-integration-test.result == 'skipped') &&
    (needs.java-core-architecture-test.result == 'success' || needs.java-core-architecture-test.result == 'skipped') &&
    (needs.java-core-unit-test.result == 'success' || needs.java-core-unit-test.result == 'skipped')
  strategy:
    fail-fast: false
    matrix:
      suite: ${{ fromJSON(needs.java-sdk-e2e-suites.outputs.suites) }}
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v4
    - uses: actions/setup-java@v4
      with:
        java-version: "17"
        distribution: "temurin"
    - name: Build Java core JAR
      working-directory: lang/java/core
      run: GRADLE_OPTS="-Dorg.gradle.project.buildDir=/tmp/gradle-build-lws-java-core" ./gradlew jar
    - name: Run E2E suite
      working-directory: lang/java/sdk
      run: make e2e-test
      env:
        SUITE: ${{ matrix.suite }}
```

## Impact

- Affected specs: `python-fake-chaos-sdk-access`, `python-capacity-parity`, `python-async-state-injection`, `python-missing-service-features`
- Affected code: `lang/java/core/src/main/java/io/localwebservices/lws/` (management controller, 7 remaining providers), `lang/java/sdk/`, `.github/workflows/ci.yml`
- No breaking changes — new endpoints and provider features are additive; all existing Java provider behavior is preserved
