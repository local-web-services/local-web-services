## ADDED Requirements

### Requirement: CloudFormation CreateStack

The CloudFormation provider SHALL implement `CreateStack`. It SHALL accept `StackName`
and `TemplateBody` (or `TemplateURL`). It SHALL store the stack with status
`CREATE_COMPLETE` and return a `StackId` ARN. A duplicate `StackName` in the same
account SHALL return `AlreadyExistsException`.

#### Scenario: Stack created successfully

- **GIVEN** no stack named `my-stack` exists in account `111111111111`
- **WHEN** `CreateStack` is called with `StackName=my-stack`
- **THEN** a `StackId` ARN is returned and `DescribeStacks` returns the stack with status `CREATE_COMPLETE`

#### Scenario: Duplicate stack name rejected

- **GIVEN** a stack named `my-stack` already exists in account `111111111111`
- **WHEN** `CreateStack` is called again with `StackName=my-stack`
- **THEN** the operation is rejected with `AlreadyExistsException`

### Requirement: CloudFormation UpdateStack

The CloudFormation provider SHALL implement `UpdateStack`. It SHALL accept `StackName`
and update the stored `TemplateBody`. The stack status SHALL transition to
`UPDATE_COMPLETE`. An unknown `StackName` SHALL return `StackNotFoundException`.

#### Scenario: Stack updated successfully

- **GIVEN** a stack named `my-stack` exists with an old template
- **WHEN** `UpdateStack` is called with a new `TemplateBody`
- **THEN** `DescribeStacks` returns the stack with status `UPDATE_COMPLETE` and the new template

#### Scenario: Update on non-existent stack rejected

- **GIVEN** no stack named `missing-stack` exists
- **WHEN** `UpdateStack` is called for `missing-stack`
- **THEN** the operation is rejected with `StackNotFoundException`

### Requirement: CloudFormation DeleteStack

The CloudFormation provider SHALL implement `DeleteStack`. It SHALL remove the stack
from the account's state. Calling `DeleteStack` for a non-existent stack SHALL be a
no-op (matching real AWS behaviour).

#### Scenario: Stack deleted successfully

- **GIVEN** a stack named `my-stack` exists
- **WHEN** `DeleteStack` is called
- **THEN** `DescribeStacks` no longer returns `my-stack`

### Requirement: CloudFormation DescribeStacks

The CloudFormation provider SHALL implement `DescribeStacks`. With no `StackName`
filter it SHALL return all stacks in the account. With a `StackName` filter it SHALL
return that stack or raise `StackNotFoundException`.

#### Scenario: All stacks returned without filter

- **GIVEN** three stacks exist in account `111111111111`
- **WHEN** `DescribeStacks` is called without a filter
- **THEN** all three stacks are returned

#### Scenario: Single stack returned with name filter

- **GIVEN** a stack named `my-stack` exists
- **WHEN** `DescribeStacks` is called with `StackName=my-stack`
- **THEN** exactly one stack is returned with `StackName=my-stack`

### Requirement: CloudFormation ListStacks

The CloudFormation provider SHALL implement `ListStacks`. It SHALL return stack
summaries (`StackName`, `StackStatus`, `StackId`) for all stacks in the account,
optionally filtered by `StackStatusFilter`.

#### Scenario: List stacks returns summaries

- **GIVEN** two stacks exist, one `CREATE_COMPLETE` and one `UPDATE_COMPLETE`
- **WHEN** `ListStacks` is called
- **THEN** both stacks are returned as summaries

### Requirement: CloudFormation DescribeStackEvents

The CloudFormation provider SHALL implement `DescribeStackEvents`. It SHALL return at
least one synthetic event per stack representing the terminal state transition.

#### Scenario: Stack events returned after creation

- **GIVEN** a stack named `my-stack` has been created
- **WHEN** `DescribeStackEvents` is called for `my-stack`
- **THEN** at least one event is returned with `ResourceStatus=CREATE_COMPLETE`

### Requirement: CloudFormation FizzBee Formal Spec

The project SHALL include a FizzBee formal spec at
`lang/specification/core/formal/cloudformation/cloudformation.fizz` that models the
CloudFormation stack lifecycle. The spec SHALL cover `CreateStack`, `UpdateStack`,
`DeleteStack`. Safety invariants SHALL include `UniqueStackNamesPerAccount` and
`DeletedStackNotDescribable`.

#### Scenario: FizzBee model checker passes all invariants

- **GIVEN** the FizzBee spec is written
- **WHEN** `fizz cloudformation.fizz` is run
- **THEN** all safety invariants pass with no counter-examples
