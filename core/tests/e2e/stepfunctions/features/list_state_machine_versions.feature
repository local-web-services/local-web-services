@stepfunctions @list_state_machine_versions @controlplane
Feature: StepFunctions ListStateMachineVersions

  @happy
  Scenario: List versions of a state machine
    Given a state machine "e2e-list-versions" was created with a Pass definition
    When I list state machine versions for "e2e-list-versions"
    Then the command will succeed
