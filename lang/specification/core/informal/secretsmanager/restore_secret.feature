@secretsmanager @generated
Feature: Secretsmanager - A Deleted "Secrets Manager" "Secret" Is Restored Within The Recovery Window

  # Generated from FizzBee spec: secretsmanager.fizz
  # Safety invariants: ActiveSecretHasCurrentVersion, AtMostOneCurrentVersionPerSecret, AtMostOnePreviousVersionPerSecret, DeletedSecretWithClosedWindowNotRestored, SecretNamesAreUnique, VersionIdsAreUnique, DeletedSecretRecoveryWindowIsOpen, ActiveSecretHasVersion

  Background:
    Given the system is initialized

  @minimal @happy @restore_secret
  Scenario: a deleted "secrets manager" "secret" is restored within the recovery window
    Given the "secrets manager" "secret" existed
    And the "secrets manager" "secret" was "DELETED"
    And the recovery window was open
    When a deleted "secrets manager" "secret" is restored within the recovery window
    Then the "secrets manager" "secret" will be "ACTIVE" again and the recovery window will be closed
    And every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @guard @negative @restore_secret
  Scenario: a deleted "secrets manager" "secret" is restored within the recovery window fails when the "secrets manager" "secret" did not exist
    Given the "secrets manager" "secret" did not exist
    When a deleted "secrets manager" "secret" is restored within the recovery window
    Then the operation is rejected

  @guard @negative @restore_secret @lifecycle
  Scenario: a deleted "secrets manager" "secret" is restored within the recovery window fails when the "secrets manager" "secret" was not "DELETED"
    Given the "secrets manager" "secret" existed
    And the "secrets manager" "secret" was not "DELETED"
    When a deleted "secrets manager" "secret" is restored within the recovery window
    Then the operation is rejected

  @guard @negative @restore_secret @lifecycle
  Scenario: a deleted "secrets manager" "secret" is restored within the recovery window fails when the recovery window was not open
    Given the "secrets manager" "secret" existed
    And the "secrets manager" "secret" was "DELETED"
    And the recovery window was not open
    When a deleted "secrets manager" "secret" is restored within the recovery window
    Then the operation is rejected
