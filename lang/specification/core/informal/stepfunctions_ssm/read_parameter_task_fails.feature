@stepfunctionsssm @generated
Feature: StepfunctionsSsm - A Running Execution Fails To Read The Parameter Because It Has Been Deleted

  # Generated from FizzBee spec: stepfunctions_ssm.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadAParameter

  Background:
    Given the system is initialized

  @minimal @happy @read_parameter_task_fails @internal
  Scenario: a running execution fails to read the parameter because it has been deleted
    Given an execution is "RUNNING"
    And the parameter is "DELETED"
    When a running execution fails to read the parameter because it has been deleted
    Then the execution is "FAILED" with a ParameterNotFound error
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @standard @negative @read_parameter_task_fails @internal
  Scenario: a running execution fails to read the parameter because it has been deleted fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution fails to read the parameter because it has been deleted
    Then the operation is rejected

  @standard @negative @read_parameter_task_fails @internal
  Scenario: a running execution fails to read the parameter because it has been deleted fails when the parameter is not "DELETED"
    Given an execution is "RUNNING"
    And the parameter is not "DELETED"
    When a running execution fails to read the parameter because it has been deleted
    Then the operation is rejected
