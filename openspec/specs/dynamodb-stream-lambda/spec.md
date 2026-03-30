# dynamodb-stream-lambda Specification

## Purpose
TBD - created by archiving change add-cross-service-dispatch-phase2. Update Purpose after archive.
## Requirements
### Requirement: DynamoDB Stream Lambda Event Source Mapping
The system SHALL support creating a Lambda event source mapping from a DynamoDB stream, and SHALL invoke the configured Lambda function when items are written to the mapped table.

#### Scenario: Event source mapping created successfully
- **GIVEN** a DynamoDB table with streams enabled exists and a Lambda function exists
- **WHEN** `create_event_source_mapping` is called with the stream ARN and function ARN
- **THEN** the mapping is stored and returns ACTIVE status

#### Scenario: Lambda invoked on PutItem
- **GIVEN** an event source mapping exists between a DynamoDB table and a Lambda function
- **WHEN** `put_item` is called on the table
- **THEN** the Lambda function is invoked with a stream record containing the new item image

#### Scenario: Lambda invoked on DeleteItem
- **GIVEN** an event source mapping exists between a DynamoDB table and a Lambda function
- **WHEN** `delete_item` is called on the table
- **THEN** the Lambda function is invoked with a stream record containing the old item image

### Requirement: DynamoDB Stream Event Envelope Format
The system SHALL invoke Lambda with a DynamoDB stream event in the standard AWS event envelope format.

#### Scenario: Event envelope matches AWS format
- **GIVEN** a DynamoDB item is written and triggers a Lambda invocation
- **WHEN** the Lambda function receives the event
- **THEN** the event MUST contain `Records` array where each record has `eventSource: "aws:dynamodb"`, `dynamodb.NewImage` (for inserts/modifies), and `dynamodb.OldImage` (for modifies/deletes)

### Requirement: DynamoDB Stream Trigger Lifecycle
The system SHALL track the lifecycle of a DynamoDB stream-triggered Lambda invocation from dispatch through to completion.

#### Scenario: Invocation transitions from IN_PROGRESS to SUCCESS
- **GIVEN** a DynamoDB item write triggers a Lambda invocation
- **WHEN** the Lambda function executes successfully
- **THEN** the invocation state transitions from `IN_PROGRESS` to `SUCCESS`

#### Scenario: Invocation transitions from IN_PROGRESS to FAILED
- **GIVEN** a DynamoDB item write triggers a Lambda invocation
- **WHEN** the Lambda function throws an unhandled exception
- **THEN** the invocation state transitions from `IN_PROGRESS` to `FAILED`

