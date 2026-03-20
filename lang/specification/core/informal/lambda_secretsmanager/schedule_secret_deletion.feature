@lambdasecretsmanager @generated
Feature: LambdaSecretsmanager - A Secret Is Scheduled For Deletion

  # Generated from FizzBee spec: lambda_secretsmanager.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationReadASecret

  Background:
    Given the system is initialized

  @minimal @happy @schedule_secret_deletion
  Scenario: a secret is scheduled for deletion
    Given the secret exists
    And the secret is "ACTIVE"
    When a secret is scheduled for deletion
    Then the secret is "PENDING_DELETION" and will be unavailable to Lambda during the recovery window
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @standard @negative @schedule_secret_deletion
  Scenario: a secret is scheduled for deletion fails when the secret does not exist
    Given the secret does not exist
    When a secret is scheduled for deletion
    Then the operation is rejected

  @standard @negative @schedule_secret_deletion @lifecycle
  Scenario: a secret is scheduled for deletion fails when the secret is not "ACTIVE"
    Given the secret exists
    And the secret is not "ACTIVE"
    When a secret is scheduled for deletion
    Then the operation is rejected
