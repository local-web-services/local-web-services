## MODIFIED Requirements

### Requirement: JSONata Query Language Selection
The Step Functions engine SHALL support `"QueryLanguage": "JSONata"` on a state machine
definition or on an individual state, causing that scope to use JSONata instead of JSONPath for
data transformation. The Choice state SHALL also accept `"QueryLanguage"` at state level to
enable JSONata-mode rule evaluation.

#### Scenario: State machine-level QueryLanguage applies to all states
- **GIVEN** a state machine definition with `"QueryLanguage": "JSONata"` at the top level
- **WHEN** the execution runs any state in that machine
- **THEN** JSONata mode is used for that state's data processing

#### Scenario: Per-state QueryLanguage overrides the state machine default
- **GIVEN** a state machine with `"QueryLanguage": "JSONPath"` at the top level
- **AND** a single state with `"QueryLanguage": "JSONata"`
- **WHEN** that state executes
- **THEN** JSONata mode is used for that state only

#### Scenario: Choice state in JSONata mode evaluates Condition expressions
- **GIVEN** a Choice state with `"QueryLanguage": "JSONata"` and a rule using `"Condition"`
- **WHEN** the state evaluates and the Condition expression returns true
- **THEN** the matched rule's Next state is selected

## ADDED Requirements

### Requirement: JSONata Assign Field
In JSONata mode the system SHALL accept an `Assign` field on Pass, Task, Choice, Wait,
Succeed, Map, and Parallel states. String values wrapped in `{%...%}` SHALL be evaluated
as JSONata expressions. The resulting key-value pairs SHALL be stored in
`$states.context.variables` and SHALL be accessible by downstream states via that binding.

#### Scenario: Assign stores a computed value accessible in downstream states
- **GIVEN** a state machine with two states where the first Pass state has `"Assign": {"myVar": "{% $states.input.x %}"}`
- **WHEN** the first state executes with input `{"x": 42}`
- **THEN** the second state can read `$states.context.variables.myVar` and get `42`

#### Scenario: Assign literal value is stored as-is
- **GIVEN** a Pass state in JSONata mode with `"Assign": {"label": "fixed"}`
- **WHEN** the state executes
- **THEN** `$states.context.variables.label` is `"fixed"` in downstream states

### Requirement: JSONata Choice.Condition
In JSONata mode the system SHALL accept a `Condition` field on choice rules instead of
JSONPath comparison operators. The `Condition` value SHALL be a `{%...%}` JSONata boolean
expression. When evaluated against the state's effective input, if the expression returns
true the rule matches and the rule's `Next` state is selected.

#### Scenario: Condition expression evaluating to true matches the rule
- **GIVEN** a Choice state with a rule `{"Condition": "{% $states.input.score > 50 %}", "Next": "High"}`
- **WHEN** the state executes with input `{"score": 75}`
- **THEN** the next state is `"High"`

#### Scenario: Condition expression evaluating to false skips the rule
- **GIVEN** a Choice state with a rule `{"Condition": "{% $states.input.score > 50 %}", "Next": "High"}`
- **AND** a Default of `"Low"`
- **WHEN** the state executes with input `{"score": 30}`
- **THEN** the next state is `"Low"`

### Requirement: JSONata Credentials Field
In JSONata mode the system SHALL accept a `Credentials` field on Task states. The
`Credentials.RoleArn` value MAY be a `{%...%}` JSONata expression; if so it SHALL be
evaluated against the state's input to produce the resolved role ARN. The resolved ARN
SHALL be recorded on the execution transition but actual cross-account IAM switching
is not emulated.

#### Scenario: Credentials.RoleArn expression resolves to a dynamic ARN
- **GIVEN** a Task state in JSONata mode with `"Credentials": {"RoleArn": "{% $states.input.roleArn %}"}`
- **WHEN** the state executes with input `{"roleArn": "arn:aws:iam::123456789012:role/MyRole"}`
- **THEN** the resolved role ARN is `"arn:aws:iam::123456789012:role/MyRole"`
- **AND** the task executes normally

#### Scenario: Static Credentials.RoleArn is used as-is
- **GIVEN** a Task state with `"Credentials": {"RoleArn": "arn:aws:iam::123456789012:role/Fixed"}`
- **WHEN** the state executes
- **THEN** the role ARN `"arn:aws:iam::123456789012:role/Fixed"` is recorded
- **AND** the task executes normally
