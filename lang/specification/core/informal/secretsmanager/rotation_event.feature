@secretsmanager @generated
Feature: Secretsmanager - An Automatic Rotation Event Occurs For An Active "Secrets Manager" "Secret"

  # Generated from FizzBee spec: secretsmanager.fizz
  # Safety invariants: ActiveSecretHasCurrentVersion, AtMostOneCurrentVersionPerSecret, AtMostOnePreviousVersionPerSecret, DeletedSecretWithClosedWindowNotRestored, SecretNamesAreUnique, VersionIdsAreUnique, DeletedSecretRecoveryWindowIsOpen, ActiveSecretHasVersion

  Background:
    Given the system is initialized

  @minimal @happy @rotation_event @internal
  Scenario: an automatic rotation event occurs for an active "secrets manager" "secret"
    Given the "secrets manager" "secret" existed
    And the "secrets manager" "secret" was "ACTIVE"
    When an automatic rotation event occurs for an active "secrets manager" "secret"
    Then a new "secrets manager" "secret" version will be created and the previous version will be retained
    And every "ACTIVE" "secrets manager" "secret" has a current version assigned
    And at most one current version exists per "secrets manager" "secret"
    And at most one previous version exists per "secrets manager" "secret"
    And a deleted "secrets manager" "secret" with a closed recovery window cannot be restored
    And all "secrets manager" "secret" names are unique
    And all "secrets manager" "secret" version identifiers are unique
    And every deleted "secrets manager" "secret" with an open recovery window can still be restored or expired
    And every active "secrets manager" "secret" has a current version assigned

  @guard @negative @rotation_event @internal
  Scenario: an automatic rotation event occurs for an active "secrets manager" "secret" fails when the "secrets manager" "secret" did not exist
    Given the "secrets manager" "secret" did not exist
    When an automatic rotation event occurs for an active "secrets manager" "secret"
    Then the operation is rejected

  @guard @negative @rotation_event @internal
  Scenario: an automatic rotation event occurs for an active "secrets manager" "secret" fails when the "secrets manager" "secret" was not "ACTIVE"
    Given the "secrets manager" "secret" existed
    And the "secrets manager" "secret" was not "ACTIVE"
    When an automatic rotation event occurs for an active "secrets manager" "secret"
    Then the operation is rejected
