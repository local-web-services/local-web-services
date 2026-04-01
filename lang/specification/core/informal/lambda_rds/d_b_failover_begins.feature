@lambdards @generated
Feature: LambdaRds - A Multi-Az Failover Begins On The "Rds" "Instance"

  # Generated from FizzBee spec: lambda_rds.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedADB

  Background:
    Given the system is initialized

  @minimal @happy @d_b_failover_begins
  Scenario: a Multi-"AZ" failover begins on the "rds" "instance"
    Given the "rds" "instance" existed
    And the "rds" "instance" was "AVAILABLE"
    When a Multi-"AZ" failover begins on the "rds" "instance"
    Then the "rds" "instance" will be "FAILING_OVER" and temporarily unavailable for connections
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @guard @negative @d_b_failover_begins
  Scenario: a Multi-"AZ" failover begins on the "rds" "instance" fails when the "rds" "instance" did not exist
    Given the "rds" "instance" did not exist
    When a Multi-"AZ" failover begins on the "rds" "instance"
    Then the operation is rejected

  @guard @negative @d_b_failover_begins @lifecycle
  Scenario: a Multi-"AZ" failover begins on the "rds" "instance" fails when the "rds" "instance" was not "AVAILABLE"
    Given the "rds" "instance" existed
    And the "rds" "instance" was not "AVAILABLE"
    When a Multi-"AZ" failover begins on the "rds" "instance"
    Then the operation is rejected
