@stepfunctionsrds @generated
Feature: StepfunctionsRds - A Multi-Az Failover Begins On The "Rds" "Db Instance"

  # Generated from FizzBee spec: stepfunctions_rds.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedADB

  Background:
    Given the system is initialized

  @minimal @happy @d_b_failover_begins
  Scenario: a Multi-"AZ" failover begins on the "rds" "DB instance"
    Given the "rds" "instance" existed
    And the "rds" "DB instance" was "AVAILABLE"
    When a Multi-"AZ" failover begins on the "rds" "DB instance"
    Then the "rds" "DB instance" will be "FAILING_OVER" and queries will be rejected
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "rds" "DB instance" it queried

  @guard @negative @d_b_failover_begins
  Scenario: a Multi-"AZ" failover begins on the "rds" "DB instance" fails when the "rds" "instance" did not exist
    Given the "rds" "instance" did not exist
    When a Multi-"AZ" failover begins on the "rds" "DB instance"
    Then the operation is rejected

  @guard @negative @d_b_failover_begins @lifecycle
  Scenario: a Multi-"AZ" failover begins on the "rds" "DB instance" fails when the "rds" "DB instance" was not "AVAILABLE"
    Given the "rds" "instance" existed
    And the "rds" "DB instance" was not "AVAILABLE"
    When a Multi-"AZ" failover begins on the "rds" "DB instance"
    Then the operation is rejected
