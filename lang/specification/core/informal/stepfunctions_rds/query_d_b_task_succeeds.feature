@stepfunctionsrds @generated
Feature: StepfunctionsRds - A Running Execution Queries The Available Db Instance And The Task Succeeds

  # Generated from FizzBee spec: stepfunctions_rds.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedADB

  Background:
    Given the system is initialized

  @minimal @happy @query_d_b_task_succeeds @internal
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given an execution is "RUNNING"
    And the "DB" instance is "AVAILABLE"
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Then the execution is "SUCCEEDED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @guard @negative @query_d_b_task_succeeds @internal
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Then the operation is rejected

  @guard @negative @query_d_b_task_succeeds @internal
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds fails when the "DB" instance is not "AVAILABLE"
    Given an execution is "RUNNING"
    And the "DB" instance is not "AVAILABLE"
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Then the operation is rejected
