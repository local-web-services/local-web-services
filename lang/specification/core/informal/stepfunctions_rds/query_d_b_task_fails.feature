@stepfunctionsrds @generated
Feature: StepfunctionsRds - A Running "Step Functions" "Execution" Fails To Query The Db Because It Is Failing Over

  # Generated from FizzBee spec: stepfunctions_rds.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedADB

  Background:
    Given the system is initialized

  @minimal @happy @query_d_b_task_fails @internal
  Scenario: a running "step functions" "execution" fails to query the "DB" because it is failing over
    Given a "step functions" "execution" was "RUNNING"
    And the "rds" "DB instance" was "FAILING_OVER"
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    Then the "step functions" "execution" will be "FAILED" with a connection error
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @guard @negative @query_d_b_task_fails @internal
  Scenario: a running "step functions" "execution" fails to query the "DB" because it is failing over fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    Then the operation is rejected

  @guard @negative @query_d_b_task_fails @internal
  Scenario: a running "step functions" "execution" fails to query the "DB" because it is failing over fails when the "rds" "DB instance" was not "FAILING_OVER"
    Given a "step functions" "execution" was "RUNNING"
    And the "rds" "DB instance" was not "FAILING_OVER"
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    Then the operation is rejected
