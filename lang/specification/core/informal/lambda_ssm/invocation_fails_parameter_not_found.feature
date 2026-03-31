@lambdassm @generated
Feature: LambdaSsm - The "Lambda" "Function" Fails Because The Parameter Has Been Deleted

  # Generated from FizzBee spec: lambda_ssm.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationReadAParameter

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_parameter_not_found @internal
  Scenario: the "lambda" "function" fails because the parameter has been deleted
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "ssm" "parameter" was "DELETED"
    When the "lambda" "function" fails because the parameter has been deleted
    Then the invocation will be "FAILED" with a ParameterNotFound error
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @guard @negative @invocation_fails_parameter_not_found @internal
  Scenario: the "lambda" "function" fails because the parameter has been deleted fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" fails because the parameter has been deleted
    Then the operation is rejected

  @guard @negative @invocation_fails_parameter_not_found @internal
  Scenario: the "lambda" "function" fails because the parameter has been deleted fails when the "ssm" "parameter" was not "DELETED"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "ssm" "parameter" was not "DELETED"
    When the "lambda" "function" fails because the parameter has been deleted
    Then the operation is rejected
