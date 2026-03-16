@lambdasecretsmanager @generated
Feature: LambdaSecretsmanager - A Secret Is Created In Secrets Manager

  # Generated from FizzBee spec: lambda_secretsmanager.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationReadASecret

  Background:
    Given the system is initialized

  @minimal @happy @create_secret
  Scenario: a secret is created in Secrets Manager
    Given the secret does not already exist
    When a secret is created in Secrets Manager
    Then the secret is "ACTIVE" and can be read by Lambda
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @standard @negative @create_secret
  Scenario: a secret is created in Secrets Manager fails when the secret already exists
    Given the secret already exists
    When a secret is created in Secrets Manager
    Then the operation is rejected
