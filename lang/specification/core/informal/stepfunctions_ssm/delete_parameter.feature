@stepfunctionsssm @generated
Feature: StepfunctionsSsm - A "Ssm" "Parameter" Is Deleted

  # Generated from FizzBee spec: stepfunctions_ssm.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadAParameter

  Background:
    Given the system is initialized

  @minimal @happy @delete_parameter
  Scenario: a "ssm" "parameter" is deleted
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" existed
    When a "ssm" "parameter" is deleted
    Then the "ssm" "parameter" will be deleted and will cause task failures when read
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @guard @negative @delete_parameter
  Scenario: a "ssm" "parameter" is deleted fails when the "ssm" "parameter" did not exist
    Given the "ssm" "parameter" did not exist
    When a "ssm" "parameter" is deleted
    Then the operation is rejected

  @guard @negative @delete_parameter @lifecycle
  Scenario: a "ssm" "parameter" is deleted fails when the parameter is already "DELETED"
    Given the "ssm" "parameter" existed
    And the parameter is already "DELETED"
    When a "ssm" "parameter" is deleted
    Then the operation is rejected
