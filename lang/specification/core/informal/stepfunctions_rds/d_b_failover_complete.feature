@stepfunctionsrds @generated
Feature: StepfunctionsRds - The "Rds" "Db Instance" Failover Completes

  # Generated from FizzBee spec: stepfunctions_rds.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedADB

  Background:
    Given the system is initialized

  @minimal @happy @d_b_failover_complete @internal
  Scenario: the "rds" "DB instance" failover completes
    Given the "rds" "DB instance" was "FAILING_OVER"
    When the "rds" "DB instance" failover completes
    Then the "DB" instance will be "AVAILABLE" again
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "rds" "DB instance" it queried

  @guard @negative @d_b_failover_complete @internal
  Scenario: the "rds" "DB instance" failover completes fails when the "rds" "DB instance" was not "FAILING_OVER"
    Given the "rds" "DB instance" was not "FAILING_OVER"
    When the "rds" "DB instance" failover completes
    Then the operation is rejected
