@secretsmanagerlambda @generated
Feature: SecretsmanagerLambda - The Lambda Rotation Function Succeeds And The Secret Is Rotated To A New Version

  # Generated from FizzBee spec: secretsmanager_lambda.fizz
  # Safety invariants: RotatingSecretHasInProgressInvocation, SuccessfulRotationRotatedASecret

  Background:
    Given the system is initialized

  @minimal @happy @rotation_succeeds @internal
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version
    Given an invocation is "IN_PROGRESS"
    And the rotation function is "ACTIVE"
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    Then the invocation is "SUCCESS" and the secret is "ACTIVE" with a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @standard @negative @rotation_succeeds @internal
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    Then the operation is rejected

  @standard @negative @rotation_succeeds @internal
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version fails when the rotation function is not "ACTIVE"
    Given an invocation is "IN_PROGRESS"
    And the rotation function is not "ACTIVE"
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    Then the operation is rejected
