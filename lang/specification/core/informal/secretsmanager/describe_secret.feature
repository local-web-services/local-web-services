@secretsmanager @generated
Feature: Secretsmanager - A "Secrets Manager" "Secret" Is Described

  # Generated from FizzBee spec: secretsmanager.fizz
  # Safety invariants: ActiveSecretHasCurrentVersion, AtMostOneCurrentVersionPerSecret, AtMostOnePreviousVersionPerSecret, DeletedSecretWithClosedWindowNotRestored, SecretNamesAreUnique, VersionIdsAreUnique, DeletedSecretRecoveryWindowIsOpen, ActiveSecretHasVersion

  Background:
    Given the system is initialized

  @minimal @happy @describe_secret
  Scenario: a "secrets manager" "secret" is described
    Given the "secrets manager" "secret" existed
    When a "secrets manager" "secret" is described
    Then the "secrets manager" "secret" metadata will be returned
    And every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @guard @negative @describe_secret
  Scenario: a "secrets manager" "secret" is described fails when the "secrets manager" "secret" did not exist
    Given the "secrets manager" "secret" did not exist
    When a "secrets manager" "secret" is described
    Then the operation is rejected
