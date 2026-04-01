@secretsmanagerlambda @generated
Feature: SecretsmanagerLambda - Rotation Is Configured On The "Secretsmanager" "Secret" Linking It To The "Lambda" "Rotation Function"

  # Generated from FizzBee spec: secretsmanager_lambda.fizz
  # Safety invariants: RotatingSecretHasInProgressInvocation, SuccessfulRotationRotatedASecret

  Background:
    Given the system is initialized

  @minimal @happy @configure_rotation
  Scenario: rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    Given the "secrets manager" "secret" existed and was "ACTIVE"
    And the "lambda" "function" existed and was "ACTIVE"
    And the "secretsmanager" "secret" has no rotation function configured
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    Then the "secretsmanager" "secret" has a rotation function configured
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @guard @negative @configure_rotation @lifecycle
  Scenario: rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function" fails when the "secrets manager" "secret" did not exist or was not "ACTIVE"
    Given the "secrets manager" "secret" did not exist or was not "ACTIVE"
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    Then the operation is rejected

  @guard @negative @configure_rotation
  Scenario: rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function" fails when the "lambda" "function" did not exist or was "ACTIVE"
    Given the "secrets manager" "secret" existed and was "ACTIVE"
    And the "lambda" "function" did not exist or was "ACTIVE"
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    Then the operation is rejected

  @guard @negative @configure_rotation
  Scenario: rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function" fails when the "secretsmanager" "secret" already has a rotation function configured
    Given the "secrets manager" "secret" existed and was "ACTIVE"
    And the "lambda" "function" existed and was "ACTIVE"
    And the "secretsmanager" "secret" already has a rotation function configured
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    Then the operation is rejected
