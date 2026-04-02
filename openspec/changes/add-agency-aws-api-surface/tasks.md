# Implementation Tasks

Tasks are ordered by priority (P0 first, then P1, then P2). Each group can begin
once the tasks it depends on are complete.

---

## Phase 1 — Organizations: Tags + ListChildren (P0)

- [x] 1.1 Add `_resource_tags: dict[str, dict[str, str]]` to `_OrganizationsState` and a matching `resource_tags` property
- [x] 1.2 Add unit tests for the `resource_tags` state property
- [x] 1.3 Implement `_handle_list_tags_for_resource` in `_org_handlers.py`
- [x] 1.4 Add unit tests for `_handle_list_tags_for_resource` (tagged account, untagged OU, unknown resource)
- [x] 1.5 Implement `_handle_list_children` in `_org_handlers.py` (ChildType ACCOUNT and ORGANIZATIONAL_UNIT)
- [x] 1.6 Add unit tests for `_handle_list_children` (account children, OU children, invalid child type)
- [x] 1.7 Register both new actions in `_ACTION_HANDLERS`
- [x] 1.8 Add integration tests for both new endpoints in `tests/integration/`
- [x] 1.9 Add FizzBee actions to `lang/specification/core/formal/organizations/organizations.fizz` for `ListTagsForResource` and `ListChildren`
- [x] 1.10 Run `fizz lang/specification/core/formal/organizations/organizations.fizz` and confirm all invariants pass
- [x] 1.11 Generate Gherkin feature files from the updated FizzBee spec and add to `lang/specification/core/informal/organizations/`
- [x] 1.12 Add/update e2e step definitions in `lang/python/sdk/tests/e2e/organizations/` for the new scenarios
- [x] 1.13 Run `make check` in `lang/python/core` and fix any lint/CPD issues

---

## Phase 2 — Organizations: YAML Config Loading (P0)

- [x] 2.1 Write `lang/python/core/src/lws/providers/organizations/_org_config.py` — YAML parser that returns a populated `_OrganizationsState`
- [x] 2.2 Add unit tests for `_org_config.py` (happy path, missing optional fields, SUSPENDED status, tags)
- [x] 2.3 Wire `_org_config.py` into `create_organizations_app` via an optional `config_path: str | None` parameter
- [x] 2.4 Add integration tests for config loading in `tests/integration/`
- [x] 2.5 Add spec `organizations-yaml-config` to the spec index
- [x] 2.6 Run `make check` in `lang/python/core`

---

## Phase 3 — STS: Account-Aware Identity + Duration Expiry (P0)

- [x] 3.1 Update `_handle_assume_role` in `lang/python/core/src/lws/providers/sts/routes.py` to compute `Expiration` from `DurationSeconds` (default 3600)
- [x] 3.2 Update `_handle_assume_role` to encode the account ID from `RoleArn` in the session token as `lws-acct-{account_id}-{uuid}`
- [x] 3.3 Update `_handle_get_caller_identity` to extract account ID from `X-Amz-Security-Token` header when present
- [x] 3.4 Add unit tests: expiry duration, default duration, session token format, account ID extraction
- [x] 3.5 Add integration tests for updated STS endpoints
- [x] 3.6 Write FizzBee formal spec at `lang/specification/core/formal/sts/sts.fizz`
- [x] 3.7 Run `fizz lang/specification/core/formal/sts/sts.fizz` and confirm all invariants pass
- [x] 3.8 Generate Gherkin feature files from FizzBee spec and add to `lang/specification/core/informal/sts/`
- [x] 3.9 Create SDK e2e suite at `lang/python/sdk/tests/e2e/sts/` with client, conftest, constants, test_scenarios, given/when/then step files
- [x] 3.10 Run `make check` in `lang/python/core` and `lang/python/sdk`

---

## Phase 4 — Agency Seed Data (P0)

- [x] 4.1 Create `lang/python/core/src/lws/seeds/` directory and write `enterprise.yaml` with 50–100 accounts across 6 OUs with all required tags
- [x] 4.2 Add unit test confirming the seed file parses without error and OU structure is correct
- [x] 4.3 Add `--seed` CLI flag to `lws start` / `ldk dev` startup (reads built-in named seeds or a file path)
- [x] 4.4 Wire `--seed` flag through to `create_organizations_app` config_path parameter
- [x] 4.5 Add integration test for `--seed enterprise` (ListAccounts returns 50+ accounts)
- [x] 4.6 Run `make check` in `lang/python/core`

---

