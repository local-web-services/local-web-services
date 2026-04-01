@lambdards @generated
Feature: LambdaRds - The "Lambda" "Function" Executes A Sql Query Against The Available Database And Succeeds

  # Generated from FizzBee spec: lambda_rds.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedADB

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds @internal
  Scenario: the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the database instance was "AVAILABLE"
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    Then the invocation will be "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @guard @negative @invocation_succeeds @internal
  Scenario: the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    Then the operation is rejected

  @guard @negative @invocation_succeeds @internal
  Scenario: the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds fails when the database instance was not "AVAILABLE"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the database instance was not "AVAILABLE"
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    Then the operation is rejected
