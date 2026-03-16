@stepfunctionsrds @generated
Feature: StepfunctionsRds - The Db Instance Failover Completes

  # Generated from FizzBee spec: stepfunctions_rds.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedADB

  Background:
    Given the system is initialized

  @minimal @happy @d_b_failover_complete @internal
  Scenario: the "DB" instance failover completes
    Given the "DB" instance is "FAILING_OVER"
    When the "DB" instance failover completes
    Then the "DB" instance is "AVAILABLE" again
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @standard @negative @d_b_failover_complete @internal
  Scenario: the "DB" instance failover completes fails when the "DB" instance is not "FAILING_OVER"
    Given the "DB" instance is not "FAILING_OVER"
    When the "DB" instance failover completes
    Then the operation is rejected
