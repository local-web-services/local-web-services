# cli Specification

## Purpose
TBD - created by archiving change add-initial-requirements. Update Purpose after archive.
## Requirements
### Requirement: Dev Command
The CLI SHALL provide an `ldk dev` command that starts the full local development environment from a CDK project directory or a Terraform/OpenTofu project directory. The command SHALL be built with Typer and use `asyncio.run()` for the event loop. In CDK mode, the command SHALL run `cdk synth` if the cloud assembly is stale or missing, parse the cloud assembly, start local service equivalents for all discovered resources, wire event sources and triggers, configure SDK endpoint redirection, and begin watching for file changes. In Terraform mode, the command SHALL start all service providers in always-on mode, generate a `_lws_override.tf` provider override file pointing at local endpoints, and clean up the override file on shutdown.

#### Scenario: Start local environment from CDK project
- **WHEN** a developer runs `ldk dev` in a directory containing a valid CDK project
- **THEN** the cloud assembly is synthesized (if needed), all application resources are started locally, and the terminal displays a summary of routes, handlers, tables, queues, and other resources with their local endpoints

#### Scenario: Start local environment from Terraform project
- **WHEN** a developer runs `ldk dev` in a directory containing `.tf` files and no `cdk.out`
- **THEN** all service providers SHALL start in always-on mode, a `_lws_override.tf` file SHALL be generated with AWS provider endpoint overrides pointing to local ports, and the terminal SHALL display the available service endpoints and instruct the user to run `terraform apply`

#### Scenario: Auto-detect project type
- **WHEN** a developer runs `ldk dev` without a `--mode` flag
- **THEN** LWS SHALL detect the project type by checking for `.tf` files (Terraform mode) or `cdk.out` directory (CDK mode) and start accordingly

#### Scenario: Explicit mode selection
- **WHEN** a developer runs `ldk dev --mode terraform` or `ldk dev --mode cdk`
- **THEN** LWS SHALL use the specified mode regardless of file detection

#### Scenario: Ambiguous project type
- **WHEN** a developer runs `ldk dev` in a directory containing both `.tf` files and a `cdk.out` directory without specifying `--mode`
- **THEN** LWS SHALL display an error asking the user to specify `--mode cdk` or `--mode terraform`

#### Scenario: No project detected
- **WHEN** a developer runs `ldk dev` in a directory with neither `.tf` files nor `cdk.out`
- **THEN** LWS SHALL display an error explaining that no CDK or Terraform project was found

#### Scenario: Auto-synthesis when cloud assembly is stale
- **WHEN** a developer runs `ldk dev` and the `cdk.out` directory is missing or older than the CDK source files
- **THEN** LDK SHALL automatically run `cdk synth` before starting the local environment

#### Scenario: Graceful shutdown in Terraform mode
- **WHEN** a developer presses Ctrl+C while `ldk dev` is running in Terraform mode
- **THEN** all local services SHALL be gracefully shut down and the `_lws_override.tf` file SHALL be deleted

#### Scenario: Stale override file cleanup
- **WHEN** a developer runs `ldk dev` in Terraform mode and a `_lws_override.tf` file already exists with the LWS marker comment
- **THEN** LWS SHALL overwrite the stale file with a fresh override

#### Scenario: Refuse to overwrite user override file
- **WHEN** a developer runs `ldk dev` in Terraform mode and a `_lws_override.tf` file exists without the LWS marker comment
- **THEN** LWS SHALL display an error and refuse to overwrite the file

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

### Requirement: Web GUI Dashboard
The management API SHALL serve a web-based dashboard at `GET /_ldk/gui` as a self-contained HTML page with inline CSS and JavaScript. The dashboard SHALL provide three capabilities: a real-time log viewer, a resource explorer, and operation invocation. The dashboard SHALL require no external build step or frontend framework installation.

#### Scenario: Access dashboard in browser
- **WHEN** a developer navigates to `http://localhost:<port>/_ldk/gui` while `ldk dev` is running
- **THEN** the browser SHALL display the dashboard with log viewer, resource explorer, and operation invocation sections

#### Scenario: Dashboard works without internet
- **WHEN** a developer opens the dashboard with no internet connection
- **THEN** the dashboard SHALL function fully since all CSS and JavaScript are inlined

### Requirement: WebSocket Log Endpoint
The management API SHALL provide a WebSocket endpoint at `/_ldk/ws/logs` that streams structured log entries as JSON messages. On connection, the endpoint SHALL send any buffered recent log entries before streaming live entries. Each message SHALL be a JSON object with at minimum `timestamp`, `level`, and `message` fields.

#### Scenario: Stream logs via WebSocket
- **WHEN** a WebSocket client connects to `ws://localhost:<port>/_ldk/ws/logs`
- **THEN** the client SHALL receive buffered log entries followed by live entries as they occur

#### Scenario: Multiple clients receive same logs
- **WHEN** two WebSocket clients are connected to the log endpoint and a log entry is produced
- **THEN** both clients SHALL receive the log entry

### Requirement: GUI Live Log Viewer
The dashboard log viewer SHALL display log entries streamed via the WebSocket endpoint with color coding by log level. The viewer SHALL auto-scroll to show the latest entries and provide a pause/resume button to freeze scrolling. HTTP request logs SHALL show method, path, handler, duration, and status code. Error logs SHALL be highlighted in red.

#### Scenario: Logs auto-scroll
- **WHEN** new log entries arrive while the log viewer is active and not paused
- **THEN** the viewer SHALL scroll to show the latest entry

