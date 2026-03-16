@lambdassm @generated
Feature: LambdaSsm - The Lambda Function Fails Because The Parameter Has Been Deleted

  # Generated from FizzBee spec: lambda_ssm.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationReadAParameter

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_parameter_not_found @internal
  Scenario: the Lambda function fails because the parameter has been deleted
    Given an invocation is "IN_PROGRESS"
    And the parameter is "DELETED"
    When the Lambda function fails because the parameter has been deleted
    Then the invocation is "FAILED" with a ParameterNotFound error
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @standard @negative @invocation_fails_parameter_not_found @internal
  Scenario: the Lambda function fails because the parameter has been deleted fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function fails because the parameter has been deleted
    Then the operation is rejected

  @standard @negative @invocation_fails_parameter_not_found @internal
  Scenario: the Lambda function fails because the parameter has been deleted fails when the parameter is not "DELETED"
    Given an invocation is "IN_PROGRESS"
    And the parameter is not "DELETED"
    When the Lambda function fails because the parameter has been deleted
    Then the operation is rejected
