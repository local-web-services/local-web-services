# Change: Unlock Internal and Capacity E2E Test Scenarios

## Why

15,248 Python SDK e2e scenarios are currently skipped or not collected. Investigation identified five root causes. Two are immediately fixable because the required SDK infrastructure already exists:

1. **`@internal` conftest filter** (`lang/python/sdk/tests/e2e/conftest.py` line 18) removes 859 `@internal` scenarios from collection entirely. These scenarios were tagged `@internal` while the cross-service dispatch and capacity infrastructure was being built, but the capacity infrastructure (`lws_session.capacity()`) is now complete.

2. **Capacity step definitions** (~78 step files) call `pytest.skip()` instead of `lws_session.capacity("<service>").exhaust().apply()`. The `CapacityBuilder` is fully implemented and wired to 10 services. The step defs were never updated after the builder was shipped.

The stale `remove-python-capacity-lifecycle-skips` proposal (0/51 tasks) assumes the SDK helpers need to be built — they do not. This proposal supersedes that work for the capacity and filter portions.

## What Changes

### 1. Remove `@internal` collection filter

Delete the `pytest_collection_modifyitems` hook from `lang/python/sdk/tests/e2e/conftest.py` that filters out all `@internal`-tagged scenarios. Once removed, all 859 `@internal` scenarios are collected and run.

- `@internal @capacity` scenarios will **pass** once the capacity step defs are implemented.
- All other `@internal` scenarios (cross-service dispatch, lifecycle state, RDS protocol) will continue to emit `pytest.skip()` from their step definitions — they stay SKIPPED, not failed.

### 2. Implement capacity step definitions

Replace `pytest.skip()` with real implementations in all step definition files that say "Cannot exhaust … slot limit". Map each step to the correct `lws_session.capacity("<service>").exhaust().apply()` call and add `lws_session.capacity("<service>").clear()` teardown.

Services already wired with `AwsCapacityConfig`:

| Service key | Step defs affected | Approx count |
|-------------|-------------------|-------------|
| `lambda` | `no_invocation_slot_available` | 20 files |
| `stepfunctions` | `no_execution_slot_available` | 13 files |
| `events` | `no_event_slot_available` | 8 files |
| `sns` | `subscription_slot_not_available`, `delivery_slot_not_available` | 5 files |
| `s3` | `no_object_slot_available` | 1 file |
| `glacier` | `no_archive_slot_available` | 1 file |

### 3. Wire capacity to remaining services

Six services have capacity step defs that skip because `AwsCapacityConfig` is not yet wired to those providers. Add `AwsCapacityConfig` to each and wire to the `CapacityControlPlane` endpoint.

| Service | Step defs blocked | Slot type |
|---------|------------------|-----------|
| `opensearch` / `elasticsearch` | `no_document_slot_available`, `connection_slot_not_available` | document / connection |
| `memorydb` | `target_cluster_slot_not_available`, `snapshot_slot_not_available`, `no_cluster_slot_available`, `no_async_slot_available` | cluster / snapshot |
| `elasticache` | `instance_slot_not_available`, `target_instance_slot_not_available` | instance |
| `neptune` / `docdb` (via cluster DB) | `no_cluster_slot_available_for_primary`, `no_snapshot_slot_available` | cluster / snapshot |
| `ssm` | `no_key_slot_available`, `no_record_slot_available` | key / record |

## Out of Scope

- **Lifecycle state injection** (`inject_state` for Neptune/DocDB clusters, Lambda function states) — requires extending `_dispatch_injection` to those providers. Separate proposal.
- **Cross-service dispatch** (lambda_sns, lambda_opensearch, apigateway_lambda, etc.) — requires dispatch phase 2 infrastructure. Separate proposal.
- **RDS query protocol** (stepfunctions_docdb cluster CRUD, etc.) — requires `add-python-rds-query-protocol`. Separate proposal.
- **Secrets Manager rotation / S3 lifecycle expiry** — require timer-driven side effects. Separate proposals.

## Impact

- Removes `remove-python-capacity-lifecycle-skips` as stale — replace it with this proposal.
- Affected files: `conftest.py`, ~78 step definition files, ~6 provider `routes.py` files.
- No breaking changes to production code.
- After this change, the "Cannot exhaust … slot limit" category of skips should drop to zero. The cross-service and lifecycle skips will remain as SKIPPED (informative) rather than NOT COLLECTED (invisible).
