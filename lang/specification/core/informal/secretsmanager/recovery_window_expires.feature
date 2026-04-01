@secretsmanager @generated
Feature: Secretsmanager - The Recovery Window For A Deleted "Secrets Manager" "Secret" Expires

  # Generated from FizzBee spec: secretsmanager.fizz
  # Safety invariants: ActiveSecretHasCurrentVersion, AtMostOneCurrentVersionPerSecret, AtMostOnePreviousVersionPerSecret, DeletedSecretWithClosedWindowNotRestored, SecretNamesAreUnique, VersionIdsAreUnique, DeletedSecretRecoveryWindowIsOpen, ActiveSecretHasVersion

  Background:
    Given the system is initialized

  @minimal @happy @recovery_window_expires @internal
  Scenario: the recovery window for a deleted "secrets manager" "secret" expires
    Given the "secrets manager" "secret" existed
    And the "secrets manager" "secret" was "DELETED"
    And the recovery window was open
    When the recovery window for a deleted "secrets manager" "secret" expires
    Then the "secrets manager" "secret" can no longer be restored
    And every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @guard @negative @recovery_window_expires @internal
  Scenario: the recovery window for a deleted "secrets manager" "secret" expires fails when the "secrets manager" "secret" did not exist
    Given the "secrets manager" "secret" did not exist
    When the recovery window for a deleted "secrets manager" "secret" expires
    Then the operation is rejected

  @guard @negative @recovery_window_expires @internal
  Scenario: the recovery window for a deleted "secrets manager" "secret" expires fails when the "secrets manager" "secret" was not "DELETED"
    Given the "secrets manager" "secret" existed
    And the "secrets manager" "secret" was not "DELETED"
    When the recovery window for a deleted "secrets manager" "secret" expires
    Then the operation is rejected

  @guard @negative @recovery_window_expires @internal
  Scenario: the recovery window for a deleted "secrets manager" "secret" expires fails when the recovery window was not open
    Given the "secrets manager" "secret" existed
    And the "secrets manager" "secret" was "DELETED"
    And the recovery window was not open
    When the recovery window for a deleted "secrets manager" "secret" expires
    Then the operation is rejected
