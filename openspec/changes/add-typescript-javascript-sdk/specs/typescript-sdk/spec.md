## ADDED Requirements

### Requirement: TypeScript LwsSession
The `local-web-services-typescript-sdk` package SHALL export an `LwsSession` class that starts
in-process AWS service emulators and provides pre-configured `@aws-sdk` clients pointing at them.

#### Scenario: Session starts and stops providers
- **WHEN** an `LwsSession` is constructed with resource specs and `start()` is called
- **THEN** each required provider starts on a free port
- **AND** `AWS_ENDPOINT_URL_*` environment variables are set in the current process
- **WHEN** `stop()` is called
- **THEN** all providers stop and environment variables are restored

#### Scenario: client() returns a configured AWS SDK client
- **WHEN** `session.client('dynamodb')` is called
- **THEN** the returned `DynamoDBClient` sends requests to the local DynamoDB provider

### Requirement: TypeScript Resource Specs
The TypeScript SDK SHALL export resource spec classes that declare the resources needed for a
test: `DynamoTable`, `SqsQueue`, `S3Bucket`, `SnsTopic`, `SsmParameter`, `Secret`, `StateMachine`.

#### Scenario: DynamoTable is created before test body runs
- **WHEN** an `LwsSession` is started with `DynamoTable('Orders', { hashKey: 'id' })`
- **THEN** the `Orders` table exists and is ready before `start()` resolves

#### Scenario: SqsQueue URL is available via session helper
- **WHEN** an `LwsSession` is started with `SqsQueue('OrderQueue')`
- **THEN** `session.queueUrl('OrderQueue')` returns the local queue URL

### Requirement: TypeScript CDK and HCL Discovery
The TypeScript SDK SHALL support `LwsSession.fromCdk(path)` and `LwsSession.fromHcl(path)` to
auto-discover resource definitions from a CDK project or Terraform state file.

#### Scenario: fromCdk discovers DynamoDB tables
- **WHEN** `LwsSession.fromCdk('../my-cdk-project')` is called
- **THEN** the session starts with all DynamoDB tables found in the CDK output

### Requirement: TypeScript Vitest Fixtures
The TypeScript SDK SHALL register a `lwsSession` Vitest fixture that starts the session before
tests and stops it after, configured via a `lwsSessionSpec()` export in the test file or
`vitest.setup.ts`.

#### Scenario: lwsSession fixture is available in tests
- **WHEN** a test imports `lwsSession` from the SDK's fixtures module
- **THEN** the fixture provides a started `LwsSession` for the duration of the test suite

### Requirement: TypeScript Management API Builders
The TypeScript SDK SHALL export builders for chaos, fake, capacity, and IAM auth management
operations, mirroring the Python SDK's `_builders/` module.

#### Scenario: Chaos builder enables error injection
- **WHEN** `new ChaosBuilder(session).enableError('dynamodb', 'PutItem', 'ProvisionedThroughputExceededException')` is called
- **THEN** subsequent `PutItem` calls to the local DynamoDB return that error
