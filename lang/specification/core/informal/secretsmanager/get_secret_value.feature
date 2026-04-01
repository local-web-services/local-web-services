@secretsmanager @generated
Feature: Secretsmanager - The Current Value Of An Active "Secrets Manager" "Secret" Is Retrieved

  # Generated from FizzBee spec: secretsmanager.fizz
  # Safety invariants: ActiveSecretHasCurrentVersion, AtMostOneCurrentVersionPerSecret, AtMostOnePreviousVersionPerSecret, DeletedSecretWithClosedWindowNotRestored, SecretNamesAreUnique, VersionIdsAreUnique, DeletedSecretRecoveryWindowIsOpen, ActiveSecretHasVersion

  Background:
    Given the system is initialized

  @minimal @happy @get_secret_value
  Scenario: the current value of an active "secrets manager" "secret" is retrieved
    Given the "secrets manager" "secret" existed
    And the "secrets manager" "secret" was "ACTIVE"
    When the current value of an active "secrets manager" "secret" is retrieved
    Then the current "secrets manager" "secret" value will be returned
    And every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @guard @negative @get_secret_value
  Scenario: the current value of an active "secrets manager" "secret" is retrieved fails when the "secrets manager" "secret" did not exist
    Given the "secrets manager" "secret" did not exist
    When the current value of an active "secrets manager" "secret" is retrieved
    Then the operation is rejected

  @guard @negative @get_secret_value @lifecycle
  Scenario: the current value of an active "secrets manager" "secret" is retrieved fails when the "secrets manager" "secret" was not "ACTIVE"
    Given the "secrets manager" "secret" existed
    And the "secrets manager" "secret" was not "ACTIVE"
    When the current value of an active "secrets manager" "secret" is retrieved
    Then the operation is rejected
