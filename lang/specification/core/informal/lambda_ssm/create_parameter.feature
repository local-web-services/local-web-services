@lambdassm @generated
Feature: LambdaSsm - A "Ssm" "Parameter" Is Created

  # Generated from FizzBee spec: lambda_ssm.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationReadAParameter

  Background:
    Given the system is initialized

  @minimal @happy @create_parameter
  Scenario: a "ssm" "parameter" is created
    Given the "ssm" "parameter" did not already exist
    When a "ssm" "parameter" is created
    Then the "ssm" "parameter" will exist and can be read by "lambda"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "ssm" "parameter" it read

  @guard @negative @create_parameter
  Scenario: a "ssm" "parameter" is created fails when the "ssm" "parameter" already existed
    Given the "ssm" "parameter" already existed
    When a "ssm" "parameter" is created
    Then the operation is rejected
