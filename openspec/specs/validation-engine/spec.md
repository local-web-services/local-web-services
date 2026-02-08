# validation-engine Specification

## Purpose
TBD - created by archiving change add-initial-requirements. Update Purpose after archive.
## Requirements
### Requirement: Schema Validation
The validation engine SHALL validate that handler data access operations match the CDK-defined table schemas. If a handler attempts to write an item that does not match the table's key schema, the engine SHALL flag the error. Validation SHALL check partition key and sort key presence and type (S, N, B) on `PutItem`, `UpdateItem`, and `DeleteItem` operations, as well as GSI/LSI key validation on queries.

#### Scenario: Invalid key schema detected
- **WHEN** a handler calls `putItem` on a table with partition key `orderId (S)` but provides a numeric value for `orderId`
- **THEN** the validation engine SHALL report a schema validation error with the table name, expected key type, and actual value type

#### Scenario: Missing required key detected
- **WHEN** a handler calls `putItem` on a table with partition key `orderId` and sort key `timestamp` but omits the sort key
- **THEN** the validation engine SHALL report a schema validation error identifying the missing sort key

### Requirement: Permission Validation
The validation engine SHALL validate that handlers only access resources they have been granted permission to in the CDK (via `grantRead`, `grantWrite`, etc.). Unauthorized access attempts SHALL produce warnings or errors depending on the configured strictness level. The permission map SHALL be derived from the application graph permission edges, with `grantRead` allowing get/query/scan, `grantWrite` allowing put/delete, and `grantReadWrite` allowing all operations.

#### Scenario: Unauthorized table access detected
- **WHEN** a handler attempts to write to a DynamoDB table that it has not been granted write permission to in the CDK
- **THEN** the validation engine SHALL report a permission validation warning with the handler name, resource name, and the operation attempted

#### Scenario: Authorized access passes validation
- **WHEN** a handler with `grantRead` permission performs a `getItem` operation on a DynamoDB table
- **THEN** the validation engine SHALL not report any permission issues

### Requirement: Environment Variable Validation
The validation engine SHALL validate that environment variable references in handler configurations resolve to actual resources in the CDK definition. Validation SHALL run at startup by scanning all Lambda environment variables for values that look like resource references (ARN patterns, table names matching CDK resources).

#### Scenario: Missing resource reference detected
- **WHEN** a handler's environment variable `TABLE_NAME` references a resource that does not exist in the CDK definition
- **THEN** the validation engine SHALL report a configuration validation error identifying the missing reference

### Requirement: Event Shape Validation
The validation engine SHALL validate that events delivered to handlers match the expected shape for their trigger type (API Gateway proxy event, SQS event, S3 event, SNS event, EventBridge event, etc.). Event schemas SHALL be defined as Pydantic models per trigger type and validated before handler invocation.

#### Scenario: Malformed event detected
- **WHEN** a handler connected to an API Gateway trigger receives an event that is missing required API Gateway proxy event fields
- **THEN** the validation engine SHALL report an event shape validation error with details about the missing fields

### Requirement: Configurable Strictness
The validation engine SHALL support configurable strictness levels: warn mode (default) that logs validation issues without blocking execution, and strict mode that fails on validation errors. Strictness SHALL be configurable globally via `validation.strictness` in `ldk.yaml` and per-category via `validation.<category>` overrides. The `--strict` CLI flag SHALL override the configuration file setting.

#### Scenario: Warn mode logs but continues
- **WHEN** a permission validation issue is detected in warn mode
- **THEN** the issue SHALL be logged as a warning and the operation SHALL proceed

#### Scenario: Strict mode blocks execution
- **WHEN** a permission validation issue is detected in strict mode
- **THEN** the operation SHALL fail with a validation error and the handler SHALL receive an error response

#### Scenario: Per-category strictness override
- **WHEN** global strictness is warn but `validation.schema` is set to strict
- **THEN** schema validation errors SHALL block execution while permission validation issues SHALL only warn

