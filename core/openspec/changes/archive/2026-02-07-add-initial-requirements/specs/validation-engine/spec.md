## ADDED Requirements

### Requirement: Schema Validation
The validation engine SHALL validate that handler data access operations match the CDK-defined table schemas. If a handler attempts to write an item that does not match the table's key schema, the engine SHALL flag the error.

#### Scenario: Invalid key schema detected
- **WHEN** a handler calls `putItem` on a table with partition key `orderId (S)` but provides a numeric value for `orderId`
- **THEN** the validation engine SHALL report a schema validation error with the table name, expected key type, and actual value type

### Requirement: Permission Validation
The validation engine SHALL validate that handlers only access resources they have been granted permission to in the CDK (via `grantRead`, `grantWrite`, etc.). Unauthorized access attempts SHALL produce warnings or errors.

#### Scenario: Unauthorized table access detected
- **WHEN** a handler attempts to write to a DynamoDB table that it has not been granted write permission to in the CDK
- **THEN** the validation engine SHALL report a permission validation warning with the handler name, resource name, and the operation attempted

### Requirement: Environment Variable Validation
The validation engine SHALL validate that environment variable references in handler configurations resolve to actual resources in the CDK definition.

#### Scenario: Missing resource reference detected
- **WHEN** a handler's environment variable `TABLE_NAME` references a resource that does not exist in the CDK definition
- **THEN** the validation engine SHALL report a configuration validation error identifying the missing reference

### Requirement: Event Shape Validation
The validation engine SHALL validate that events delivered to handlers match the expected shape for their trigger type (API Gateway proxy event, SQS event, S3 event, etc.).

#### Scenario: Malformed event detected
- **WHEN** a handler connected to an API Gateway trigger receives an event that is missing required API Gateway proxy event fields
- **THEN** the validation engine SHALL report an event shape validation error with details about the missing fields

### Requirement: Configurable Strictness
The validation engine SHALL support configurable strictness levels: warn mode (default) that logs validation issues without blocking execution, and strict mode that fails on validation errors.

#### Scenario: Warn mode logs but continues
- **WHEN** a permission validation issue is detected in warn mode
- **THEN** the issue SHALL be logged as a warning and the operation SHALL proceed

#### Scenario: Strict mode blocks execution
- **WHEN** a permission validation issue is detected in strict mode
- **THEN** the operation SHALL fail with a validation error and the handler SHALL receive an error response
