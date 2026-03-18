@lambdards @generated
Feature: LambdaRds - A Multi-Az Failover Begins On The Rds Instance

  # Generated from FizzBee spec: lambda_rds.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedADB

  Background:
    Given the system is initialized

  @minimal @happy @d_b_failover_begins
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance
    Given the instance exists
    And the instance is "AVAILABLE"
    When a Multi-"AZ" failover begins on the "RDS" instance
    Then the instance is "FAILING_OVER" and temporarily unavailable for connections
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @standard @negative @d_b_failover_begins
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance fails when the instance does not exist
    Given the instance does not exist
    When a Multi-"AZ" failover begins on the "RDS" instance
    Then the operation is rejected

  @standard @negative @d_b_failover_begins @lifecycle @internal
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance fails when the instance is not "AVAILABLE"
    Given the instance exists
    And the instance is not "AVAILABLE"
    When a Multi-"AZ" failover begins on the "RDS" instance
    Then the operation is rejected
