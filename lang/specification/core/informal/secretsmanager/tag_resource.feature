@secretsmanager @generated
Feature: Secretsmanager - Tags Are Added To An Active "Secrets Manager" "Secret"

  # Generated from FizzBee spec: secretsmanager.fizz
  # Safety invariants: ActiveSecretHasCurrentVersion, AtMostOneCurrentVersionPerSecret, AtMostOnePreviousVersionPerSecret, DeletedSecretWithClosedWindowNotRestored, SecretNamesAreUnique, VersionIdsAreUnique, DeletedSecretRecoveryWindowIsOpen, ActiveSecretHasVersion

  Background:
    Given the system is initialized

  @minimal @happy @tag_resource
  Scenario: tags are added to an active "secrets manager" "secret"
    Given the "secrets manager" "secret" existed
    And the "secrets manager" "secret" was "ACTIVE"
    When tags are added to an active "secrets manager" "secret"
    Then the specified tags are associated with the "secrets manager" "secret"
    And every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @guard @negative @tag_resource
  Scenario: tags are added to an active "secrets manager" "secret" fails when the "secrets manager" "secret" did not exist
    Given the "secrets manager" "secret" did not exist
    When tags are added to an active "secrets manager" "secret"
    Then the operation is rejected

  @guard @negative @tag_resource @lifecycle
  Scenario: tags are added to an active "secrets manager" "secret" fails when the "secrets manager" "secret" was not "ACTIVE"
    Given the "secrets manager" "secret" existed
    And the "secrets manager" "secret" was not "ACTIVE"
    When tags are added to an active "secrets manager" "secret"
    Then the operation is rejected