#### Scenario: Pause and resume log scrolling
- **WHEN** the developer clicks the pause button
- **THEN** new log entries SHALL continue to be appended but the viewer SHALL not auto-scroll until resumed

### Requirement: GUI Resource Explorer
The dashboard resource explorer SHALL display all services and their resources by fetching `GET /_ldk/resources` and `GET /_ldk/status`. Resources SHALL be grouped by service type and show the service port, resource names, and provider health status. The explorer SHALL provide a refresh button to reload the data.

#### Scenario: View all resources
- **WHEN** the developer opens the resource explorer tab
- **THEN** the dashboard SHALL display all services grouped by type with their port, health status, and resource list

#### Scenario: Refresh resource data
- **WHEN** the developer clicks the refresh button
- **THEN** the dashboard SHALL re-fetch resource and status data and update the display

### Requirement: GUI Operation Invocation
The dashboard SHALL allow developers to invoke operations on resources directly from the browser. Each resource SHALL display action buttons matching the operations available via the `lws` CLI. Clicking an action button SHALL present a form for required parameters, execute the operation against the service wire-protocol endpoint, and display the JSON result inline.

#### Scenario: Invoke DynamoDB scan from GUI
- **WHEN** the developer clicks the "Scan" action on a DynamoDB table resource
- **THEN** the dashboard SHALL send a DynamoDB Scan request to the DynamoDB service port and display the result as formatted JSON

#### Scenario: Invoke SQS send-message from GUI
- **WHEN** the developer fills in the message body and clicks "Send Message" on an SQS queue resource
- **THEN** the dashboard SHALL send a SendMessage request to the SQS service port and display the result

#### Scenario: Invoke API Gateway test from GUI
- **WHEN** the developer selects an API route, fills in optional body, and clicks "Test Invoke"
- **THEN** the dashboard SHALL send the HTTP request to the API Gateway port and display the response status, headers, and body

#### Scenario: Display invocation error
- **WHEN** an operation invocation fails
- **THEN** the dashboard SHALL display the error message in a visible error state

### Requirement: Terraform Override File Generation
In Terraform mode, LWS SHALL generate a `_lws_override.tf` file in the project root that configures the AWS provider to use local LWS endpoints. The file SHALL contain an `aws` provider block with `endpoints` for all supported services (dynamodb, sqs, s3, sns, cloudwatchevents, stepfunctions, cognitoidp), dummy credentials, and flags to skip AWS credential validation and metadata checks. The file SHALL include a marker comment on the first line identifying it as LWS-generated. The file SHALL be removed on graceful shutdown.

#### Scenario: Override file contains correct endpoints
- **WHEN** LWS generates the override file with base port 3000
- **THEN** the file SHALL contain endpoint overrides with `dynamodb = "http://localhost:3001"`, `sqs = "http://localhost:3002"`, `s3 = "http://localhost:3003"`, `sns = "http://localhost:3004"`, `cloudwatchevents = "http://localhost:3005"`, `stepfunctions = "http://localhost:3006"`, and `cognitoidp = "http://localhost:3007"`

#### Scenario: Override file includes marker comment
- **WHEN** LWS generates the override file
- **THEN** the first line SHALL be `# Auto-generated by LWS - do not edit. Deleted on shutdown.`

#### Scenario: Override file includes s3 force path style
- **WHEN** LWS generates the override file
- **THEN** the provider block SHALL include `s3_use_path_style = true` to ensure S3 requests use path-style addressing compatible with the local provider

#### Scenario: Override file works with OpenTofu
- **WHEN** a developer uses OpenTofu instead of Terraform
- **THEN** the `_lws_override.tf` file SHALL work identically since OpenTofu uses the same provider configuration format

### Requirement: Gitignore Management
When generating the Terraform override file, LWS SHALL check the project's `.gitignore` file (if present) for the `_lws_override.tf` entry. If the entry is not present, LWS SHALL append it to `.gitignore`. If no `.gitignore` exists, LWS SHALL create one containing the entry.

#### Scenario: Add override file to existing gitignore
- **WHEN** LWS generates the override file and `.gitignore` exists but does not contain `_lws_override.tf`
- **THEN** LWS SHALL append `_lws_override.tf` to `.gitignore`

#### Scenario: Gitignore already contains entry
- **WHEN** LWS generates the override file and `.gitignore` already contains `_lws_override.tf`
- **THEN** LWS SHALL not modify `.gitignore`

#### Scenario: No gitignore exists
- **WHEN** LWS generates the override file and no `.gitignore` file exists
- **THEN** LWS SHALL create `.gitignore` with `_lws_override.tf` as its content

### Requirement: Terraform Stub Operations
Each service provider's HTTP routes SHALL handle unrecognised operations by returning an empty success response instead of an error. This SHALL be logged at warning level with the operation name. This ensures that `terraform apply` does not fail when the AWS provider calls operations that LWS has not fully implemented (e.g., TagResource, ListTagsForResource, DescribeTimeToLive).

#### Scenario: Unknown DynamoDB operation returns success
- **WHEN** a Terraform apply sends a `DynamoDB_20120810.TagResource` request to the DynamoDB endpoint
- **THEN** the endpoint SHALL return HTTP 200 with an empty JSON body and log a warning

#### Scenario: Unknown Cognito operation returns success
- **WHEN** a Terraform apply sends an unrecognised `AWSCognitoIdentityProviderService.*` operation
- **THEN** the endpoint SHALL return HTTP 200 with an empty JSON body and log a warning

#### Scenario: Known operations still work normally
- **WHEN** a recognised operation like `CreateTable` is called
- **THEN** it SHALL be handled by its existing handler, not the stub

