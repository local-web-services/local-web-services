@stepfunctions @describe_state_machine @controlplane
Feature: StepFunctions DescribeStateMachine

  @happy
  Scenario: Describe an existing state machine
    Given a state machine "e2e-desc-sm" was created with a Pass definition
    When I describe state machine "e2e-desc-sm"
    Then the command will succeed
    And the output will contain state machine name "e2e-desc-sm"
