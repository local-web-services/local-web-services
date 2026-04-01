@rdslambda @generated
Feature: RdsLambda - The "Lambda" "Function" Is Deleted

  # Generated from FizzBee spec: rds_lambda.fizz
  # Safety invariants: SuccessfulInvocationReferencesExistingDB, SuccessfulInvocationInvokedAFunction

  Background:
    Given the system is initialized

  @minimal @happy @delete_function
  Scenario: the "lambda" "function" is deleted
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    When the "lambda" "function" is deleted
    Then the "lambda" "function" will be deleted and stored procedure invocations targeting it will fail
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @guard @negative @delete_function
  Scenario: the "lambda" "function" is deleted fails when the "lambda" "function" did not exist
    Given the "lambda" "function" did not exist
    When the "lambda" "function" is deleted
    Then the operation is rejected

  @guard @negative @delete_function @lifecycle
  Scenario: the "lambda" "function" is deleted fails when the function is already "DELETED"
    Given the "lambda" "function" existed
    And the function is already "DELETED"
    When the "lambda" "function" is deleted
    Then the operation is rejected
