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
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @guard @negative @create_d_b_instance
  Scenario: a "rds" "database instance" is created fails when the "rds" "instance" already existed
    Given the "rds" "instance" already existed
    When a "rds" "database instance" is created
    Then the operation is rejected
