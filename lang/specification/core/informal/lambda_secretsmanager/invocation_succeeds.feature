@lambdasecretsmanager @generated
Feature: LambdaSecretsmanager - The Lambda Function Reads An Active Secret And Completes Successfully

  # Generated from FizzBee spec: lambda_secretsmanager.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationReadASecret

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds @internal
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully
    Given an invocation is "IN_PROGRESS"
    And the secret exists and is "ACTIVE"
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    Then the invocation is "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @standard @negative @invocation_succeeds @internal
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    Then the operation is rejected

  @standard @negative @invocation_succeeds @internal
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully fails when the secret does not exist or is not "ACTIVE"
    Given an invocation is "IN_PROGRESS"
    And the secret does not exist or is not "ACTIVE"
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    Then the operation is rejected
