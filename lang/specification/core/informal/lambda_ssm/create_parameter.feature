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
    Then the parameter will exist and can be read by Lambda
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @guard @negative @create_parameter
  Scenario: a "ssm" "parameter" is created fails when the "ssm" "parameter" already existed
    Given the "ssm" "parameter" already existed
    When a "ssm" "parameter" is created
    Then the operation is rejected
