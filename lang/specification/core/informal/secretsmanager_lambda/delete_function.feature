@secretsmanagerlambda @generated
Feature: SecretsmanagerLambda - The Rotation Function Is Deleted

  # Generated from FizzBee spec: secretsmanager_lambda.fizz
  # Safety invariants: RotatingSecretHasInProgressInvocation, SuccessfulRotationRotatedASecret

  Background:
    Given the system is initialized

  @minimal @happy @delete_function
  Scenario: the rotation function is deleted
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    When the rotation function is deleted
    Then the "lambda" "function" will be deleted and rotation will fail
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @guard @negative @delete_function
  Scenario: the rotation function is deleted fails when the "lambda" "function" did not exist
    Given the "lambda" "function" did not exist
    When the rotation function is deleted
    Then the operation is rejected

  @guard @negative @delete_function @lifecycle
  Scenario: the rotation function is deleted fails when the function is already "DELETED"
    Given the "lambda" "function" existed
    And the function is already "DELETED"
    When the rotation function is deleted
    Then the operation is rejected
