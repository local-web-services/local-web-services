@stepfunctionsssm @generated
Feature: StepfunctionsSsm - A Running "Step Functions" "Execution" Reads An Existing Parameter And The Task Succeeds

  # Generated from FizzBee spec: stepfunctions_ssm.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadAParameter

  Background:
    Given the system is initialized

  @minimal @happy @read_parameter_task_succeeds @internal
  Scenario: a running "step functions" "execution" reads an existing parameter and the task succeeds
    Given a "step functions" "execution" was "RUNNING"
    And the "ssm" "parameter" existed
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    Then the "step functions" "execution" will be "SUCCEEDED"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "ssm" "parameter" it read

  @guard @negative @read_parameter_task_succeeds @internal
  Scenario: a running "step functions" "execution" reads an existing parameter and the task succeeds fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    Then the operation is rejected

  @guard @negative @read_parameter_task_succeeds @internal
  Scenario: a running "step functions" "execution" reads an existing parameter and the task succeeds fails when the "ssm" "parameter" did not exist or was "DELETED"
    Given a "step functions" "execution" was "RUNNING"
    And the "ssm" "parameter" did not exist or was "DELETED"
    When a running "step functions" "execution" reads an existing parameter and the task succeeds
    Then the operation is rejected
