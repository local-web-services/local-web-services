@stepfunctions @describe_execution @dataplane
Feature: StepFunctions DescribeExecution

  @happy
  Scenario: Describe a running execution
    Given a state machine "e2e-desc-exec" was created with a Pass definition
    And an execution was started on state machine "e2e-desc-exec" with input "{}"
    When I describe the started execution
    Then the command will succeed
    And the output will contain the execution ARN
    And the output will contain a status field
