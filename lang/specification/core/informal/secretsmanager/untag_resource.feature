@secretsmanager @generated
Feature: Secretsmanager - Tags Are Removed From An Active Secret

  # Generated from FizzBee spec: secretsmanager.fizz
  # Safety invariants: ActiveSecretHasCurrentVersion, AtMostOneCurrentVersionPerSecret, AtMostOnePreviousVersionPerSecret, DeletedSecretWithClosedWindowNotRestored, SecretNamesAreUnique, VersionIdsAreUnique, DeletedSecretRecoveryWindowIsOpen, ActiveSecretHasVersion

  Background:
    Given the system is initialized

  @minimal @happy @untag_resource
  Scenario: tags are removed from an active secret
    Given the secret exists
    And the secret is "ACTIVE"
    When tags are removed from an active secret
    Then the specified tags are no longer associated with the secret
    And every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @guard @negative @untag_resource
  Scenario: tags are removed from an active secret fails when the secret does not exist
    Given the secret does not exist
    When tags are removed from an active secret
    Then the operation is rejected

  @guard @negative @untag_resource @lifecycle
  Scenario: tags are removed from an active secret fails when the secret is not "ACTIVE"
    Given the secret exists
    And the secret is not "ACTIVE"
    When tags are removed from an active secret
    Then the operation is rejected
