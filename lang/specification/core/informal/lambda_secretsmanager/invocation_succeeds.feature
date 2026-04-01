@lambdasecretsmanager @generated
Feature: LambdaSecretsmanager - The "Lambda" "Function" Reads An Active Secret And Completes Successfully

  # Generated from FizzBee spec: lambda_secretsmanager.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationReadASecret

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds @internal
  Scenario: the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the secrets manager secret existed and was "ACTIVE"
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    Then the invocation will be "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @guard @negative @invocation_succeeds @internal
  Scenario: the "lambda" "function" reads an "ACTIVE" secret and completes successfully fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    Then the operation is rejected

  @guard @negative @invocation_succeeds @internal
  Scenario: the "lambda" "function" reads an "ACTIVE" secret and completes successfully fails when the secrets manager secret did not exist or was "ACTIVE"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the secrets manager secret did not exist or was "ACTIVE"
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    Then the operation is rejected
