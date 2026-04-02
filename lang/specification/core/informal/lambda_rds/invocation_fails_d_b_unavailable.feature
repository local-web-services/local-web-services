@lambdards @generated
Feature: LambdaRds - The "Lambda" "Function" Fails To Connect Because The Database Is Failing Over

  # Generated from FizzBee spec: lambda_rds.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedADB

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_d_b_unavailable
  Scenario: the "lambda" "function" fails to connect because the database is failing over
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "rds" "database instance" was "FAILING_OVER"
    When the "lambda" "function" fails to connect because the database is failing over
    Then the "lambda" "invocation" will be "FAILED" with a connection error
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @guard @negative @invocation_fails_d_b_unavailable @lifecycle
  Scenario: the "lambda" "function" fails to connect because the database is failing over fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" fails to connect because the database is failing over
    Then the operation is rejected

  @guard @negative @invocation_fails_d_b_unavailable @lifecycle
  Scenario: the "lambda" "function" fails to connect because the database is failing over fails when the "rds" "database instance" was not "FAILING_OVER"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "rds" "database instance" was not "FAILING_OVER"
    When the "lambda" "function" fails to connect because the database is failing over
    Then the operation is rejected
