@stepfunctionsrds @generated
Feature: StepfunctionsRds - A Multi-Az Failover Begins On The Db Instance

  # Generated from FizzBee spec: stepfunctions_rds.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedADB

  Background:
    Given the system is initialized

  @minimal @happy @d_b_failover_begins
  Scenario: a Multi-"AZ" failover begins on the "DB" instance
    Given the "DB" instance exists
    And the "DB" instance is "AVAILABLE"
    When a Multi-"AZ" failover begins on the "DB" instance
    Then the "DB" instance is "FAILING_OVER" and queries will be rejected
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @standard @negative @d_b_failover_begins
  Scenario: a Multi-"AZ" failover begins on the "DB" instance fails when the "DB" instance does not exist
    Given the "DB" instance does not exist
    When a Multi-"AZ" failover begins on the "DB" instance
    Then the operation is rejected

  @standard @negative @d_b_failover_begins @lifecycle
  Scenario: a Multi-"AZ" failover begins on the "DB" instance fails when the "DB" instance is not "AVAILABLE"
    Given the "DB" instance exists
    And the "DB" instance is not "AVAILABLE"
    When a Multi-"AZ" failover begins on the "DB" instance
    Then the operation is rejected
