# Change: Add AWS API Surface for Agency Development

## Why

Agency is an infrastructure OS that sits above AWS Control Tower. It manages accounts,
vends credentials, enforces desired state, and treats agents as first-class citizens.
Agency must be buildable and testable without a real AWS organisation. LWS provides the
fake AWS API surface that makes this possible: if Agency works against LWS locally, it
works against real AWS in production.

Five capabilities are required. Three are P0 (block all Agency development), one is P1,
one is P2.

## What Changes

- **Organizations: ListTagsForResource + ListChildren** — two missing endpoints that
  Spire uses during org traversal; tags are already stored on accounts/OUs but not
  exposed, and `ListChildren` is a unified child-listing alternative to the two separate
  `ListAccountsForParent` / `ListOrganizationalUnitsForParent` calls.

- **Organizations: YAML config loading** — load a static org structure from a YAML file
  at startup so the provider is pre-populated without needing API calls to build the tree.
  Required for seed data and for any user-supplied fixture files.

- **STS: account-aware identity and duration-based expiry** — `AssumeRole` currently
  returns a hardcoded `Expiration` of 2099. Agency's Credential Broker sets
  `DurationSeconds` and inspects `Expiration`. `GetCallerIdentity` must also return the
  account ID encoded in the assumed-role ARN, not always `000000000000`.

- **Agency seed data** — a built-in YAML file representing a believable large enterprise
  (50–100 accounts across Production, Non-Production, Sandbox, Security, SharedServices,
  Decommissioned OUs) loadable via `lws start --seed enterprise`. Lets Agency developers
  run Spire sync and see a populated CMDB with no setup.

- **Per-account service endpoints: CloudFormation + SSM** — LWS must route CloudFormation
  and SSM calls to per-account state so that a stack in account `111111111111` is
  invisible to account `222222222222`. Requires a per-account routing layer driven by the
  account ID encoded in the session token returned by `AssumeRole`.

- **Service Catalog emulator** — basic Service Catalog endpoint for testing Puppet
  migration paths; also per-account isolated.

## Impact

- Affected specs (new): `organizations-list-tags-children`, `organizations-yaml-config`,
  `sts-enhancements`, `agency-seed-data`, `cloudformation-provider`,
  `per-account-routing`, `service-catalog-provider`
- Affected code:
  - `lang/python/core/src/lws/providers/organizations/` — add handlers + config loader + tags state
  - `lang/python/core/src/lws/providers/sts/routes.py` — duration expiry + account identity
  - `lang/python/core/src/lws/providers/` — new `cloudformation/` and `service_catalog/` packages
  - `lang/python/core/src/lws/providers/_shared/` — per-account routing middleware
  - `lang/python/core/src/lws/` — CLI flag `--seed` and config file parsing
  - `lang/specification/core/formal/` — new FizzBee specs for STS, CloudFormation, SSM per-account, Service Catalog
  - `lang/specification/core/informal/` — new Gherkin feature files for all new capabilities
  - `lang/python/sdk/tests/e2e/` — new SDK e2e suites for STS, per-account CloudFormation, per-account SSM, Service Catalog

## Priority Sequencing

| Capability | Agency Priority | Unblocks |
|---|---|---|
| Organizations tags + children | P0 | Spire full org traversal |
| Organizations YAML config | P0 | Seed data + fixtures |
| STS enhancements | P0 | Credential Broker |
| Agency seed data | P0 | All Agency development |
| Per-account routing + CloudFormation + SSM | P1 | Desired State Engine |
| Service Catalog | P2 | Puppet migration |
