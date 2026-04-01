@secretsmanager @generated
Feature: Secretsmanager - A "Secrets Manager" "Secret" Is Deleted

  # Generated from FizzBee spec: secretsmanager.fizz
  # Safety invariants: ActiveSecretHasCurrentVersion, AtMostOneCurrentVersionPerSecret, AtMostOnePreviousVersionPerSecret, DeletedSecretWithClosedWindowNotRestored, SecretNamesAreUnique, VersionIdsAreUnique, DeletedSecretRecoveryWindowIsOpen, ActiveSecretHasVersion

  Background:
    Given the system is initialized

  @minimal @happy @delete_secret
  Scenario: a "secrets manager" "secret" is deleted
    Given the "secrets manager" "secret" existed
    And the "secrets manager" "secret" was "ACTIVE"
    When a "secrets manager" "secret" is deleted
    Then the "secrets manager" "secret" will be "DELETED" and the recovery window will be open
    And every "ACTIVE" "secrets manager" "secret" has a current version assigned
    And at most one current version exists per "secrets manager" "secret"
    And at most one previous version exists per "secrets manager" "secret"
    And a deleted "secrets manager" "secret" with a closed recovery window cannot be restored
    And all "secrets manager" "secret" names are unique
    And all "secrets manager" "secret" version identifiers are unique
    And every deleted "secrets manager" "secret" with an open recovery window can still be restored or expired
    And every active "secrets manager" "secret" has a current version assigned

  @guard @negative @delete_secret
  Scenario: a "secrets manager" "secret" is deleted fails when the "secrets manager" "secret" did not exist
    Given the "secrets manager" "secret" did not exist
    When a "secrets manager" "secret" is deleted
    Then the operation is rejected

  @guard @negative @delete_secret @lifecycle
  Scenario: a "secrets manager" "secret" is deleted fails when the "secrets manager" "secret" was not "ACTIVE"
    Given the "secrets manager" "secret" existed
    And the "secrets manager" "secret" was not "ACTIVE"
    When a "secrets manager" "secret" is deleted
    Then the operation is rejected
