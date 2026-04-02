## ADDED Requirements

### Requirement: Per-Account State Registry

LWS SHALL provide a `PerAccountStateRegistry` utility that maintains a separate state
object per account ID. When a service provider receives a request, it SHALL resolve the
target account ID from the `X-Amz-Security-Token` header (using the
`lws-acct-{account_id}-{uuid}` token format). The registry SHALL lazily instantiate
state for an account the first time it is accessed. State SHALL be isolated: reads and
writes in account `A` SHALL never affect account `B`.

#### Scenario: State isolated between two accounts

- **GIVEN** a CloudFormation stack `my-stack` is created under account `111111111111`
- **WHEN** `DescribeStacks` is called under account `222222222222`
- **THEN** `my-stack` is NOT returned

#### Scenario: State accessible within the same account

- **GIVEN** a CloudFormation stack `my-stack` is created under account `111111111111`
- **WHEN** `DescribeStacks` is called under account `111111111111`
- **THEN** `my-stack` IS returned

### Requirement: Default Account Fallback

Service providers SHALL fall back to account ID `000000000000` when no
`X-Amz-Security-Token` header is present or when the token does not follow the
`lws-acct-` format. This ensures that direct calls without AssumeRole continue to work.

#### Scenario: Direct call without session token uses default account

- **GIVEN** a CloudFormation stack is created without a session token
- **WHEN** `DescribeStacks` is called without a session token
- **THEN** the stack is returned (both calls share the `000000000000` default account)
