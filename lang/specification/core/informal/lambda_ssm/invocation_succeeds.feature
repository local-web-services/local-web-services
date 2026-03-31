@lambdassm @generated
Feature: LambdaSsm - The "Lambda" "Function" Reads An Existing Parameter And Completes Successfully

  # Generated from FizzBee spec: lambda_ssm.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationReadAParameter

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds @internal
  Scenario: the "lambda" "function" reads an existing parameter and completes successfully
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "ssm" "parameter" existed
    When the "lambda" "function" reads an existing parameter and completes successfully
    Then the invocation will be "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which parameter it read

  @guard @negative @invocation_succeeds @internal
  Scenario: the "lambda" "function" reads an existing parameter and completes successfully fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" reads an existing parameter and completes successfully
    Then the operation is rejected

  @guard @negative @invocation_succeeds @internal
  Scenario: the "lambda" "function" reads an existing parameter and completes successfully fails when the "ssm" "parameter" did not exist or was "DELETED"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "ssm" "parameter" did not exist or was "DELETED"
    When the "lambda" "function" reads an existing parameter and completes successfully
    Then the operation is rejected
