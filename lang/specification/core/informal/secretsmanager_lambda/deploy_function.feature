@secretsmanagerlambda @generated
Feature: SecretsmanagerLambda - A "Lambda" "Rotation Function" Is Deployed

  # Generated from FizzBee spec: secretsmanager_lambda.fizz
  # Safety invariants: RotatingSecretHasInProgressInvocation, SuccessfulRotationRotatedASecret

  Background:
    Given the system is initialized

  @minimal @happy @deploy_function
  Scenario: a "lambda" "rotation function" is deployed
    Given the "lambda" "function" did not already exist
    When a "lambda" "rotation function" is deployed
    Then the "lambda" "function" will be "ACTIVE"
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @guard @negative @deploy_function
  Scenario: a "lambda" "rotation function" is deployed fails when the "lambda" "function" already existed
    Given the "lambda" "function" already existed
    When a "lambda" "rotation function" is deployed
    Then the operation is rejected
