@secretsmanagerlambda @generated
Feature: SecretsmanagerLambda - The "Lambda" "Rotation Function" Succeeds And The "Secretsmanager" "Secret" Is Rotated To A New Version

  # Generated from FizzBee spec: secretsmanager_lambda.fizz
  # Safety invariants: RotatingSecretHasInProgressInvocation, SuccessfulRotationRotatedASecret

  Background:
    Given the system is initialized

  @minimal @happy @rotation_succeeds @internal
  Scenario: the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the rotation function was "ACTIVE"
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    Then the invocation will be "SUCCESS" and the "secrets manager" "secret" will be "ACTIVE" with a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @guard @negative @rotation_succeeds @internal
  Scenario: the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    Then the operation is rejected

  @guard @negative @rotation_succeeds @internal
  Scenario: the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version fails when the rotation function was not "ACTIVE"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the rotation function was not "ACTIVE"
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    Then the operation is rejected
