@stepfunctions @list_executions @dataplane
Feature: StepFunctions ListExecutions

  @happy
  Scenario: List executions for a state machine
    Given a state machine "e2e-list-exec" was created with a Pass definition
    And an execution was started on state machine "e2e-list-exec" with input "{}"
    When I list executions for state machine "e2e-list-exec"
    Then the command will succeed
    And the executions list will have at least 1 entry
