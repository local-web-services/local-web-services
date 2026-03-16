@secretsmanagerlambda @generated
Feature: SecretsmanagerLambda - A Lambda Rotation Function Is Deployed

  # Generated from FizzBee spec: secretsmanager_lambda.fizz
  # Safety invariants: RotatingSecretHasInProgressInvocation, SuccessfulRotationRotatedASecret

  Background:
    Given the system is initialized

  @minimal @happy @deploy_function
  Scenario: a Lambda rotation function is deployed
    Given the function does not already exist
    When a Lambda rotation function is deployed
    Then the function is "ACTIVE"
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @standard @negative @deploy_function
  Scenario: a Lambda rotation function is deployed fails when the function already exists
    Given the function already exists
    When a Lambda rotation function is deployed
    Then the operation is rejected
