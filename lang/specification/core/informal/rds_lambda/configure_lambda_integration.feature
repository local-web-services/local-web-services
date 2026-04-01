@rdslambda @generated
Feature: RdsLambda - The Db Instance Is Configured With An Iam Role To Invoke The "Lambda" "Function"

  # Generated from FizzBee spec: rds_lambda.fizz
  # Safety invariants: SuccessfulInvocationReferencesExistingDB, SuccessfulInvocationInvokedAFunction

  Background:
    Given the system is initialized

  @minimal @happy @configure_lambda_integration
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    Given the "rds" "instance" existed and was "AVAILABLE"
    And the "rds" "instance" has no "lambda" "function" integration configured
    And the "lambda" "function" existed and was "ACTIVE"
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    Then stored procedures on the "DB" can invoke the "lambda" "function"
    And every successful "lambda" "invocation" references an "rds" "DB instance" that exists
    And every successful "rds" "invocation" recorded which "lambda" "function" it invoked

  @guard @negative @configure_lambda_integration @lifecycle
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function" fails when the "DB" instance did not exist or was "AVAILABLE"
    Given the "DB" instance did not exist or was "AVAILABLE"
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    Then the operation is rejected

  @guard @negative @configure_lambda_integration
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function" fails when the "rds" "DB instance" already has a "lambda" "function" integration configured
    Given the "rds" "instance" existed and was "AVAILABLE"
    And the "rds" "DB instance" already has a "lambda" "function" integration configured
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    Then the operation is rejected

  @guard @negative @configure_lambda_integration
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function" fails when the "lambda" "function" did not exist or was "ACTIVE"
    Given the "rds" "instance" existed and was "AVAILABLE"
    And the "rds" "instance" has no "lambda" "function" integration configured
    And the "lambda" "function" did not exist or was "ACTIVE"
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    Then the operation is rejected
