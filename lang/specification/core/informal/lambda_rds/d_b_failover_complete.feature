@lambdards @generated
Feature: LambdaRds - The Multi-Az Failover Completes And The New Primary Is Promoted

  # Generated from FizzBee spec: lambda_rds.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedADB

  Background:
    Given the system is initialized

  @minimal @happy @d_b_failover_complete @internal
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted
    Given the "rds" "instance" was "FAILING_OVER"
    When the Multi-"AZ" failover completes and the new primary is promoted
    Then the "rds" "instance" will be "AVAILABLE" again
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @guard @negative @d_b_failover_complete @internal
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted fails when the "rds" "instance" was not "FAILING_OVER"
    Given the "rds" "instance" was not "FAILING_OVER"
    When the Multi-"AZ" failover completes and the new primary is promoted
    Then the operation is rejected
