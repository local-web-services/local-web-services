@secretsmanager @generated
Feature: Secretsmanager - A Secret Is Deleted

  # Generated from FizzBee spec: secretsmanager.fizz
  # Safety invariants: ActiveSecretHasCurrentVersion, AtMostOneCurrentVersionPerSecret, AtMostOnePreviousVersionPerSecret, DeletedSecretWithClosedWindowNotRestored, SecretNamesAreUnique, VersionIdsAreUnique, DeletedSecretRecoveryWindowIsOpen, ActiveSecretHasVersion

  Background:
    Given the system is initialized

  @minimal @happy @delete_secret
  Scenario: a secret is deleted
    Given the secret exists
    And the secret is "ACTIVE"
    When a secret is deleted
    Then the secret is "DELETED" and the recovery window is open
    And every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @standard @negative @delete_secret
  Scenario: a secret is deleted fails when the secret does not exist
    Given the secret does not exist
    When a secret is deleted
    Then the operation is rejected

  @standard @negative @delete_secret @lifecycle
  Scenario: a secret is deleted fails when the secret is not "ACTIVE"
    Given the secret exists
    And the secret is not "ACTIVE"
    When a secret is deleted
    Then the operation is rejected
