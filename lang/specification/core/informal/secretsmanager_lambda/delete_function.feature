@secretsmanagerlambda @generated
Feature: SecretsmanagerLambda - The "Lambda" "Rotation Function" Is Deleted

  # Generated from FizzBee spec: secretsmanager_lambda.fizz
  # Safety invariants: RotatingSecretHasInProgressInvocation, SuccessfulRotationRotatedASecret

  Background:
    Given the system is initialized

  @minimal @happy @delete_function
  Scenario: the "lambda" "rotation function" is deleted
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    When the "lambda" "rotation function" is deleted
    Then the "lambda" "function" will be deleted and rotation will fail
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @guard @negative @delete_function
  Scenario: the "lambda" "rotation function" is deleted fails when the "lambda" "function" did not exist
    Given the "lambda" "function" did not exist
    When the "lambda" "rotation function" is deleted
    Then the operation is rejected

  @guard @negative @delete_function @lifecycle
  Scenario: the "lambda" "rotation function" is deleted fails when the "lambda" "function" is already "DELETED"
    Given the "lambda" "function" existed
    And the "lambda" "function" is already "DELETED"
    When the "lambda" "rotation function" is deleted
    Then the operation is rejected
