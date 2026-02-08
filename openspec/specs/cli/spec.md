# cli Specification

## Purpose
TBD - created by archiving change add-initial-requirements. Update Purpose after archive.
## Requirements
### Requirement: Dev Command
The CLI SHALL provide an `ldk dev` command that starts the full local development environment from a CDK project directory. The command SHALL be built with Typer and use `asyncio.run()` for the event loop. The command SHALL run `cdk synth` if the cloud assembly is stale or missing, parse the cloud assembly, start local service equivalents for all discovered resources, wire event sources and triggers, configure SDK endpoint redirection, and begin watching for file changes.

#### Scenario: Start local environment from CDK project
- **WHEN** a developer runs `ldk dev` in a directory containing a valid CDK project
- **THEN** the cloud assembly is synthesized (if needed), all application resources are started locally, and the terminal displays a summary of routes, handlers, tables, queues, and other resources with their local endpoints

#### Scenario: Auto-synthesis when cloud assembly is stale
- **WHEN** a developer runs `ldk dev` and the `cdk.out` directory is missing or older than the CDK source files
- **THEN** LDK SHALL automatically run `cdk synth` before starting the local environment

#### Scenario: Graceful shutdown
- **WHEN** a developer presses Ctrl+C while `ldk dev` is running
- **THEN** all local services SHALL be gracefully shut down and state SHALL be persisted to disk

#### Scenario: Typer CLI framework
- **WHEN** the `ldk` CLI is invoked
- **THEN** the command SHALL be dispatched via Typer with the entry point `ldk.cli.main:app` and the async orchestration SHALL run inside `asyncio.run()`

### Requirement: Invoke Command
The CLI SHALL provide an `ldk invoke` command that directly invokes any handler with a custom event payload.

#### Scenario: Invoke handler with custom event
- **WHEN** a developer runs `ldk invoke <handlerName> --event '<json>'`
- **THEN** the specified handler SHALL be invoked with the provided JSON event and the response SHALL be displayed in the terminal

### Requirement: Send Command
The CLI SHALL provide an `ldk send` command that sends a message to a named queue.

#### Scenario: Send message to queue
- **WHEN** a developer runs `ldk send <queueName> '<messageJson>'`
- **THEN** the message SHALL be enqueued in the specified local queue and any connected event source mapping SHALL process it

### Requirement: Emit Command
The CLI SHALL provide an `ldk emit` command that triggers an event on a named resource.

#### Scenario: Emit S3 event
- **WHEN** a developer runs `ldk emit <bucketName> s3:ObjectCreated --key <keyPath>`
- **THEN** the corresponding S3 event notification handler SHALL be invoked with a correctly shaped S3 event

### Requirement: Trigger Command
The CLI SHALL provide an `ldk trigger` command that immediately fires a scheduled event.

#### Scenario: Trigger scheduled handler
- **WHEN** a developer runs `ldk trigger <scheduleName>`
- **THEN** the scheduled handler SHALL be invoked immediately regardless of the cron schedule

### Requirement: Reset Command
The CLI SHALL provide an `ldk reset` command that clears all persisted local state.

#### Scenario: Reset local state
- **WHEN** a developer runs `ldk reset`
- **THEN** all persisted data in local databases, queues, and filesystem storage SHALL be deleted and the next `ldk dev` session SHALL start with a clean state

### Requirement: Stop Command
The CLI SHALL provide an `ldk stop` command that stops a background LDK session.

#### Scenario: Stop background session
- **WHEN** a developer runs `ldk stop` while an `ldk dev --background` session is running
- **THEN** the background session SHALL be gracefully shut down

### Requirement: Background Mode
The CLI SHALL support a `--background` flag on `ldk dev` that runs the local environment as a background process.

#### Scenario: Start in background for CI
- **WHEN** a developer runs `ldk dev --background --port 3000`
- **THEN** the local environment SHALL start in the background and the command SHALL return immediately after startup is complete

### Requirement: Debug Mode
The CLI SHALL support an `--inspect` flag on `ldk dev` that starts handler processes with debugger support enabled.

#### Scenario: Enable Node.js debugging
- **WHEN** a developer runs `ldk dev --inspect`
- **THEN** Node.js handler processes SHALL start with the Node.js inspector enabled, allowing IDE debugger attachment

### Requirement: Local Details Column
The Discovered Resources table displayed at `ldk dev` startup SHALL include a "Local Details" column that shows contextual local access information for each resource. For API routes, the column SHALL show a copy-pasteable `lws apigateway test-invoke-method` command snippet. For Lambda functions, the column SHALL show the `ldk invoke <name>` command. For SDK-backed services (DynamoDB, SQS, S3, SNS, EventBridge, Step Functions, Cognito), the column SHALL show copy-pasteable `lws` CLI command snippets for the most common operations on that resource. For ECS services, the column SHALL be empty.

