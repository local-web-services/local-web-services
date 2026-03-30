@rdslambda @generated
Feature: RdsLambda - An Rds Stored Procedure Fails To Invoke Lambda Because The Function Has Been Deleted

  # Generated from FizzBee spec: rds_lambda.fizz
  # Safety invariants: SuccessfulInvocationReferencesExistingDB, SuccessfulInvocationInvokedAFunction

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_function_deleted
  Scenario: an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Given the "DB" instance is "AVAILABLE"
    And the "DB" instance has a Lambda integration configured
    And the Lambda function is "DELETED"
    And an invocation slot is available
    When an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Then the invocation is "FAILED" with a function not found error
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @guard @negative @invocation_fails_function_deleted @lifecycle
  Scenario: an "RDS" stored procedure fails to invoke Lambda because the function has been deleted fails when the "DB" instance is not "AVAILABLE"
    Given the "DB" instance is not "AVAILABLE"
    When an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Then the operation is rejected

  @guard @negative @invocation_fails_function_deleted
  Scenario: an "RDS" stored procedure fails to invoke Lambda because the function has been deleted fails when the "DB" instance has no Lambda integration configured
    Given the "DB" instance is "AVAILABLE"
    And the "DB" instance has no Lambda integration configured
    When an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Then the operation is rejected

  @guard @negative @invocation_fails_function_deleted @lifecycle
  Scenario: an "RDS" stored procedure fails to invoke Lambda because the function has been deleted fails when the Lambda function is not "DELETED"
    Given the "DB" instance is "AVAILABLE"
    And the "DB" instance has a Lambda integration configured
    And the Lambda function is not "DELETED"
    When an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Then the operation is rejected

  @guard @negative @internal @invocation_fails_function_deleted @capacity
  Scenario: an "RDS" stored procedure fails to invoke Lambda because the function has been deleted fails when no invocation slot is available
    Given the "DB" instance is "AVAILABLE"
    And the "DB" instance has a Lambda integration configured
    And the Lambda function is "DELETED"
    And no invocation slot is available
    When an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Then the operation is rejected
