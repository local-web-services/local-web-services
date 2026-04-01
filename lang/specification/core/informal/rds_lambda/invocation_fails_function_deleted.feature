@rdslambda @generated
Feature: RdsLambda - A Rds Stored Procedure Fails To Invoke Lambda Because The Function Has Been Deleted

  # Generated from FizzBee spec: rds_lambda.fizz
  # Safety invariants: SuccessfulInvocationReferencesExistingDB, SuccessfulInvocationInvokedAFunction

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_function_deleted
  Scenario: a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Given the "DB" instance was "AVAILABLE"
    And the "DB" instance has a Lambda integration configured
    And the "lambda" "function" was "DELETED"
    And a "lambda" "invocation" slot is available
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Then the invocation will be "FAILED" with a function not found error
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @guard @negative @invocation_fails_function_deleted @lifecycle
  Scenario: a "RDS" stored procedure fails to invoke Lambda because the function has been deleted fails when the "DB" instance was not "AVAILABLE"
    Given the "DB" instance was not "AVAILABLE"
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Then the operation is rejected

  @guard @negative @invocation_fails_function_deleted
  Scenario: a "RDS" stored procedure fails to invoke Lambda because the function has been deleted fails when the "DB" instance has no Lambda integration configured
    Given the "DB" instance was "AVAILABLE"
    And the "DB" instance has no Lambda integration configured
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Then the operation is rejected

  @guard @negative @invocation_fails_function_deleted @lifecycle
  Scenario: a "RDS" stored procedure fails to invoke Lambda because the function has been deleted fails when the "lambda" "function" was not "DELETED"
    Given the "DB" instance was "AVAILABLE"
    And the "DB" instance has a Lambda integration configured
    And the "lambda" "function" was not "DELETED"
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Then the operation is rejected

  @guard @negative @invocation_fails_function_deleted @capacity
  Scenario: a "RDS" stored procedure fails to invoke Lambda because the function has been deleted fails when no invocation slot is available
    Given the "DB" instance was "AVAILABLE"
    And the "DB" instance has a Lambda integration configured
    And the "lambda" "function" was "DELETED"
    And no invocation slot is available
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Then the operation is rejected
