@stepfunctionsrds @generated
Feature: StepfunctionsRds - A Running "Step Functions" "Execution" Queries The Available Db Instance And The Task Succeeds

  # Generated from FizzBee spec: stepfunctions_rds.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedADB

  Background:
    Given the system is initialized

  @minimal @happy @query_d_b_task_succeeds @internal
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    Given a "step functions" "execution" was "RUNNING"
    And the "DB" instance was "AVAILABLE"
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    Then the "step functions" "execution" will be "SUCCEEDED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @guard @negative @query_d_b_task_succeeds @internal
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    Then the operation is rejected

  @guard @negative @query_d_b_task_succeeds @internal
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds fails when the "DB" instance was not "AVAILABLE"
    Given a "step functions" "execution" was "RUNNING"
    And the "DB" instance was not "AVAILABLE"
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    Then the operation is rejected
