@stepfunctions @start_execution @dataplane
Feature: StepFunctions StartExecution

  @happy
  Scenario: Start an execution on a state machine
    Given a state machine "e2e-start-exec" was created with a Pass definition
    When I start an execution on state machine "e2e-start-exec" with input '{"key": "value"}'
    Then the command will succeed
    And the output will contain an execution ARN
    And the started execution will have a status
