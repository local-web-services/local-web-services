## ADDED Requirements

### Requirement: Organizations ListTagsForResource

The Organizations provider SHALL implement `ListTagsForResource`. When called with a
`ResourceId` that matches a known account or OU, it SHALL return the tags map stored on
that resource as a list of `{Key, Value}` objects. When the resource does not exist it
SHALL return an empty tag list (matching real AWS behaviour for untagged resources).

#### Scenario: Tags returned for a tagged account

- **GIVEN** an account exists with tags `{"env": "prod", "team": "payments"}`
- **WHEN** `ListTagsForResource` is called with the account ID
- **THEN** the response contains `[{"Key": "env", "Value": "prod"}, {"Key": "team", "Value": "payments"}]`

#### Scenario: Empty list returned for untagged resource

- **GIVEN** an OU exists with no tags
- **WHEN** `ListTagsForResource` is called with the OU ID
- **THEN** the response contains an empty `Tags` list

### Requirement: Organizations Tags State

The Organizations provider SHALL store a tags map alongside each account and OU.
Accounts created via `CreateAccount` or loaded from a YAML config MAY carry an initial
tags map. Tags SHALL be keyed by resource ID in a separate state dictionary so that
`ListTagsForResource` can look them up in O(1).

#### Scenario: Account created with tags via config

- **GIVEN** a YAML config defines an account with `tags: {env: prod}`
- **WHEN** the provider starts with that config
- **THEN** `ListTagsForResource` for that account returns `[{"Key": "env", "Value": "prod"}]`

### Requirement: Organizations ListChildren

The Organizations provider SHALL implement `ListChildren`. It SHALL accept a `ParentId`
and a `ChildType` of either `ACCOUNT` or `ORGANIZATIONAL_UNIT`. It SHALL return the
matching children of the given parent, each as `{Id, Type}`. An unknown `ChildType`
SHALL return an `InvalidInputException`.

#### Scenario: List account children of a parent

- **GIVEN** two accounts are parented under OU `ou-prod-0001`
- **WHEN** `ListChildren` is called with `ParentId=ou-prod-0001, ChildType=ACCOUNT`
- **THEN** both account IDs are returned with `Type=ACCOUNT`

#### Scenario: List OU children of a parent

- **GIVEN** three OUs are parented under the root
- **WHEN** `ListChildren` is called with `ParentId=r-0001, ChildType=ORGANIZATIONAL_UNIT`
- **THEN** all three OU IDs are returned with `Type=ORGANIZATIONAL_UNIT`

#### Scenario: Invalid ChildType rejected

- **GIVEN** the org exists
- **WHEN** `ListChildren` is called with `ChildType=INVALID`
- **THEN** the operation is rejected with `InvalidInputException`
