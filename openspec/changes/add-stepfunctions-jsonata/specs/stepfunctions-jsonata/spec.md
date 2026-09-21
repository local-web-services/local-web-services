## ADDED Requirements

### Requirement: JSONata Query Language Selection
The Step Functions engine SHALL support `"QueryLanguage": "JSONata"` on a state machine
definition or on an individual state, causing that scope to use JSONata instead of JSONPath for
data transformation.

#### Scenario: State machine-level QueryLanguage applies to all states
- **GIVEN** a state machine definition with `"QueryLanguage": "JSONata"` at the top level
- **WHEN** the execution runs any state in that machine
- **THEN** JSONata mode is used for that state's data processing

#### Scenario: Per-state QueryLanguage overrides the state machine default
- **GIVEN** a state machine with `"QueryLanguage": "JSONPath"` at the top level
- **AND** a single state with `"QueryLanguage": "JSONata"`
- **WHEN** that state executes
- **THEN** JSONata mode is used for that state only

### Requirement: JSONata Arguments Field
In JSONata mode the system SHALL accept an `Arguments` field on Pass and Task states.
String values wrapped in `{%...%}` SHALL be evaluated as JSONata expressions against
`$states.input` (the state's effective input). Non-expression values SHALL be passed through
as literals. The result becomes the effective input to the state body.

#### Scenario: {%...%} value is evaluated as a JSONata expression
- **GIVEN** a Pass state in JSONata mode with `"Arguments": {"name": "{% $states.input.raw %}"}`
- **WHEN** the state executes with input `{"raw": "Alice"}`
- **THEN** the effective input is `{"name": "Alice"}`

#### Scenario: Literal value in Arguments is passed through unchanged
- **GIVEN** a Pass state in JSONata mode with `"Arguments": {"label": "fixed"}`
- **WHEN** the state executes with any input
- **THEN** the effective input contains `{"label": "fixed"}`

#### Scenario: String concatenation expression produces combined string
- **GIVEN** a Pass state in JSONata mode with `"Arguments": {"greeting": "{% 'hello ' & $states.input.name %}"}`
- **WHEN** the state executes with input `{"name": "Alice"}`
- **THEN** the effective input is `{"greeting": "hello Alice"}`

### Requirement: JSONata Output Field
In JSONata mode the system SHALL accept an `Output` field on Pass and Task states.
A `{%...%}` string SHALL be evaluated as a JSONata expression to produce the final state
output; `$states.input` and `$states.result` SHALL be available. The result replaces the
standard `ResultPath` + `OutputPath` processing.

#### Scenario: Output expression produces the final state output
- **GIVEN** a Pass state in JSONata mode with `"Output": "{% {'name': $states.input.name} %}"`
- **WHEN** the state executes with input `{"name": "Alice"}`
- **THEN** the execution output is `{"name": "Alice"}`

#### Scenario: Output expression can reference task result
- **GIVEN** a Task state in JSONata mode with `"Output": "{% $states.result.value %}"`
- **WHEN** the task returns `{"value": "done"}`
- **THEN** the state output is `"done"`

### Requirement: JSONata Acceptance Test
The system SHALL execute a synchronous Step Functions state machine that uses `"QueryLanguage": "JSONata"` and an `Arguments` field to transform its input, and produce the correct transformed output.

#### Scenario: Sync execution of a JSONata Pass state machine returns transformed output
- **GIVEN** an EXPRESS state machine with `"QueryLanguage": "JSONata"` and a Pass state using `Arguments`
- **WHEN** a synchronous execution is started with input `{"key": "value"}`
- **THEN** the execution SUCCEEDS
- **AND** the output contains the field produced by the JSONata expression
