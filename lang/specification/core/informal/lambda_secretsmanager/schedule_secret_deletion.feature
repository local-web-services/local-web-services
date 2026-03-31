@lambdasecretsmanager @generated
Feature: LambdaSecretsmanager - A "Secretsmanager" "Secret" Is Scheduled For Deletion

  # Generated from FizzBee spec: lambda_secretsmanager.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationReadASecret

  Background:
    Given the system is initialized

  @minimal @happy @schedule_secret_deletion
  Scenario: a "secretsmanager" "secret" is scheduled for deletion
    Given the secrets manager secret existed
    And the "secrets manager" "secret" was "ACTIVE"
    When a "secretsmanager" "secret" is scheduled for deletion
    Then the "secrets manager" "secret" will be "PENDING_DELETION" and will be unavailable to Lambda during the recovery window
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @guard @negative @schedule_secret_deletion
  Scenario: a "secretsmanager" "secret" is scheduled for deletion fails when the secrets manager secret did not exist
    Given the secrets manager secret did not exist
    When a "secretsmanager" "secret" is scheduled for deletion
    Then the operation is rejected

  @guard @negative @schedule_secret_deletion @lifecycle
  Scenario: a "secretsmanager" "secret" is scheduled for deletion fails when the "secrets manager" "secret" was not "ACTIVE"
    Given the secrets manager secret existed
    And the "secrets manager" "secret" was not "ACTIVE"
    When a "secretsmanager" "secret" is scheduled for deletion
    Then the operation is rejected
