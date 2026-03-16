@stepfunctionsssm @generated
Feature: StepfunctionsSsm - A Parameter Is Created In Ssm Parameter Store

  # Generated from FizzBee spec: stepfunctions_ssm.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadAParameter

  Background:
    Given the system is initialized

  @minimal @happy @create_parameter
  Scenario: a parameter is created in "SSM" Parameter Store
    Given the parameter does not already exist
    When a parameter is created in "SSM" Parameter Store
    Then the parameter "EXISTS"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @standard @negative @create_parameter
  Scenario: a parameter is created in "SSM" Parameter Store fails when the parameter already exists
    Given the parameter already exists
    When a parameter is created in "SSM" Parameter Store
    Then the operation is rejected
