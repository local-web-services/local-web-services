@stepfunctionsrds @generated
Feature: StepfunctionsRds - A Multi-Az Failover Begins On The Db Instance

  # Generated from FizzBee spec: stepfunctions_rds.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedADB

  Background:
    Given the system is initialized

  @minimal @happy @d_b_failover_begins
  Scenario: a Multi-"AZ" failover begins on the "DB" instance
    Given the "DB" instance existed
    And the "DB" instance was "AVAILABLE"
    When a Multi-"AZ" failover begins on the "DB" instance
    Then the "DB" instance will be "FAILING_OVER" and queries will be rejected
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @guard @negative @d_b_failover_begins
  Scenario: a Multi-"AZ" failover begins on the "DB" instance fails when the "DB" instance did not exist
    Given the "DB" instance did not exist
    When a Multi-"AZ" failover begins on the "DB" instance
    Then the operation is rejected

  @guard @negative @d_b_failover_begins @lifecycle
  Scenario: a Multi-"AZ" failover begins on the "DB" instance fails when the "DB" instance was not "AVAILABLE"
    Given the "DB" instance existed
    And the "DB" instance was not "AVAILABLE"
    When a Multi-"AZ" failover begins on the "DB" instance
    Then the operation is rejected
