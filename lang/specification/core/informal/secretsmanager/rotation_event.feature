@secretsmanager @generated
Feature: Secretsmanager - An Automatic Rotation Event Occurs For An Active Secret

  # Generated from FizzBee spec: secretsmanager.fizz
  # Safety invariants: ActiveSecretHasCurrentVersion, AtMostOneCurrentVersionPerSecret, AtMostOnePreviousVersionPerSecret, DeletedSecretWithClosedWindowNotRestored, SecretNamesAreUnique, VersionIdsAreUnique, DeletedSecretRecoveryWindowIsOpen, ActiveSecretHasVersion

  Background:
    Given the system is initialized

  @minimal @happy @rotation_event @internal
  Scenario: an automatic rotation event occurs for an active secret
    Given the secret exists
    And the secret is "ACTIVE"
    When an automatic rotation event occurs for an active secret
    Then a new secret version is created and the previous version is retained
    And every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @standard @negative @rotation_event @internal
  Scenario: an automatic rotation event occurs for an active secret fails when the secret does not exist
    Given the secret does not exist
    When an automatic rotation event occurs for an active secret
    Then the operation is rejected

  @standard @negative @rotation_event @internal
  Scenario: an automatic rotation event occurs for an active secret fails when the secret is not "ACTIVE"
    Given the secret exists
    And the secret is not "ACTIVE"
    When an automatic rotation event occurs for an active secret
    Then the operation is rejected
