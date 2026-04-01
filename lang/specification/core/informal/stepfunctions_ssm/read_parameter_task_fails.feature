@stepfunctionsssm @generated
Feature: StepfunctionsSsm - A Running "Step Functions" "Execution" Fails To Read The Parameter Because It Has Been Deleted

  # Generated from FizzBee spec: stepfunctions_ssm.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadAParameter

  Background:
    Given the system is initialized

  @minimal @happy @read_parameter_task_fails @internal
  Scenario: a running "step functions" "execution" fails to read the parameter because it has been deleted
    Given a "step functions" "execution" was "RUNNING"
    And the "ssm" "parameter" was "DELETED"
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    Then the "step functions" "execution" will be "FAILED" with a ParameterNotFound error
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which parameter it read

  @guard @negative @read_parameter_task_fails @internal
  Scenario: a running "step functions" "execution" fails to read the parameter because it has been deleted fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    Then the operation is rejected

  @guard @negative @read_parameter_task_fails @internal
  Scenario: a running "step functions" "execution" fails to read the parameter because it has been deleted fails when the "ssm" "parameter" was not "DELETED"
    Given a "step functions" "execution" was "RUNNING"
    And the "ssm" "parameter" was not "DELETED"
    When a running "step functions" "execution" fails to read the parameter because it has been deleted
    Then the operation is rejected
