@rdslambda @generated
Feature: RdsLambda - An "Rds" Stored Procedure Fails To Invoke "Lambda" Because The "Lambda" "Function" Has Been Deleted

  # Generated from FizzBee spec: rds_lambda.fizz
  # Safety invariants: SuccessfulInvocationReferencesExistingDB, SuccessfulInvocationInvokedAFunction

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_function_deleted
  Scenario: an "rds" stored procedure fails to invoke "lambda" because the "lambda" "function" has been deleted
    Given the "rds" "instance" was "AVAILABLE"
    And the "rds" "instance" has a "lambda" "function" integration configured
    And the "lambda" "function" was "DELETED"
    And a "lambda" "invocation" slot is available
    When an "rds" stored procedure fails to invoke "lambda" because the "lambda" "function" has been deleted
    Then the "lambda" "invocation" will be "FAILED" with a function not found error
    And every successful "lambda" "invocation" references an "rds" "DB instance" that exists
    And every successful "rds" "invocation" recorded which "lambda" "function" it invoked

  @guard @negative @invocation_fails_function_deleted @lifecycle
  Scenario: an "rds" stored procedure fails to invoke "lambda" because the "lambda" "function" has been deleted fails when the "rds" "instance" was not "AVAILABLE"
    Given the "rds" "instance" was not "AVAILABLE"
    When an "rds" stored procedure fails to invoke "lambda" because the "lambda" "function" has been deleted
    Then the operation is rejected

  @guard @negative @invocation_fails_function_deleted
  Scenario: an "rds" stored procedure fails to invoke "lambda" because the "lambda" "function" has been deleted fails when the "rds" "instance" has no "lambda" "function" integration configured
    Given the "rds" "instance" was "AVAILABLE"
    And the "rds" "instance" has no "lambda" "function" integration configured
    When an "rds" stored procedure fails to invoke "lambda" because the "lambda" "function" has been deleted
    Then the operation is rejected

  @guard @negative @invocation_fails_function_deleted @lifecycle
  Scenario: an "rds" stored procedure fails to invoke "lambda" because the "lambda" "function" has been deleted fails when the "lambda" "function" was not "DELETED"
    Given the "rds" "instance" was "AVAILABLE"
    And the "rds" "instance" has a "lambda" "function" integration configured
    And the "lambda" "function" was not "DELETED"
    When an "rds" stored procedure fails to invoke "lambda" because the "lambda" "function" has been deleted
    Then the operation is rejected

  @guard @negative @invocation_fails_function_deleted @capacity
  Scenario: an "rds" stored procedure fails to invoke "lambda" because the "lambda" "function" has been deleted fails when no "lambda" "invocation" "slot" was "available"
    Given the "rds" "instance" was "AVAILABLE"
    And the "rds" "instance" has a "lambda" "function" integration configured
    And the "lambda" "function" was "DELETED"
    And no "lambda" "invocation" "slot" was "available"
    When an "rds" stored procedure fails to invoke "lambda" because the "lambda" "function" has been deleted
    Then the operation is rejected
