@lambdasecretsmanager @generated
Feature: LambdaSecretsmanager - A "Secretsmanager" "Secret" Is Created In Secrets Manager

  # Generated from FizzBee spec: lambda_secretsmanager.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationReadASecret

  Background:
    Given the system is initialized

  @minimal @happy @create_secret
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager
    Given the "secretsmanager" "secret" did not already exist
    When a "secretsmanager" "secret" is created in Secrets Manager
    Then the "secrets manager" "secret" will be "ACTIVE" and can be read by Lambda
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @guard @negative @create_secret
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager fails when the "secretsmanager" "secret" already existed
    Given the "secretsmanager" "secret" already existed
    When a "secretsmanager" "secret" is created in Secrets Manager
    Then the operation is rejected
