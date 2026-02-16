@stepfunctions @create_state_machine @controlplane
Feature: StepFunctions CreateStateMachine

  @happy
  Scenario: Create a new state machine
    When I create a state machine named "e2e-create-sm" with a Pass definition
    Then the command will succeed
    And state machine "e2e-create-sm" will exist
