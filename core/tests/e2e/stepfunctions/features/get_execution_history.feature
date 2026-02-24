@stepfunctions @get_execution_history @dataplane
Feature: StepFunctions GetExecutionHistory

  @happy
  Scenario: Get execution history for an execution
    Given a state machine "e2e-get-hist" was created with a Pass definition
    And an execution was started on state machine "e2e-get-hist" with input "{}"
    When I get execution history for the started execution
    Then the command will succeed
