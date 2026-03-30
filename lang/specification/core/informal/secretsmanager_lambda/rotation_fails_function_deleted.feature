@secretsmanagerlambda @generated
Feature: SecretsmanagerLambda - The Lambda Rotation Function Fails And The Rotation Is Aborted

  # Generated from FizzBee spec: secretsmanager_lambda.fizz
  # Safety invariants: RotatingSecretHasInProgressInvocation, SuccessfulRotationRotatedASecret

  Background:
    Given the system is initialized

  @minimal @happy @rotation_fails_function_deleted @internal
  Scenario: the Lambda rotation function fails and the rotation is aborted
    Given an invocation is "IN_PROGRESS"
    And the rotation function is "DELETED"
    When the Lambda rotation function fails and the rotation is aborted
    Then the invocation is "FAILED" and the secret remains "ACTIVE" with the old version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @guard @negative @rotation_fails_function_deleted @internal
  Scenario: the Lambda rotation function fails and the rotation is aborted fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda rotation function fails and the rotation is aborted
    Then the operation is rejected

  @guard @negative @rotation_fails_function_deleted @internal
  Scenario: the Lambda rotation function fails and the rotation is aborted fails when the rotation function is not "DELETED"
    Given an invocation is "IN_PROGRESS"
    And the rotation function is not "DELETED"
    When the Lambda rotation function fails and the rotation is aborted
    Then the operation is rejected
