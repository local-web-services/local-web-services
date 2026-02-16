@stepfunctions @stop_execution @dataplane
Feature: StepFunctions StopExecution

  @happy
  Scenario: Stop a running execution
    Given a state machine "e2e-stop-exec" was created with a Pass definition
    And an execution was started on state machine "e2e-stop-exec" with input "{}"
    When I stop the started execution
    Then the command will succeed
