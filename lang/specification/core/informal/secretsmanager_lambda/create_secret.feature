@secretsmanagerlambda @generated
Feature: SecretsmanagerLambda - A "Secretsmanager" "Secret" Is Created In Secrets Manager

  # Generated from FizzBee spec: secretsmanager_lambda.fizz
  # Safety invariants: RotatingSecretHasInProgressInvocation, SuccessfulRotationRotatedASecret

  Background:
    Given the system is initialized

  @minimal @happy @create_secret
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager
    Given the "secretsmanager" "secret" did not already exist
    When a "secretsmanager" "secret" is created in Secrets Manager
    Then the "secrets manager" "secret" will be "ACTIVE"
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @guard @negative @create_secret
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager fails when the "secretsmanager" "secret" already existed
    Given the "secretsmanager" "secret" already existed
    When a "secretsmanager" "secret" is created in Secrets Manager
    Then the operation is rejected
