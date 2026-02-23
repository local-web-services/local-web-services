## ADDED Requirements

### Requirement: LWS API Gateway Commands
The `lws apigateway` sub-command SHALL support a `test-invoke-method` operation that sends an HTTP request to a local API Gateway route. The command SHALL accept `--rest-api-name`, `--resource`, `--http-method`, and optional `--body` parameters. The CLI SHALL resolve the API Gateway port via discovery and make the request directly.

#### Scenario: Test invoke a GET route
- **WHEN** a developer runs `lws apigateway test-invoke-method --rest-api-name default --resource /orders --http-method GET`
- **THEN** the CLI SHALL send a GET request to `http://localhost:<port>/orders` and print the response status code, headers, and body as JSON

#### Scenario: Test invoke a POST route with body
- **WHEN** a developer runs `lws apigateway test-invoke-method --rest-api-name default --resource /orders --http-method POST --body '{"item": "widget"}'`
- **THEN** the CLI SHALL send a POST request with the given body and print the response as JSON

## MODIFIED Requirements

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
