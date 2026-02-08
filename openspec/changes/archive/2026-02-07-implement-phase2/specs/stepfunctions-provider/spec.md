## MODIFIED Requirements
### Requirement: Core ASL State Support
The Step Functions provider SHALL implement a local state machine execution engine using a recursive state walker architecture supporting the core Amazon States Language (ASL) states: Task, Choice, Wait, Parallel, Map, Pass, Succeed, and Fail. The engine SHALL process one state at a time, following `Next` transitions, and use `asyncio.gather` for concurrent branch/iteration execution in Parallel and Map states.

#### Scenario: Execute linear workflow
- **WHEN** a state machine with Task -> Pass -> Succeed states is started with input
- **THEN** the Task state SHALL invoke the configured Lambda handler, the Pass state SHALL transform the output, and the execution SHALL complete at the Succeed state

#### Scenario: Pass state with Result and ResultPath
- **WHEN** a Pass state defines `Result` and `ResultPath`
- **THEN** the state SHALL inject the Result value at the specified ResultPath in the output

### Requirement: Task State Lambda Invocation
Task states SHALL invoke local Lambda handlers with correct input/output processing as defined in the ASL definition. The `Resource` ARN SHALL be resolved to a local Lambda function via the `ResourceRegistry`. A minimal JSONPath subset supporting `$`, dot notation, bracket notation, and array indexing SHALL be used for `InputPath`, `OutputPath`, `ResultPath`, and `Parameters` processing.

#### Scenario: Task invokes handler with input processing
- **WHEN** a Task state has `InputPath: "$.order"` and `ResultPath: "$.result"`
- **THEN** the handler SHALL receive only the `order` field as input and the handler's output SHALL be placed at `$.result` in the state output

#### Scenario: Parameters with JSONPath references
- **WHEN** a Task state has `Parameters` with `"orderId.$": "$.order.id"`
- **THEN** the handler SHALL receive a constructed input with `orderId` extracted from the input via JSONPath

### Requirement: Choice State Branching
The provider SHALL support Choice states with comparison operators for branching execution based on input data. Supported operators SHALL include `StringEquals`, `StringGreaterThan`, `StringLessThan`, `NumericEquals`, `NumericGreaterThan`, `NumericLessThan`, `BooleanEquals`, `IsPresent`, `IsNull`, `IsString`, `IsNumeric`, `IsBoolean`, and compound rules (`And`, `Or`, `Not`). A `Default` branch SHALL be supported.

#### Scenario: Choice branches on value
- **WHEN** a Choice state checks `$.status` and the value is `"approved"`
- **THEN** execution SHALL follow the branch configured for `StringEquals: "approved"`

#### Scenario: Default branch when no match
- **WHEN** a Choice state has no matching rule but defines a `Default` branch
- **THEN** execution SHALL follow the Default branch

### Requirement: Retry and Catch Error Handling
The provider SHALL support Retry and Catch configurations on Task states for error handling. Retry SHALL support `ErrorEquals` pattern matching, `IntervalSeconds`, `MaxAttempts`, and `BackoffRate`. Catch SHALL match error names and transition to a fallback state with error information. Standard error names `States.ALL`, `States.TaskFailed`, and `States.Timeout` SHALL be supported.

#### Scenario: Retry on transient error
- **WHEN** a Task state fails with a retryable error and Retry is configured with `MaxAttempts: 3`
- **THEN** the task SHALL be retried up to 3 times with exponential backoff before falling through to Catch or failing the execution

#### Scenario: Catch routes to error handler
- **WHEN** a Task state fails with an error matching a Catch configuration
- **THEN** execution SHALL transition to the state specified in the Catch block with the error information at the configured ResultPath

### Requirement: Parallel and Map States
The provider SHALL support Parallel states (concurrent branches executed via `asyncio.gather`) and Map states (iterate over array items with `MaxConcurrency` controlled by `asyncio.Semaphore`). Parallel state output SHALL be an array of branch results in definition order. Map state output SHALL be an array of iteration results in input order.

#### Scenario: Parallel execution
- **WHEN** a Parallel state defines two branches, each invoking a different Lambda handler
- **THEN** both branches SHALL execute concurrently and the Parallel state output SHALL be an array of both branch results

#### Scenario: Map iteration
- **WHEN** a Map state receives an array of 5 items
- **THEN** the iterator state machine SHALL execute once per item and the Map state output SHALL be an array of 5 results

#### Scenario: Map with MaxConcurrency
- **WHEN** a Map state has `MaxConcurrency: 2` and receives an array of 5 items
- **THEN** at most 2 iterations SHALL execute concurrently

### Requirement: Execution Tracking
The provider SHALL track execution history including state transitions, input/output at each state, execution status, and duration, and display this in terminal output. Execution history SHALL be stored in memory by execution ARN and accessible via `DescribeExecution` and `ListExecutions` API endpoints.

#### Scenario: View execution trace
- **WHEN** a state machine execution completes
- **THEN** the terminal output SHALL show each state transition with the state name, duration, and input/output summary

### Requirement: Workflow Type Support
The provider SHALL support both Express and Standard workflow types with appropriate behavioral differences. Express workflows SHALL execute synchronously via `StartSyncExecution` (blocking until completion and returning the final output). Standard workflows SHALL execute asynchronously via `StartExecution` (returning the execution ARN immediately, with polling via `DescribeExecution`).

#### Scenario: Express workflow returns result synchronously
- **WHEN** an Express workflow is started via `StartSyncExecution`
- **THEN** the call SHALL block and return the final output when the execution completes

#### Scenario: Standard workflow returns ARN immediately
- **WHEN** a Standard workflow is started via `StartExecution`
- **THEN** the call SHALL return the execution ARN immediately and the execution SHALL proceed asynchronously
