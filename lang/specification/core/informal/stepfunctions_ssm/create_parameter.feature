@stepfunctionsssm @generated
Feature: StepfunctionsSsm - A "Ssm" "Parameter" Is Created

  # Generated from FizzBee spec: stepfunctions_ssm.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadAParameter

  Background:
    Given the system is initialized

  @minimal @happy @create_parameter
  Scenario: a "ssm" "parameter" is created
    Given the "ssm" "parameter" did not already exist
    When a "ssm" "parameter" is created
    Then the "ssm" "parameter" will exist
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @guard @negative @create_parameter
  Scenario: a "ssm" "parameter" is created fails when the "ssm" "parameter" already existed
    Given the "ssm" "parameter" already existed
    When a "ssm" "parameter" is created
    Then the operation is rejected
