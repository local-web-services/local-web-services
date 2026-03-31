@secretsmanagerlambda @generated
Feature: SecretsmanagerLambda - The "Lambda" "Rotation Function" Fails And The Rotation Is Aborted

  # Generated from FizzBee spec: secretsmanager_lambda.fizz
  # Safety invariants: RotatingSecretHasInProgressInvocation, SuccessfulRotationRotatedASecret

  Background:
    Given the system is initialized

  @minimal @happy @rotation_fails_function_deleted @internal
  Scenario: the "lambda" "rotation function" fails and the rotation is aborted
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the rotation function was "DELETED"
    When the "lambda" "rotation function" fails and the rotation is aborted
    Then the invocation will be "FAILED" and the "secretsmanager" "secret" remains "ACTIVE" with the old version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @guard @negative @rotation_fails_function_deleted @internal
  Scenario: the "lambda" "rotation function" fails and the rotation is aborted fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "rotation function" fails and the rotation is aborted
    Then the operation is rejected

  @guard @negative @rotation_fails_function_deleted @internal
  Scenario: the "lambda" "rotation function" fails and the rotation is aborted fails when the rotation function was not "DELETED"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the rotation function was not "DELETED"
    When the "lambda" "rotation function" fails and the rotation is aborted
    Then the operation is rejected
