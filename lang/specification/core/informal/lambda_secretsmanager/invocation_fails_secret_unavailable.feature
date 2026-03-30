@lambdasecretsmanager @generated
Feature: LambdaSecretsmanager - The Lambda Function Fails Because The Secret Is Pending Deletion

  # Generated from FizzBee spec: lambda_secretsmanager.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationReadASecret

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_secret_unavailable
  Scenario: the Lambda function fails because the secret is pending deletion
    Given an invocation is "IN_PROGRESS"
    And the secret is "PENDING_DELETION"
    When the Lambda function fails because the secret is pending deletion
    Then the invocation is "FAILED" with a ResourceNotFoundException
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @guard @negative @invocation_fails_secret_unavailable @lifecycle
  Scenario: the Lambda function fails because the secret is pending deletion fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function fails because the secret is pending deletion
    Then the operation is rejected

  @guard @negative @invocation_fails_secret_unavailable @lifecycle
  Scenario: the Lambda function fails because the secret is pending deletion fails when the secret is not pending deletion
    Given an invocation is "IN_PROGRESS"
    And the secret is not pending deletion
    When the Lambda function fails because the secret is pending deletion
    Then the operation is rejected
