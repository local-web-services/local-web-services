@stepfunctions @validate_state_machine_definition @controlplane
Feature: StepFunctions ValidateStateMachineDefinition

  @happy
  Scenario: Validate a valid state machine definition
    When I validate a Pass state machine definition
    Then the command will succeed
