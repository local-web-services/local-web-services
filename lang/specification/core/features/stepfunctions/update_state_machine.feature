@stepfunctions @update_state_machine @controlplane
Feature: StepFunctions UpdateStateMachine

  @happy
  Scenario: Update an existing state machine definition
    Given a state machine "e2e-update-sm" was created with a Pass definition
    When I update state machine "e2e-update-sm" with an updated definition
    Then the command will succeed
    And state machine "e2e-update-sm" will have the updated definition
