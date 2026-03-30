@stepfunctionsrds @generated
Feature: StepfunctionsRds - A Running Execution Fails To Query The Db Because It Is Failing Over

  # Generated from FizzBee spec: stepfunctions_rds.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedADB

  Background:
    Given the system is initialized

  @minimal @happy @query_d_b_task_fails @internal
  Scenario: a running execution fails to query the "DB" because it is failing over
    Given an execution is "RUNNING"
    And the "DB" instance is "FAILING_OVER"
    When a running execution fails to query the "DB" because it is failing over
    Then the execution is "FAILED" with a connection error
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @guard @negative @query_d_b_task_fails @internal
  Scenario: a running execution fails to query the "DB" because it is failing over fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution fails to query the "DB" because it is failing over
    Then the operation is rejected

  @guard @negative @query_d_b_task_fails @internal
  Scenario: a running execution fails to query the "DB" because it is failing over fails when the "DB" instance is not "FAILING_OVER"
    Given an execution is "RUNNING"
    And the "DB" instance is not "FAILING_OVER"
    When a running execution fails to query the "DB" because it is failing over
    Then the operation is rejected