#### Scenario: API route shows lws test-invoke-method snippet
- **WHEN** an API route resource is displayed in the Discovered Resources table
- **THEN** the Local Details column SHALL show a `lws apigateway test-invoke-method` command snippet including the resource path and HTTP method

#### Scenario: Lambda function shows invoke command
- **WHEN** a Lambda function resource is displayed in the Discovered Resources table
- **THEN** the Local Details column SHALL show `ldk invoke <function-name>`

#### Scenario: DynamoDB table shows lws CLI snippets
- **WHEN** a DynamoDB table resource is displayed in the Discovered Resources table
- **THEN** the Local Details column SHALL show `lws` CLI snippets including `lws dynamodb scan --table-name <name>` and other common operations

#### Scenario: SQS queue shows lws CLI snippets
- **WHEN** an SQS queue resource is displayed in the Discovered Resources table
- **THEN** the Local Details column SHALL show `lws` CLI snippets including `lws sqs send-message --queue-name <name>` and `lws sqs receive-message --queue-name <name>`

#### Scenario: S3 bucket shows lws CLI snippets
- **WHEN** an S3 bucket resource is displayed in the Discovered Resources table
- **THEN** the Local Details column SHALL show `lws` CLI snippets including `lws s3api list-objects-v2 --bucket <name>` and other common operations

#### Scenario: SNS topic shows lws CLI snippets
- **WHEN** an SNS topic resource is displayed in the Discovered Resources table
- **THEN** the Local Details column SHALL show `lws` CLI snippets including `lws sns publish --topic-name <name>`

#### Scenario: EventBridge bus shows lws CLI snippets
- **WHEN** an EventBridge event bus resource is displayed in the Discovered Resources table
- **THEN** the Local Details column SHALL show `lws` CLI snippets including `lws events list-rules --event-bus-name <name>`

#### Scenario: Step Functions state machine shows lws CLI snippets
- **WHEN** a Step Functions state machine resource is displayed in the Discovered Resources table
- **THEN** the Local Details column SHALL show `lws` CLI snippets including `lws stepfunctions start-execution --name <name>`

#### Scenario: Cognito user pool shows lws CLI snippets
- **WHEN** a Cognito user pool resource is displayed in the Discovered Resources table
- **THEN** the Local Details column SHALL show `lws` CLI snippets including `lws cognito-idp sign-up --user-pool-name <name>`

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

### Requirement: LWS API Gateway Commands
The `lws apigateway` sub-command SHALL support a `test-invoke-method` operation that sends an HTTP request to a local API Gateway route. The command SHALL accept `--rest-api-name`, `--resource`, `--http-method`, and optional `--body` parameters. The CLI SHALL resolve the API Gateway port via discovery and make the request directly.

#### Scenario: Test invoke a GET route
- **WHEN** a developer runs `lws apigateway test-invoke-method --rest-api-name default --resource /orders --http-method GET`
- **THEN** the CLI SHALL send a GET request to `http://localhost:<port>/orders` and print the response status code, headers, and body as JSON

#### Scenario: Test invoke a POST route with body
- **WHEN** a developer runs `lws apigateway test-invoke-method --rest-api-name default --resource /orders --http-method POST --body '{"item": "widget"}'`
- **THEN** the CLI SHALL send a POST request with the given body and print the response as JSON

### Requirement: LWS Status Command
The `lws` CLI SHALL provide a `status` command that displays the current state of the running `ldk dev` instance. The command SHALL query the management API endpoints `GET /_ldk/status` and `GET /_ldk/resources`. By default the output SHALL be a human-readable table showing the overall LDK running state, each provider with its health status, and each service with its port and resource count. When `--json` is passed the output SHALL be JSON. If `ldk dev` is not running, the command SHALL print an error message and exit with code 1.

#### Scenario: Show status as table by default
- **WHEN** a developer runs `lws status` while `ldk dev` is running
- **THEN** the output SHALL be a human-readable table showing that LDK is running, listing each provider with a healthy/unhealthy indicator, and listing each service with its port and resource count

#### Scenario: Show status as JSON
- **WHEN** a developer runs `lws status --json` while `ldk dev` is running
- **THEN** the output SHALL be a JSON object containing `running`, `providers`, and `services` keys

#### Scenario: Show error when ldk dev is not running
- **WHEN** a developer runs `lws status` and `ldk dev` is not running
- **THEN** the command SHALL print an error indicating it cannot connect and exit with code 1

#### Scenario: Custom port
- **WHEN** a developer runs `lws status --port 4000`
- **THEN** the command SHALL query the management API on port 4000 instead of the default

