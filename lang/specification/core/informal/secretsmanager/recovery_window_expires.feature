@secretsmanager @generated
Feature: Secretsmanager - The Recovery Window For A Deleted Secret Expires

  # Generated from FizzBee spec: secretsmanager.fizz
  # Safety invariants: ActiveSecretHasCurrentVersion, AtMostOneCurrentVersionPerSecret, AtMostOnePreviousVersionPerSecret, DeletedSecretWithClosedWindowNotRestored, SecretNamesAreUnique, VersionIdsAreUnique, DeletedSecretRecoveryWindowIsOpen, ActiveSecretHasVersion

  Background:
    Given the system is initialized

  @minimal @happy @recovery_window_expires @internal
  Scenario: the recovery window for a deleted secret expires
    Given the secret exists
    And the secret is "DELETED"
    And the recovery window is open
    When the recovery window for a deleted secret expires
    Then the secret can no longer be restored
    And every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @standard @negative @recovery_window_expires @internal
  Scenario: the recovery window for a deleted secret expires fails when the secret does not exist
    Given the secret does not exist
    When the recovery window for a deleted secret expires
    Then the operation is rejected

  @standard @negative @recovery_window_expires @internal
  Scenario: the recovery window for a deleted secret expires fails when the secret is not "DELETED"
    Given the secret exists
    And the secret is not "DELETED"
    When the recovery window for a deleted secret expires
    Then the operation is rejected

  @standard @negative @recovery_window_expires @internal
  Scenario: the recovery window for a deleted secret expires fails when the recovery window is not open
    Given the secret exists
    And the secret is "DELETED"
    And the recovery window is not open
    When the recovery window for a deleted secret expires
    Then the operation is rejected
