@stepfunctions @delete_state_machine @controlplane
Feature: StepFunctions DeleteStateMachine

  @happy
  Scenario: Delete an existing state machine
    Given a state machine "e2e-del-sm" was created with a Pass definition
    When I delete state machine "e2e-del-sm"
    Then the command will succeed
    And state machine "e2e-del-sm" will not appear in list-state-machines
