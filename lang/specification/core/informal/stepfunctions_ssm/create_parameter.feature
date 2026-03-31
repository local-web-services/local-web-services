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
    Then the parameter will exist
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @guard @negative @create_parameter
  Scenario: a "ssm" "parameter" is created fails when the "ssm" "parameter" already existed
    Given the "ssm" "parameter" already existed
    When a "ssm" "parameter" is created
    Then the operation is rejected
