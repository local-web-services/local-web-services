## MODIFIED Requirements

### Requirement: JSONata Output Field
In JSONata mode the system SHALL accept an `Output` field on Pass and Task states.
When `Output` is a `{%...%}` string it SHALL be evaluated as a JSONata expression to
produce the final state output. When `Output` is a dict, each value SHALL be recursively
expanded: `{%...%}` string values SHALL be evaluated as JSONata expressions, nested dicts
SHALL be recursed, and all other values SHALL be passed through as literals.
In all cases `$states.input` and `$states.result` SHALL be available to expressions.
The result replaces the standard `ResultPath` + `OutputPath` processing.

#### Scenario: Output expression produces the final state output
- **GIVEN** a Pass state in JSONata mode with `"Output": "{% {'name': $states.input.name} %}"`
- **WHEN** the state executes with input `{"name": "Alice"}`
- **THEN** the execution output is `{"name": "Alice"}`

#### Scenario: Output expression can reference task result
- **GIVEN** a Task state in JSONata mode with `"Output": "{% $states.result.value %}"`
- **WHEN** the task returns `{"value": "done"}`
- **THEN** the state output is `"done"`

#### Scenario: Dict Output evaluates expression values and passes through literals
- **GIVEN** a Pass state in JSONata mode with `"Output": {"key": "{% $states.input.x %}", "label": "fixed"}`
- **WHEN** the state executes with input `{"x": 42}`
- **THEN** the execution output is `{"key": 42, "label": "fixed"}`

#### Scenario: Dict Output evaluates task result expressions
- **GIVEN** a Task state in JSONata mode with `"Output": {"value": "{% $states.result.v %}"}`
- **WHEN** the task returns `{"v": "done"}`
- **THEN** the state output is `{"value": "done"}`
