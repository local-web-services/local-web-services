@lambdassm @generated
Feature: LambdaSsm - A Parameter Is Created In Ssm Parameter Store

  # Generated from FizzBee spec: lambda_ssm.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationReadAParameter

  Background:
    Given the system is initialized

  @minimal @happy @create_parameter
  Scenario: a parameter is created in "SSM" Parameter Store
    Given the parameter does not already exist
    When a parameter is created in "SSM" Parameter Store
    Then the parameter "EXISTS" and can be read by Lambda
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @guard @negative @create_parameter
  Scenario: a parameter is created in "SSM" Parameter Store fails when the parameter already exists
    Given the parameter already exists
    When a parameter is created in "SSM" Parameter Store
    Then the operation is rejected
