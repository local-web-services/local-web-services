@secretsmanager @generated
Feature: Secretsmanager - Metadata Or Description For An Active "Secrets Manager" "Secret" Is Updated

  # Generated from FizzBee spec: secretsmanager.fizz
  # Safety invariants: ActiveSecretHasCurrentVersion, AtMostOneCurrentVersionPerSecret, AtMostOnePreviousVersionPerSecret, DeletedSecretWithClosedWindowNotRestored, SecretNamesAreUnique, VersionIdsAreUnique, DeletedSecretRecoveryWindowIsOpen, ActiveSecretHasVersion

  Background:
    Given the system is initialized

  @minimal @happy @update_secret
  Scenario: metadata or description for an active "secrets manager" "secret" is updated
    Given the "secrets manager" "secret" existed
    And the "secrets manager" "secret" was "ACTIVE"
    When metadata or description for an active "secrets manager" "secret" is updated
    Then the "secrets manager" "secret" metadata will be updated
    And every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @guard @negative @update_secret
  Scenario: metadata or description for an active "secrets manager" "secret" is updated fails when the "secrets manager" "secret" did not exist
    Given the "secrets manager" "secret" did not exist
    When metadata or description for an active "secrets manager" "secret" is updated
    Then the operation is rejected

  @guard @negative @update_secret @lifecycle
  Scenario: metadata or description for an active "secrets manager" "secret" is updated fails when the "secrets manager" "secret" was not "ACTIVE"
    Given the "secrets manager" "secret" existed
    And the "secrets manager" "secret" was not "ACTIVE"
    When metadata or description for an active "secrets manager" "secret" is updated
    Then the operation is rejected
