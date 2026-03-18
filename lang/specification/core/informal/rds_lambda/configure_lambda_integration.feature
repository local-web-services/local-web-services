@rdslambda @generated
Feature: RdsLambda - The Db Instance Is Configured With An Iam Role To Invoke The Lambda Function

  # Generated from FizzBee spec: rds_lambda.fizz
  # Safety invariants: SuccessfulInvocationReferencesExistingDB, SuccessfulInvocationInvokedAFunction

  Background:
    Given the system is initialized

  @minimal @happy @configure_lambda_integration
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Given the "DB" instance exists and is "AVAILABLE"
    And the "DB" instance has no Lambda integration configured
    And the function exists and is "ACTIVE"
    When the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Then stored procedures on the "DB" can invoke the Lambda function
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @standard @negative @configure_lambda_integration @lifecycle @internal
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the Lambda function fails when the "DB" instance does not exist or is not "AVAILABLE"
    Given the "DB" instance does not exist or is not "AVAILABLE"
    When the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Then the operation is rejected

  @standard @negative @configure_lambda_integration
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the Lambda function fails when the "DB" instance already has a Lambda integration configured
    Given the "DB" instance exists and is "AVAILABLE"
    And the "DB" instance already has a Lambda integration configured
    When the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Then the operation is rejected

  @standard @negative @configure_lambda_integration
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the Lambda function fails when the function does not exist or is not "ACTIVE"
    Given the "DB" instance exists and is "AVAILABLE"
    And the "DB" instance has no Lambda integration configured
    And the function does not exist or is not "ACTIVE"
    When the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Then the operation is rejected
