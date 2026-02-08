# sdk-redirection Specification

## Purpose
TBD - created by archiving change add-initial-requirements. Update Purpose after archive.
## Requirements
### Requirement: Endpoint URL Configuration
LDK SHALL configure AWS SDK endpoint redirection by setting `AWS_ENDPOINT_URL` and service-specific environment variables (`AWS_ENDPOINT_URL_DYNAMODB`, `AWS_ENDPOINT_URL_SQS`, etc.) to point at local service implementations.

#### Scenario: SDK calls routed to local services
- **WHEN** a Lambda handler calls `dynamodb.putItem()` using the AWS SDK
- **THEN** the SDK SHALL route the request to LDK's local DynamoDB provider via the configured endpoint URL, without any code changes to the handler

### Requirement: Transparent Redirection
SDK redirection SHALL require zero changes to application code. The same application code SHALL run locally under LDK and in production on AWS with no wrapper libraries, no conditional imports, and no environment-specific code paths.

#### Scenario: Identical code in local and production
- **WHEN** a developer writes a Lambda handler that uses the standard AWS SDK to access DynamoDB
- **THEN** the handler code SHALL work identically under LDK locally and when deployed to AWS, with only the endpoint resolution differing

### Requirement: Multi-SDK Compatibility
SDK redirection SHALL work with AWS SDK for JavaScript v2 and v3, boto3 for Python, and the AWS SDK for Java and C#.

#### Scenario: Python handler SDK redirection
- **WHEN** a Python Lambda handler uses boto3 to call DynamoDB
- **THEN** boto3 SHALL respect the `AWS_ENDPOINT_URL_DYNAMODB` environment variable and route requests to the local provider

