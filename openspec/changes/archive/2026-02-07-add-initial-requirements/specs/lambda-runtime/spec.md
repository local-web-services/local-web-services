## ADDED Requirements

### Requirement: Node.js Handler Execution
LDK SHALL execute Node.js Lambda handlers by loading the handler module and invoking the exported handler function with a correctly shaped event and context object.

#### Scenario: Invoke Node.js handler
- **WHEN** an event triggers a Node.js Lambda function
- **THEN** LDK SHALL load the handler module from the asset directory, invoke the exported function with the event payload and a Lambda context object, and return the handler's response

### Requirement: Python Handler Execution
LDK SHALL execute Python Lambda handlers via subprocess with event serialization, supporting debugpy attachment for debugging.

#### Scenario: Invoke Python handler
- **WHEN** an event triggers a Python Lambda function
- **THEN** LDK SHALL start a Python subprocess, pass the serialized event, invoke the handler function, and return the deserialized response

### Requirement: Lambda Context Object
LDK SHALL provide a realistic Lambda context object to handlers including `functionName`, `memoryLimitInMB`, `getRemainingTimeInMillis()`, `awsRequestId`, and other standard context properties.

#### Scenario: Handler reads context properties
- **WHEN** a handler accesses `context.functionName` and `context.getRemainingTimeInMillis()`
- **THEN** `functionName` SHALL match the CDK-defined function name and `getRemainingTimeInMillis()` SHALL return the remaining time before timeout

### Requirement: Timeout Enforcement
LDK SHALL enforce the CDK-configured timeout for each Lambda function invocation and terminate the handler execution if the timeout is exceeded.

#### Scenario: Handler exceeds timeout
- **WHEN** a handler runs longer than the configured timeout
- **THEN** the invocation SHALL be terminated with a timeout error and subsequent invocations SHALL be unaffected

### Requirement: Environment Variable Injection
LDK SHALL set all environment variables defined in the CDK Lambda function configuration, resolving any `Ref` and `Fn::GetAtt` values to their local equivalents.

#### Scenario: Resolve table name environment variable
- **WHEN** a Lambda function has an environment variable `TABLE_NAME` that references a DynamoDB table via `Ref`
- **THEN** the environment variable SHALL be set to the local table name used by the DynamoDB provider

### Requirement: Java Handler Execution
LDK SHALL execute Java Lambda handlers via subprocess invocation.

#### Scenario: Invoke Java handler
- **WHEN** an event triggers a Java Lambda function
- **THEN** LDK SHALL invoke the Java handler via subprocess with the event payload and return the response

### Requirement: .NET Handler Execution
LDK SHALL execute .NET Lambda handlers via subprocess invocation.

#### Scenario: Invoke .NET handler
- **WHEN** an event triggers a .NET Lambda function
- **THEN** LDK SHALL invoke the .NET handler via subprocess with the event payload and return the response
