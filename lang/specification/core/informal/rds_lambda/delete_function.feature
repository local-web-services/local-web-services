@rdslambda @generated
Feature: RdsLambda - The Lambda Function Is Deleted

  # Generated from FizzBee spec: rds_lambda.fizz
  # Safety invariants: SuccessfulInvocationReferencesExistingDB, SuccessfulInvocationInvokedAFunction

  Background:
    Given the system is initialized

  @minimal @happy @delete_function
  Scenario: the Lambda function is deleted
    Given the function exists
    And the function is "ACTIVE"
    When the Lambda function is deleted
    Then the function is "DELETED" and stored procedure invocations targeting it will fail
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @standard @negative @delete_function
  Scenario: the Lambda function is deleted fails when the function does not exist
    Given the function does not exist
    When the Lambda function is deleted
    Then the operation is rejected

  @standard @negative @delete_function @lifecycle
  Scenario: the Lambda function is deleted fails when the function is already "DELETED"
    Given the function exists
    And the function is already "DELETED"
    When the Lambda function is deleted
    Then the operation is rejected
