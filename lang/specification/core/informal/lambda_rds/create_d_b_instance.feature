@lambdards @generated
Feature: LambdaRds - An Rds Database Instance Is Created

  # Generated from FizzBee spec: lambda_rds.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedADB

  Background:
    Given the system is initialized

  @minimal @happy @create_d_b_instance
  Scenario: an "RDS" database instance is created
    Given the instance does not already exist
    When an "RDS" database instance is created
    Then the instance is "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @guard @negative @create_d_b_instance
  Scenario: an "RDS" database instance is created fails when the instance already exists
    Given the instance already exists
    When an "RDS" database instance is created
    Then the operation is rejected
