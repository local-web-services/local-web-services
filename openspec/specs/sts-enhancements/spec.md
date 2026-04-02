# sts-enhancements Specification

## Purpose
TBD - created by archiving change add-agency-aws-api-surface. Update Purpose after archive.
## Requirements
### Requirement: STS AssumeRole Duration-Based Expiry

The STS provider SHALL compute `Expiration` from the current time plus the requested
`DurationSeconds` (defaulting to `3600` when not provided). The `Expiration` SHALL be
formatted as an ISO 8601 UTC timestamp (e.g. `2026-04-01T12:00:00Z`).

#### Scenario: Expiration reflects requested duration

- **GIVEN** the current time is `T`
- **WHEN** `AssumeRole` is called with `DurationSeconds=7200`
- **THEN** `Expiration` in the response equals `T + 7200 seconds` (within 5 seconds tolerance)

#### Scenario: Default duration used when DurationSeconds omitted

- **GIVEN** the current time is `T`
- **WHEN** `AssumeRole` is called without `DurationSeconds`
- **THEN** `Expiration` equals `T + 3600 seconds` (within 5 seconds tolerance)

### Requirement: STS AssumeRole Account-Encoded Session Token

The STS provider SHALL encode the target account ID in the returned session token using
the format `lws-acct-{account_id}-{uuid}`, where `account_id` is the 12-digit account ID
extracted from the `RoleArn` parameter (segment 4 of the ARN).

#### Scenario: Session token encodes the correct account ID

- **GIVEN** a role ARN of `arn:aws:iam::111111111111:role/AgencyBroker`
- **WHEN** `AssumeRole` is called
- **THEN** `SessionToken` starts with `lws-acct-111111111111-`

### Requirement: STS GetCallerIdentity Account-Aware Response

The STS provider SHALL return the account ID encoded in the `X-Amz-Security-Token`
header when present. When the token follows the `lws-acct-{account_id}-{uuid}` format,
the `Account` field SHALL be `account_id`. When the token is absent or does not follow
the format, the `Account` field SHALL default to `000000000000`.

#### Scenario: Account derived from session token

- **GIVEN** a session token of `lws-acct-111111111111-some-uuid`
- **WHEN** `GetCallerIdentity` is called with that token in `X-Amz-Security-Token`
- **THEN** the response `Account` is `111111111111`

#### Scenario: Default account when no session token

- **GIVEN** no session token is present
- **WHEN** `GetCallerIdentity` is called
- **THEN** the response `Account` is `000000000000`

### Requirement: STS FizzBee Formal Spec

The project SHALL include a FizzBee formal spec at
`lang/specification/core/formal/sts/sts.fizz` that models the STS state machine. The
spec SHALL cover `AssumeRole` (creates a session keyed by token with embedded account ID)
and `GetCallerIdentity` (reads the session). Safety invariants SHALL include
`SessionTokenContainsAccountId` and `CallerIdentityMatchesSession`.

#### Scenario: FizzBee model checker passes all invariants

- **GIVEN** the FizzBee spec is written
- **WHEN** `fizz sts.fizz` is run
- **THEN** all safety invariants pass with no counter-examples

