@secretsmanagerlambda @generated
Feature: SecretsmanagerLambda - A Rotation Is Triggered For The Secret

  # Generated from FizzBee spec: secretsmanager_lambda.fizz
  # Safety invariants: RotatingSecretHasInProgressInvocation, SuccessfulRotationRotatedASecret

  Background:
    Given the system is initialized

  @minimal @happy @trigger_rotation
  Scenario: a rotation is triggered for the secret
    Given the secret exists and is "ACTIVE"
    And the secret has a rotation function configured
    And an invocation slot is available
    When a rotation is triggered for the secret
    Then the secret is "ROTATING" and Secrets Manager invokes the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @guard @negative @trigger_rotation @lifecycle
  Scenario: a rotation is triggered for the secret fails when the secret does not exist or is not "ACTIVE"
    Given the secret does not exist or is not "ACTIVE"
    When a rotation is triggered for the secret
    Then the operation is rejected

  @guard @negative @trigger_rotation
  Scenario: a rotation is triggered for the secret fails when the secret has no rotation function configured
    Given the secret exists and is "ACTIVE"
    And the secret has no rotation function configured
    When a rotation is triggered for the secret
    Then the operation is rejected

  @guard @negative @internal @trigger_rotation @capacity
  Scenario: a rotation is triggered for the secret fails when no invocation slot is available
    Given the secret exists and is "ACTIVE"
    And the secret has a rotation function configured
    And no invocation slot is available
    When a rotation is triggered for the secret
    Then the operation is rejected
