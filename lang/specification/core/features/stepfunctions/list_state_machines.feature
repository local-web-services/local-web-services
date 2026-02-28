@stepfunctions @list_state_machines @controlplane
Feature: StepFunctions ListStateMachines

  @happy
  Scenario: List state machines includes a created machine
    Given a state machine "e2e-list-sm" was created with a Pass definition
    When I list state machines
    Then the command will succeed
    And the state machine list will include "e2e-list-sm"
