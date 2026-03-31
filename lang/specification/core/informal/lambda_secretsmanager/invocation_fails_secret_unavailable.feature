@lambdasecretsmanager @generated
Feature: LambdaSecretsmanager - The "Lambda" "Function" Fails Because The "Secretsmanager" "Secret" Is Pending Deletion

  # Generated from FizzBee spec: lambda_secretsmanager.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationReadASecret

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_secret_unavailable
  Scenario: the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "secretsmanager" "secret" was "PENDING_DELETION"
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    Then the invocation will be "FAILED" with a ResourceNotFoundException
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @guard @negative @invocation_fails_secret_unavailable @lifecycle
  Scenario: the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    Then the operation is rejected

  @guard @negative @invocation_fails_secret_unavailable @lifecycle
  Scenario: the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion fails when the "secretsmanager" "secret" is not pending deletion
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "secretsmanager" "secret" is not pending deletion
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    Then the operation is rejected
