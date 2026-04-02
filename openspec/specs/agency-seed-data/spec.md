# agency-seed-data Specification

## Purpose
TBD - created by archiving change add-agency-aws-api-surface. Update Purpose after archive.
## Requirements
### Requirement: Agency Enterprise Seed Dataset

LWS SHALL ship a built-in YAML seed file at
`lang/python/core/src/lws/seeds/enterprise.yaml` representing a believable large enterprise
AWS organisation. The file SHALL contain:

- 50–100 accounts spread across six OUs: `Production`, `NonProduction`, `Sandbox`,
  `Security`, `SharedServices`, `Decommissioned`
- Account tags: `env`, `team`, `cost-center`, `data-classification`, `region-primary`
- Mixed regions across `eu-west-1`, `us-east-1`, `ap-southeast-1`
- A mix of `ACTIVE` and `SUSPENDED` account statuses
- Realistic naming: `prod-payments`, `dev-data-platform`, `sandbox-alice`,
  `security-audit-log`, etc.

#### Scenario: Seed file parses without error

- **GIVEN** the enterprise seed YAML file exists
- **WHEN** the YAML is parsed and loaded into an `_OrganizationsState`
- **THEN** no parsing errors occur and all accounts/OUs are accessible

#### Scenario: Seed data covers expected OU structure

- **GIVEN** the enterprise seed is loaded
- **WHEN** `ListRoots` and `ListOrganizationalUnitsForParent` are called
- **THEN** all six expected top-level OUs are present under the root

### Requirement: Seed Data CLI Flag

The `lws` (and `ldk dev`) startup command SHALL accept a `--seed <name>` flag.
When `--seed enterprise` is passed, the provider SHALL load the built-in enterprise
seed file. When `--seed <path>` is a file path, the provider SHALL load that file.
When neither flag is provided, the provider starts with empty state.

#### Scenario: Enterprise seed loaded via --seed flag

- **GIVEN** the lws server is started with `--seed enterprise`
- **WHEN** `ListAccounts` is called
- **THEN** 50 or more accounts are returned

#### Scenario: Custom seed file loaded via --seed flag

- **GIVEN** a custom YAML seed file exists at `/tmp/my-seed.yaml` with 3 accounts
- **WHEN** the lws server is started with `--seed /tmp/my-seed.yaml`
- **THEN** `ListAccounts` returns exactly 3 accounts

