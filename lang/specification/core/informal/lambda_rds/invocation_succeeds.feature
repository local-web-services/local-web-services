@lambdards @generated
Feature: LambdaRds - The Lambda Function Executes A Sql Query Against The Available Database And Succeeds

  # Generated from FizzBee spec: lambda_rds.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedADB

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds @internal
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given an invocation is "IN_PROGRESS"
    And the database instance is "AVAILABLE"
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Then the invocation is "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @standard @negative @invocation_succeeds @internal
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Then the operation is rejected

  @standard @negative @invocation_succeeds @internal
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds fails when the database instance is not "AVAILABLE"
    Given an invocation is "IN_PROGRESS"
    And the database instance is not "AVAILABLE"
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Then the operation is rejected
