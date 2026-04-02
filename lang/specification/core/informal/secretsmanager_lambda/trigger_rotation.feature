@secretsmanagerlambda @generated
Feature: SecretsmanagerLambda - A Rotation Is Triggered For The "Secretsmanager" "Secret"

  # Generated from FizzBee spec: secretsmanager_lambda.fizz
  # Safety invariants: RotatingSecretHasInProgressInvocation, SuccessfulRotationRotatedASecret

  Background:
    Given the system is initialized

  @minimal @happy @trigger_rotation
  Scenario: a rotation is triggered for the "secretsmanager" "secret"
    Given the "secrets manager" "secret" existed and was "ACTIVE"
    And the "secretsmanager" "secret" has a rotation function configured
    And a "lambda" "invocation" slot is available
    When a rotation is triggered for the "secretsmanager" "secret"
    Then the "secrets manager" "secret" will be "ROTATING" and Secrets Manager will invoke the "lambda" "rotation function"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @guard @negative @trigger_rotation @lifecycle
  Scenario: a rotation is triggered for the "secretsmanager" "secret" fails when the "secrets manager" "secret" did not exist or was not "ACTIVE"
    Given the "secrets manager" "secret" did not exist or was not "ACTIVE"
    When a rotation is triggered for the "secretsmanager" "secret"
    Then the operation is rejected

  @guard @negative @trigger_rotation
  Scenario: a rotation is triggered for the "secretsmanager" "secret" fails when the "secretsmanager" "secret" has no rotation function configured
    Given the "secrets manager" "secret" existed and was "ACTIVE"
    And the "secretsmanager" "secret" has no rotation function configured
    When a rotation is triggered for the "secretsmanager" "secret"
    Then the operation is rejected

  @guard @negative @trigger_rotation @capacity
  Scenario: a rotation is triggered for the "secretsmanager" "secret" fails when no "lambda" "invocation" "slot" was "available"
    Given the "secrets manager" "secret" existed and was "ACTIVE"
    And the "secretsmanager" "secret" has a rotation function configured
    And no "lambda" "invocation" "slot" was "available"
    When a rotation is triggered for the "secretsmanager" "secret"
    Then the operation is rejected
