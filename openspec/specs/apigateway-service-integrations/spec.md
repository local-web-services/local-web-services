# apigateway-service-integrations Specification

## Purpose
TBD - created by archiving change add-cross-service-dispatch-phase2. Update Purpose after archive.
## Requirements
### Requirement: API Gateway AWS Service Integration Execution
The system SHALL execute AWS service integrations configured on a REST API method, translating the inbound API Gateway request into the target service call and mapping the response back to the HTTP response.

#### Scenario: Integration executes on method invocation
- **GIVEN** a REST API method has an `AWS` type integration configured with a service URI
- **WHEN** the API endpoint is invoked
- **THEN** the system calls the target AWS service directly and returns the service response as the HTTP response body

#### Scenario: Integration type stored at configuration time
- **GIVEN** a REST API resource and method exist
- **WHEN** `PUT /restapis/{id}/resources/{rid}/methods/{method}/integration` is called with `type=AWS`
- **THEN** the integration configuration (type, httpMethod, uri, credentials) is stored and associated with the method

### Requirement: API Gateway DynamoDB Integration
The system SHALL support API Gateway integrations that call DynamoDB actions (PutItem, GetItem, Query, Scan) using the `arn:aws:apigateway:{region}:dynamodb:action/{Action}` URI pattern.

#### Scenario: DynamoDB PutItem integration executes
- **GIVEN** a method integration targets `dynamodb:action/PutItem`
- **WHEN** the API endpoint is invoked with a valid request body
- **THEN** the item is written to DynamoDB and the response contains the DynamoDB output

#### Scenario: DynamoDB GetItem integration executes
- **GIVEN** a method integration targets `dynamodb:action/GetItem`
- **WHEN** the API endpoint is invoked
- **THEN** the item is retrieved from DynamoDB and returned in the response

### Requirement: API Gateway SQS Integration
The system SHALL support API Gateway integrations that send messages to SQS using the `arn:aws:apigateway:{region}:sqs:path/{account}/{queue}` URI pattern.

#### Scenario: SQS SendMessage integration executes
- **GIVEN** a method integration targets an SQS queue
- **WHEN** the API endpoint is invoked with a message body
- **THEN** the message is sent to the SQS queue

### Requirement: API Gateway SNS Integration
The system SHALL support API Gateway integrations that publish to SNS topics using the `arn:aws:apigateway:{region}:sns:action/Publish` URI pattern.

#### Scenario: SNS Publish integration executes
- **GIVEN** a method integration targets an SNS topic
- **WHEN** the API endpoint is invoked
- **THEN** the message is published to the SNS topic

### Requirement: API Gateway S3 Integration
The system SHALL support API Gateway integrations that perform S3 object operations using the `arn:aws:apigateway:{region}:s3:path/{bucket}/{key}` URI pattern.

#### Scenario: S3 PutObject integration executes
- **GIVEN** a method integration targets an S3 bucket path
- **WHEN** the API endpoint is invoked with a body
- **THEN** the body is stored as an S3 object at the specified key

### Requirement: API Gateway StepFunctions Integration
The system SHALL support API Gateway integrations that start Step Functions executions using the `arn:aws:apigateway:{region}:states:action/StartExecution` URI pattern.

#### Scenario: StartExecution integration executes
- **GIVEN** a method integration targets a Step Functions state machine
- **WHEN** the API endpoint is invoked
- **THEN** a new Step Functions execution is started and the execution ARN is returned in the response

