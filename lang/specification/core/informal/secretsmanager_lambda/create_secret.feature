@secretsmanagerlambda @generated
Feature: SecretsmanagerLambda - A Secret Is Created In Secrets Manager

  # Generated from FizzBee spec: secretsmanager_lambda.fizz
  # Safety invariants: RotatingSecretHasInProgressInvocation, SuccessfulRotationRotatedASecret

  Background:
    Given the system is initialized

  @minimal @happy @create_secret
  Scenario: a secret is created in Secrets Manager
    Given the secret does not already exist
    When a secret is created in Secrets Manager
    Then the secret is "ACTIVE"
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @guard @negative @create_secret
  Scenario: a secret is created in Secrets Manager fails when the secret already exists
    Given the secret already exists
    When a secret is created in Secrets Manager
    Then the operation is rejected
