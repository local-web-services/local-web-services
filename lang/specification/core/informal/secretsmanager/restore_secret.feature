@secretsmanager @generated
Feature: Secretsmanager - A Deleted Secret Is Restored Within The Recovery Window

  # Generated from FizzBee spec: secretsmanager.fizz
  # Safety invariants: ActiveSecretHasCurrentVersion, AtMostOneCurrentVersionPerSecret, AtMostOnePreviousVersionPerSecret, DeletedSecretWithClosedWindowNotRestored, SecretNamesAreUnique, VersionIdsAreUnique, DeletedSecretRecoveryWindowIsOpen, ActiveSecretHasVersion

  Background:
    Given the system is initialized

  @minimal @happy @restore_secret
  Scenario: a deleted secret is restored within the recovery window
    Given the secret exists
    And the secret is "DELETED"
    And the recovery window is open
    When a deleted secret is restored within the recovery window
    Then the secret is "ACTIVE" again and the recovery window is closed
    And every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @guard @negative @restore_secret
  Scenario: a deleted secret is restored within the recovery window fails when the secret does not exist
    Given the secret does not exist
    When a deleted secret is restored within the recovery window
    Then the operation is rejected

  @guard @negative @restore_secret @lifecycle
  Scenario: a deleted secret is restored within the recovery window fails when the secret is not "DELETED"
    Given the secret exists
    And the secret is not "DELETED"
    When a deleted secret is restored within the recovery window
    Then the operation is rejected

  @guard @negative @restore_secret @lifecycle
  Scenario: a deleted secret is restored within the recovery window fails when the recovery window is not open
    Given the secret exists
    And the secret is "DELETED"
    And the recovery window is not open
    When a deleted secret is restored within the recovery window
    Then the operation is rejected
