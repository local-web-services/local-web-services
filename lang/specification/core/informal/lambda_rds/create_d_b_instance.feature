@lambdards @generated
Feature: LambdaRds - A "Rds" "Database Instance" Is Created

  # Generated from FizzBee spec: lambda_rds.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedADB

  Background:
    Given the system is initialized

  @minimal @happy @create_d_b_instance
  Scenario: a "rds" "database instance" is created
    Given the "rds" "instance" did not already exist
    When a "rds" "database instance" is created
    Then the "rds" "instance" will be "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @guard @negative @create_d_b_instance
  Scenario: a "rds" "database instance" is created fails when the "rds" "instance" already existed
    Given the "rds" "instance" already existed
    When a "rds" "database instance" is created
    Then the operation is rejected
