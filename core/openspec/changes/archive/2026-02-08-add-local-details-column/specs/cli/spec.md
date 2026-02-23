## ADDED Requirements
### Requirement: Local Details Column
The Discovered Resources table displayed at `ldk dev` startup SHALL include a "Local Details" column that shows contextual local access information for each resource. For API routes, the column SHALL show the browsable URL combined with the method and handler info. For SDK-backed services (DynamoDB, SQS, S3, SNS, EventBridge, Step Functions, Cognito), the column SHALL show the local endpoint URL and the corresponding `AWS_ENDPOINT_URL_*` environment variable name. For Lambda functions, the column SHALL show the `ldk invoke <name>` command. For ECS services, the column SHALL be empty.

#### Scenario: API route shows browsable URL with method and handler
- **WHEN** an API route resource is displayed in the Discovered Resources table
- **THEN** the Local Details column SHALL show the full local URL (e.g. `http://localhost:3000/orders`) combined with the HTTP method and handler name

#### Scenario: DynamoDB table shows endpoint and env var
- **WHEN** a DynamoDB table resource is displayed in the Discovered Resources table
- **THEN** the Local Details column SHALL show the local endpoint URL and the environment variable name `AWS_ENDPOINT_URL_DYNAMODB` separated by a pipe character

#### Scenario: Lambda function shows invoke command
- **WHEN** a Lambda function resource is displayed in the Discovered Resources table
- **THEN** the Local Details column SHALL show `ldk invoke <function-name>`

#### Scenario: SDK-backed service shows endpoint and env var
- **WHEN** an SQS, S3, SNS, EventBridge, Step Functions, or Cognito resource is displayed in the Discovered Resources table
- **THEN** the Local Details column SHALL show the local endpoint URL and the corresponding AWS endpoint URL environment variable name separated by a pipe character
