## ADDED Requirements

### Requirement: Organizations YAML Config Loading

The Organizations provider SHALL accept an optional YAML config file path. When a config
file is provided at startup, the provider SHALL parse it and pre-populate its state
(organization, root, OUs, accounts, tags, account-parent mappings) before serving any
requests. The config schema SHALL match:

```yaml
organization:
  id: o-example123
  master_account_id: "000000000000"
  feature_set: ALL

roots:
  - id: r-0001
    name: Root

ous:
  - id: ou-prod-0001
    name: Production
    parent: r-0001

accounts:
  - id: "111111111111"
    name: prod-payments
    email: prod-payments@example.com
    ou: ou-prod-0001
    status: ACTIVE          # optional; defaults to ACTIVE
    tags:
      env: prod
    roles:                  # optional; used for STS role validation
      - AgencyBroker
```

When no config file is provided, the provider starts with empty state (existing behaviour).

#### Scenario: Provider pre-populated from YAML config

- **GIVEN** a YAML config file defines one org, one root, two OUs, and three accounts
- **WHEN** the provider starts with that config path
- **THEN** `DescribeOrganization` returns the defined org metadata
- **AND** `ListRoots` returns the defined root
- **AND** `ListAccounts` returns all three accounts with their tags accessible via `ListTagsForResource`

#### Scenario: Provider starts empty without config

- **GIVEN** no config file is provided
- **WHEN** the provider starts
- **THEN** `DescribeOrganization` returns `AWSOrganizationsNotInUseException`

### Requirement: Organizations Config Account Status Support

The Organizations provider SHALL support `ACTIVE` and `SUSPENDED` account statuses when
loading from config. Accounts with `status: SUSPENDED` SHALL be returned by `ListAccounts`
and `DescribeAccount` with `Status: SUSPENDED`.

#### Scenario: Suspended account returned with correct status

- **GIVEN** a config defines an account with `status: SUSPENDED`
- **WHEN** `DescribeAccount` is called for that account ID
- **THEN** the response contains `Status: SUSPENDED`
