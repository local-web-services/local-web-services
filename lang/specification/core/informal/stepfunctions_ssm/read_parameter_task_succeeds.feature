@stepfunctionsssm @generated
Feature: StepfunctionsSsm - A Running Execution Reads An Existing Parameter And The Task Succeeds

  # Generated from FizzBee spec: stepfunctions_ssm.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadAParameter

  Background:
    Given the system is initialized

  @minimal @happy @read_parameter_task_succeeds @internal
  Scenario: a running execution reads an existing parameter and the task succeeds
    Given an execution is "RUNNING"
    And the parameter "EXISTS"
    When a running execution reads an existing parameter and the task succeeds
    Then the execution is "SUCCEEDED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @standard @negative @read_parameter_task_succeeds @internal
  Scenario: a running execution reads an existing parameter and the task succeeds fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution reads an existing parameter and the task succeeds
    Then the operation is rejected

  @standard @negative @read_parameter_task_succeeds @internal
  Scenario: a running execution reads an existing parameter and the task succeeds fails when the parameter does not exist or is "DELETED"
    Given an execution is "RUNNING"
    And the parameter does not exist or is "DELETED"
    When a running execution reads an existing parameter and the task succeeds
    Then the operation is rejected
