## ADDED Requirements

### Requirement: Core ASL State Support
The Step Functions provider SHALL implement a local state machine execution engine supporting the core Amazon States Language (ASL) states: Task, Choice, Wait, Parallel, Map, Pass, Succeed, and Fail.

#### Scenario: Execute linear workflow
- **WHEN** a state machine with Task -> Pass -> Succeed states is started with input
- **THEN** the Task state SHALL invoke the configured Lambda handler, the Pass state SHALL transform the output, and the execution SHALL complete at the Succeed state

### Requirement: Task State Lambda Invocation
Task states SHALL invoke local Lambda handlers with correct input/output processing as defined in the ASL definition.

#### Scenario: Task invokes handler with input processing
- **WHEN** a Task state has `InputPath: "$.order"` and `ResultPath: "$.result"`
- **THEN** the handler SHALL receive only the `order` field as input and the handler's output SHALL be placed at `$.result` in the state output

### Requirement: Choice State Branching
The provider SHALL support Choice states with comparison operators for branching execution based on input data.

#### Scenario: Choice branches on value
- **WHEN** a Choice state checks `$.status` and the value is `"approved"`
- **THEN** execution SHALL follow the branch configured for `StringEquals: "approved"`

### Requirement: Retry and Catch Error Handling
The provider SHALL support Retry and Catch configurations on Task states for error handling.

#### Scenario: Retry on transient error
- **WHEN** a Task state fails with a retryable error and Retry is configured with `MaxAttempts: 3`
- **THEN** the task SHALL be retried up to 3 times before falling through to Catch or failing the execution

#### Scenario: Catch routes to error handler
- **WHEN** a Task state fails with an error matching a Catch configuration
- **THEN** execution SHALL transition to the state specified in the Catch block with the error information

### Requirement: Parallel and Map States
The provider SHALL support Parallel states (concurrent branches) and Map states (iterate over array items).

#### Scenario: Parallel execution
- **WHEN** a Parallel state defines two branches, each invoking a different Lambda handler
- **THEN** both branches SHALL execute and the Parallel state output SHALL be an array of both branch results

#### Scenario: Map iteration
- **WHEN** a Map state receives an array of 5 items
- **THEN** the iterator state machine SHALL execute once per item and the Map state output SHALL be an array of 5 results

### Requirement: Execution Tracking
The provider SHALL track execution history including state transitions, input/output at each state, and execution status, and display this in terminal output.

#### Scenario: View execution trace
- **WHEN** a state machine execution completes
- **THEN** the terminal output SHALL show each state transition with the state name, duration, and input/output summary

### Requirement: Workflow Type Support
The provider SHALL support both Express and Standard workflow types with appropriate behavioral differences (Express: synchronous execution; Standard: asynchronous execution).

#### Scenario: Express workflow returns result synchronously
- **WHEN** an Express workflow is started
- **THEN** the start execution call SHALL block and return the final output when the execution completes
