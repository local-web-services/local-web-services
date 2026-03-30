@secretsmanagerlambda @generated
Feature: SecretsmanagerLambda - Rotation Is Configured On The Secret Linking It To The Lambda Rotation Function

  # Generated from FizzBee spec: secretsmanager_lambda.fizz
  # Safety invariants: RotatingSecretHasInProgressInvocation, SuccessfulRotationRotatedASecret

  Background:
    Given the system is initialized

  @minimal @happy @configure_rotation
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function
    Given the secret exists and is "ACTIVE"
    And the function exists and is "ACTIVE"
    And the secret has no rotation function configured
    When rotation is configured on the secret linking it to the Lambda rotation function
    Then the secret has a rotation function configured
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @guard @negative @configure_rotation @lifecycle
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function fails when the secret does not exist or is not "ACTIVE"
    Given the secret does not exist or is not "ACTIVE"
    When rotation is configured on the secret linking it to the Lambda rotation function
    Then the operation is rejected

  @guard @negative @configure_rotation
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function fails when the function does not exist or is not "ACTIVE"
    Given the secret exists and is "ACTIVE"
    And the function does not exist or is not "ACTIVE"
    When rotation is configured on the secret linking it to the Lambda rotation function
    Then the operation is rejected

  @guard @negative @configure_rotation
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function fails when the secret already has a rotation function configured
    Given the secret exists and is "ACTIVE"
    And the function exists and is "ACTIVE"
    And the secret already has a rotation function configured
    When rotation is configured on the secret linking it to the Lambda rotation function
    Then the operation is rejected
