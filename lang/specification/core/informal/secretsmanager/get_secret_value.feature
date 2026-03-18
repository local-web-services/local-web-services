@secretsmanager @generated
Feature: Secretsmanager - The Current Value Of An Active Secret Is Retrieved

  # Generated from FizzBee spec: secretsmanager.fizz
  # Safety invariants: ActiveSecretHasCurrentVersion, AtMostOneCurrentVersionPerSecret, AtMostOnePreviousVersionPerSecret, DeletedSecretWithClosedWindowNotRestored, SecretNamesAreUnique, VersionIdsAreUnique, DeletedSecretRecoveryWindowIsOpen, ActiveSecretHasVersion

  Background:
    Given the system is initialized

  @minimal @happy @get_secret_value
  Scenario: the current value of an active secret is retrieved
    Given the secret exists
    And the secret is "ACTIVE"
    When the current value of an active secret is retrieved
    Then the current secret value is returned
    And every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @standard @negative @get_secret_value
  Scenario: the current value of an active secret is retrieved fails when the secret does not exist
    Given the secret does not exist
    When the current value of an active secret is retrieved
    Then the operation is rejected

  @standard @negative @get_secret_value @lifecycle @internal
  Scenario: the current value of an active secret is retrieved fails when the secret is not "ACTIVE"
    Given the secret exists
    And the secret is not "ACTIVE"
    When the current value of an active secret is retrieved
    Then the operation is rejected
