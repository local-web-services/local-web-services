## ADDED Requirements

### Requirement: Resource Discovery Endpoint
The management API SHALL provide a `GET /_ldk/resources` endpoint that returns a JSON object describing all active services, their ports, and their resources (names, ARNs, queue URLs). The `lws` CLI SHALL use this endpoint to resolve CDK construct names to service-specific identifiers.

#### Scenario: Discovery returns service metadata
- **WHEN** a client sends `GET /_ldk/resources` while `ldk dev` is running
- **THEN** the response SHALL include a JSON object with a `services` key mapping service names to their port and resource list

#### Scenario: Discovery returns empty when no resources
- **WHEN** a client sends `GET /_ldk/resources` and no resources of a given service type exist
- **THEN** that service key SHALL be absent from the response

### Requirement: LWS CLI Entry Point
The project SHALL provide an `lws` CLI binary (Typer app) registered as a `[project.scripts]` entry point. The CLI SHALL mirror AWS CLI command structure with service sub-commands. All commands SHALL output JSON and require a running `ldk dev` instance.

#### Scenario: LWS binary is available after install
- **WHEN** the `ldk` package is installed
- **THEN** the `lws` command SHALL be available on the PATH

#### Scenario: LWS outputs JSON
- **WHEN** any `lws` service command is executed
- **THEN** the output SHALL be valid JSON printed to stdout

### Requirement: LWS Step Functions Commands
The `lws stepfunctions` sub-command SHALL support `start-execution`, `describe-execution`, `list-executions`, and `list-state-machines` operations. The `--name` option SHALL accept a CDK construct name and the CLI SHALL resolve it to the correct ARN via discovery.

#### Scenario: Start a state machine execution by name
- **WHEN** a developer runs `lws stepfunctions start-execution --name MyStateMachine --input '{"key": "value"}'`
- **THEN** the CLI SHALL resolve the name to an ARN, call the Step Functions provider, and print the execution result as JSON

#### Scenario: List state machines
- **WHEN** a developer runs `lws stepfunctions list-state-machines`
- **THEN** the CLI SHALL return a JSON list of all state machines from the running `ldk dev` instance

### Requirement: LWS SQS Commands
The `lws sqs` sub-command SHALL support `send-message`, `receive-message`, `delete-message`, and `get-queue-attributes` operations using `--queue-name` to identify queues by CDK construct name.

#### Scenario: Send a message to a queue by name
- **WHEN** a developer runs `lws sqs send-message --queue-name MyQueue --message-body '{"order": 123}'`
- **THEN** the CLI SHALL resolve the queue name to a queue URL, send the message via the SQS wire protocol, and print the result as JSON

#### Scenario: Receive messages from a queue
- **WHEN** a developer runs `lws sqs receive-message --queue-name MyQueue`
- **THEN** the CLI SHALL receive available messages and print them as JSON

### Requirement: LWS SNS Commands
The `lws sns` sub-command SHALL support `publish`, `list-topics`, and `list-subscriptions` operations using `--topic-name` to identify topics by CDK construct name.

#### Scenario: Publish a message to a topic by name
- **WHEN** a developer runs `lws sns publish --topic-name MyTopic --message "Hello world"`
- **THEN** the CLI SHALL resolve the topic name to a topic ARN, publish the message, and print the result as JSON

#### Scenario: List all topics
- **WHEN** a developer runs `lws sns list-topics`
- **THEN** the CLI SHALL return a JSON list of all SNS topics

### Requirement: LWS S3 Commands
The `lws s3api` sub-command SHALL support `put-object`, `get-object`, `delete-object`, `list-objects-v2`, and `head-object` operations using `--bucket` and `--key` options.

#### Scenario: Put an object into a bucket
- **WHEN** a developer runs `lws s3api put-object --bucket MyBucket --key file.txt --body content.txt`
- **THEN** the CLI SHALL upload the file contents to the local S3 provider and print the result as JSON

#### Scenario: List objects in a bucket
- **WHEN** a developer runs `lws s3api list-objects-v2 --bucket MyBucket --prefix uploads/`
- **THEN** the CLI SHALL return a JSON list of objects matching the prefix

### Requirement: LWS DynamoDB Commands
The `lws dynamodb` sub-command SHALL support `put-item`, `get-item`, `delete-item`, `scan`, and `query` operations using `--table-name` to identify tables by CDK construct name.

#### Scenario: Put an item into a table
- **WHEN** a developer runs `lws dynamodb put-item --table-name MyTable --item '{"pk": {"S": "123"}}'`
- **THEN** the CLI SHALL send the item to the DynamoDB provider and print the result as JSON

#### Scenario: Scan a table
- **WHEN** a developer runs `lws dynamodb scan --table-name MyTable`
- **THEN** the CLI SHALL return all items in the table as JSON

### Requirement: LWS EventBridge Commands
The `lws events` sub-command SHALL support `put-events` and `list-rules` operations.

#### Scenario: Put events to an event bus
- **WHEN** a developer runs `lws events put-events --entries '[{"Source": "my.app", "DetailType": "OrderCreated", "Detail": "{}", "EventBusName": "MyBus"}]'`
- **THEN** the CLI SHALL send the events to the EventBridge provider and print the result as JSON

#### Scenario: List rules for an event bus
- **WHEN** a developer runs `lws events list-rules --event-bus-name MyBus`
- **THEN** the CLI SHALL return a JSON list of rules for the specified event bus

### Requirement: LWS Cognito Commands
The `lws cognito-idp` sub-command SHALL support `sign-up`, `confirm-sign-up`, and `initiate-auth` operations using `--user-pool-name` to identify pools by CDK construct name.

#### Scenario: Sign up a user
- **WHEN** a developer runs `lws cognito-idp sign-up --user-pool-name MyPool --username alice --password Secret123!`
- **THEN** the CLI SHALL register the user with the Cognito provider and print the result as JSON

#### Scenario: Authenticate a user
- **WHEN** a developer runs `lws cognito-idp initiate-auth --user-pool-name MyPool --username alice --password Secret123!`
- **THEN** the CLI SHALL authenticate the user and print the auth tokens as JSON