## Phase 5 — Per-Account Routing Infrastructure (P1)

- [x] 5.1 Write `lang/python/core/src/lws/providers/_shared/per_account_state.py` — `PerAccountStateRegistry` class and `extract_account_id_from_token` helper
- [x] 5.2 Add unit tests for `PerAccountStateRegistry` (isolation, fallback to default account, lazy instantiation)
- [x] 5.3 Run `make check` in `lang/python/core`

---

## Phase 6 — CloudFormation Provider (P1)

- [x] 6.1 Create `lang/python/core/src/lws/providers/cloudformation/` package with `_cfn_state.py`, `_cfn_handlers.py`, `routes.py`
- [x] 6.2 Implement `_CfnState` with stacks dict keyed by stack name
- [x] 6.3 Add unit tests for `_CfnState`
- [x] 6.4 Implement handlers: `CreateStack`, `UpdateStack`, `DeleteStack`, `DescribeStacks`, `ListStacks`, `DescribeStackEvents`
- [x] 6.5 Add unit tests for all handlers (happy path + guard cases per spec scenarios)
- [x] 6.6 Wire `PerAccountStateRegistry` into `create_cloudformation_app` so state is per-account
- [x] 6.7 Add integration tests for all six actions including per-account isolation scenario
- [x] 6.8 Register CloudFormation provider in the orchestrator / service registry
- [x] 6.9 Write FizzBee formal spec at `lang/specification/core/formal/cloudformation/cloudformation.fizz`
- [x] 6.10 Run `fizz lang/specification/core/formal/cloudformation/cloudformation.fizz` and confirm invariants pass
- [x] 6.11 Generate Gherkin feature files and add to `lang/specification/core/informal/cloudformation/`
- [x] 6.12 Create SDK e2e suite at `lang/python/sdk/tests/e2e/cloudformation/` with all required files
- [x] 6.13 Run `make check` in `lang/python/core` and `lang/python/sdk`

---

## Phase 7 — SSM Per-Account Routing (P1)

- [x] 7.1 Update `lang/python/core/src/lws/providers/ssm/routes.py` to use `PerAccountStateRegistry` so each account has its own `_SsmState`
- [x] 7.2 Add unit tests confirming SSM state isolation between two accounts
- [x] 7.3 Add integration tests for per-account SSM isolation
- [x] 7.4 Update existing SSM e2e suite if needed (existing single-account tests must still pass)
- [x] 7.5 Run `make check` in `lang/python/core` and `lang/python/sdk`

---

## Phase 8 — Service Catalog Provider (P2)

- [x] 8.1 Create `lang/python/core/src/lws/providers/service_catalog/` package with `_sc_state.py`, `_sc_handlers.py`, `routes.py`
- [x] 8.2 Implement `_ScState` with products and provisioned-product records
- [x] 8.3 Add unit tests for `_ScState`
- [x] 8.4 Implement handlers: `SearchProductsAsAdmin`, `DescribeProduct`, `ListProvisioningArtifacts`, `ListLaunchPaths`, `ProvisionProduct`, `DescribeRecord`
- [x] 8.5 Add unit tests for all handlers (happy path + guard cases per spec scenarios)
- [x] 8.6 Wire `PerAccountStateRegistry` into `create_service_catalog_app`
- [x] 8.7 Add integration tests for all six actions including per-account isolation
- [x] 8.8 Register Service Catalog provider in the orchestrator / service registry
- [x] 8.9 Write FizzBee formal spec at `lang/specification/core/formal/service_catalog/service_catalog.fizz`
- [x] 8.10 Run `fizz lang/specification/core/formal/service_catalog/service_catalog.fizz` and confirm invariants pass
- [x] 8.11 Generate Gherkin feature files and add to `lang/specification/core/informal/service_catalog/`
- [x] 8.12 Create SDK e2e suite at `lang/python/sdk/tests/e2e/service_catalog/` with all required files
- [x] 8.13 Run `make check` in `lang/python/core` and `lang/python/sdk`

---

## Validation Gate

- [x] V.1 `make check` passes in `lang/python/core`
- [x] V.2 `make check` passes in `lang/python/sdk`
- [x] V.3 `make check` passes in `lang/python/example`
- [x] V.4 All FizzBee specs pass: organizations, sts, cloudformation, service_catalog
- [x] V.5 E2E suites exist for: organizations (existing + new scenarios), sts, cloudformation, per-account ssm, service_catalog
- [x] V.6 `openspec validate add-agency-aws-api-surface --strict --no-interactive` passes
