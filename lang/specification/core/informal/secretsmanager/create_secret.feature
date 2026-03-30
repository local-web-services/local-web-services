@secretsmanager @generated
Feature: Secretsmanager - A Secret Is Created

  # Generated from FizzBee spec: secretsmanager.fizz
  # Safety invariants: ActiveSecretHasCurrentVersion, AtMostOneCurrentVersionPerSecret, AtMostOnePreviousVersionPerSecret, DeletedSecretWithClosedWindowNotRestored, SecretNamesAreUnique, VersionIdsAreUnique, DeletedSecretRecoveryWindowIsOpen, ActiveSecretHasVersion

  Background:
    Given the system is initialized

  @minimal @happy @create_secret
  Scenario: a secret is created
    Given the secret does not already exist
    When a secret is created
    Then the secret is "ACTIVE" with an initial version
    And every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @guard @negative @create_secret
  Scenario: a secret is created fails when the secret already exists
    Given the secret already exists
    When a secret is created
    Then the operation is rejected
