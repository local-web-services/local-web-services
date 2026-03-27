@secretsmanager @generated
Feature: Secretsmanager - Action Sequences

  # Generated from FizzBee spec: secretsmanager.fizz
  # Safety invariants: ActiveSecretHasCurrentVersion, AtMostOneCurrentVersionPerSecret, AtMostOnePreviousVersionPerSecret, DeletedSecretWithClosedWindowNotRestored, SecretNamesAreUnique, VersionIdsAreUnique, DeletedSecretRecoveryWindowIsOpen, ActiveSecretHasVersion

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a secret is created then a secret is deleted
    Given sname not in secret_status
    Given a secret has been created
    When a secret is deleted
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is created then a deleted secret is restored within the recovery window
    Given sname not in secret_status
    Given a secret has been created
    When a deleted secret is restored within the recovery window
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is created then a secret is described
    Given sname not in secret_status
    Given a secret has been created
    When a secret is described
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is created then the current value of an active secret is retrieved
    Given sname not in secret_status
    Given a secret has been created
    When the current value of an active secret is retrieved
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is created then a new value is stored for an active secret
    Given sname not in secret_status
    Given a secret has been created
    When a new value is stored for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is created then metadata or description for an active secret is updated
    Given sname not in secret_status
    Given a secret has been created
    When metadata or description for an active secret is updated
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is created then all secrets are listed
    Given sname not in secret_status
    Given a secret has been created
    When all secrets are listed
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is created then tags are added to an active secret
    Given sname not in secret_status
    Given a secret has been created
    When tags are added to an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is created then tags are removed from an active secret
    Given sname not in secret_status
    Given a secret has been created
    When tags are removed from an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is created then the recovery window for a deleted secret expires
    Given sname not in secret_status
    Given a secret has been created
    When the recovery window for a deleted secret expires
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is created then an automatic rotation event occurs for an active secret
    Given sname not in secret_status
    Given a secret has been created
    When an automatic rotation event occurs for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is deleted then a secret is created
    Given sname in secret_status
    Given a secret has been deleted
    When a secret is created
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is deleted then a deleted secret is restored within the recovery window
    Given sname in secret_status
    Given a secret has been deleted
    When a deleted secret is restored within the recovery window
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is deleted then a secret is described
    Given sname in secret_status
    Given a secret has been deleted
    When a secret is described
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is deleted then the current value of an active secret is retrieved
    Given sname in secret_status
    Given a secret has been deleted
    When the current value of an active secret is retrieved
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is deleted then a new value is stored for an active secret
    Given sname in secret_status
    Given a secret has been deleted
    When a new value is stored for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is deleted then metadata or description for an active secret is updated
    Given sname in secret_status
    Given a secret has been deleted
    When metadata or description for an active secret is updated
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is deleted then all secrets are listed
    Given sname in secret_status
    Given a secret has been deleted
    When all secrets are listed
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is deleted then tags are added to an active secret
    Given sname in secret_status
    Given a secret has been deleted
    When tags are added to an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is deleted then tags are removed from an active secret
    Given sname in secret_status
    Given a secret has been deleted
    When tags are removed from an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is deleted then the recovery window for a deleted secret expires
    Given sname in secret_status
    Given a secret has been deleted
    When the recovery window for a deleted secret expires
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is deleted then an automatic rotation event occurs for an active secret
    Given sname in secret_status
    Given a secret has been deleted
    When an automatic rotation event occurs for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a deleted secret is restored within the recovery window then a secret is created
    Given sname in secret_status
    Given a deleted secret has been restored within the recovery window
    When a secret is created
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a deleted secret is restored within the recovery window then a secret is deleted
    Given sname in secret_status
    Given a deleted secret has been restored within the recovery window
    When a secret is deleted
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a deleted secret is restored within the recovery window then a secret is described
    Given sname in secret_status
    Given a deleted secret has been restored within the recovery window
    When a secret is described
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a deleted secret is restored within the recovery window then the current value of an active secret is retrieved
    Given sname in secret_status
    Given a deleted secret has been restored within the recovery window
    When the current value of an active secret is retrieved
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a deleted secret is restored within the recovery window then a new value is stored for an active secret
    Given sname in secret_status
    Given a deleted secret has been restored within the recovery window
    When a new value is stored for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a deleted secret is restored within the recovery window then metadata or description for an active secret is updated
    Given sname in secret_status
    Given a deleted secret has been restored within the recovery window
    When metadata or description for an active secret is updated
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a deleted secret is restored within the recovery window then all secrets are listed
    Given sname in secret_status
    Given a deleted secret has been restored within the recovery window
    When all secrets are listed
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a deleted secret is restored within the recovery window then tags are added to an active secret
    Given sname in secret_status
    Given a deleted secret has been restored within the recovery window
    When tags are added to an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a deleted secret is restored within the recovery window then tags are removed from an active secret
    Given sname in secret_status
    Given a deleted secret has been restored within the recovery window
    When tags are removed from an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a deleted secret is restored within the recovery window then the recovery window for a deleted secret expires
    Given sname in secret_status
    Given a deleted secret has been restored within the recovery window
    When the recovery window for a deleted secret expires
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a deleted secret is restored within the recovery window then an automatic rotation event occurs for an active secret
    Given sname in secret_status
    Given a deleted secret has been restored within the recovery window
    When an automatic rotation event occurs for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is described then a secret is created
    Given sname in secret_status
    Given a secret has been described
    When a secret is created
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is described then a secret is deleted
    Given sname in secret_status
    Given a secret has been described
    When a secret is deleted
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is described then a deleted secret is restored within the recovery window
    Given sname in secret_status
    Given a secret has been described
    When a deleted secret is restored within the recovery window
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is described then the current value of an active secret is retrieved
    Given sname in secret_status
    Given a secret has been described
    When the current value of an active secret is retrieved
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is described then a new value is stored for an active secret
    Given sname in secret_status
    Given a secret has been described
    When a new value is stored for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is described then metadata or description for an active secret is updated
    Given sname in secret_status
    Given a secret has been described
    When metadata or description for an active secret is updated
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is described then all secrets are listed
    Given sname in secret_status
    Given a secret has been described
    When all secrets are listed
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is described then tags are added to an active secret
    Given sname in secret_status
    Given a secret has been described
    When tags are added to an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is described then tags are removed from an active secret
    Given sname in secret_status
    Given a secret has been described
    When tags are removed from an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is described then the recovery window for a deleted secret expires
    Given sname in secret_status
    Given a secret has been described
    When the recovery window for a deleted secret expires
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is described then an automatic rotation event occurs for an active secret
    Given sname in secret_status
    Given a secret has been described
    When an automatic rotation event occurs for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the current value of an active secret is retrieved then a secret is created
    Given sname in secret_status
    Given the current value of an active secret has been retrieved
    When a secret is created
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the current value of an active secret is retrieved then a secret is deleted
    Given sname in secret_status
    Given the current value of an active secret has been retrieved
    When a secret is deleted
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the current value of an active secret is retrieved then a deleted secret is restored within the recovery window
    Given sname in secret_status
    Given the current value of an active secret has been retrieved
    When a deleted secret is restored within the recovery window
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the current value of an active secret is retrieved then a secret is described
    Given sname in secret_status
    Given the current value of an active secret has been retrieved
    When a secret is described
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the current value of an active secret is retrieved then a new value is stored for an active secret
    Given sname in secret_status
    Given the current value of an active secret has been retrieved
    When a new value is stored for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the current value of an active secret is retrieved then metadata or description for an active secret is updated
    Given sname in secret_status
    Given the current value of an active secret has been retrieved
    When metadata or description for an active secret is updated
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the current value of an active secret is retrieved then all secrets are listed
    Given sname in secret_status
    Given the current value of an active secret has been retrieved
    When all secrets are listed
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the current value of an active secret is retrieved then tags are added to an active secret
    Given sname in secret_status
    Given the current value of an active secret has been retrieved
    When tags are added to an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the current value of an active secret is retrieved then tags are removed from an active secret
    Given sname in secret_status
    Given the current value of an active secret has been retrieved
    When tags are removed from an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the current value of an active secret is retrieved then the recovery window for a deleted secret expires
    Given sname in secret_status
    Given the current value of an active secret has been retrieved
    When the recovery window for a deleted secret expires
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the current value of an active secret is retrieved then an automatic rotation event occurs for an active secret
    Given sname in secret_status
    Given the current value of an active secret has been retrieved
    When an automatic rotation event occurs for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a new value is stored for an active secret then a secret is created
    Given sname in secret_status
    Given a new value has been stored for an active secret
    When a secret is created
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a new value is stored for an active secret then a secret is deleted
    Given sname in secret_status
    Given a new value has been stored for an active secret
    When a secret is deleted
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a new value is stored for an active secret then a deleted secret is restored within the recovery window
    Given sname in secret_status
    Given a new value has been stored for an active secret
    When a deleted secret is restored within the recovery window
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a new value is stored for an active secret then a secret is described
    Given sname in secret_status
    Given a new value has been stored for an active secret
    When a secret is described
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a new value is stored for an active secret then the current value of an active secret is retrieved
    Given sname in secret_status
    Given a new value has been stored for an active secret
    When the current value of an active secret is retrieved
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a new value is stored for an active secret then metadata or description for an active secret is updated
    Given sname in secret_status
    Given a new value has been stored for an active secret
    When metadata or description for an active secret is updated
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a new value is stored for an active secret then all secrets are listed
    Given sname in secret_status
    Given a new value has been stored for an active secret
    When all secrets are listed
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a new value is stored for an active secret then tags are added to an active secret
    Given sname in secret_status
    Given a new value has been stored for an active secret
    When tags are added to an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a new value is stored for an active secret then tags are removed from an active secret
    Given sname in secret_status
    Given a new value has been stored for an active secret
    When tags are removed from an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a new value is stored for an active secret then the recovery window for a deleted secret expires
    Given sname in secret_status
    Given a new value has been stored for an active secret
    When the recovery window for a deleted secret expires
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a new value is stored for an active secret then an automatic rotation event occurs for an active secret
    Given sname in secret_status
    Given a new value has been stored for an active secret
    When an automatic rotation event occurs for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: metadata or description for an active secret is updated then a secret is created
    Given sname in secret_status
    Given metadata or description for an active secret has been updated
    When a secret is created
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: metadata or description for an active secret is updated then a secret is deleted
    Given sname in secret_status
    Given metadata or description for an active secret has been updated
    When a secret is deleted
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: metadata or description for an active secret is updated then a deleted secret is restored within the recovery window
    Given sname in secret_status
    Given metadata or description for an active secret has been updated
    When a deleted secret is restored within the recovery window
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: metadata or description for an active secret is updated then a secret is described
    Given sname in secret_status
    Given metadata or description for an active secret has been updated
    When a secret is described
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: metadata or description for an active secret is updated then the current value of an active secret is retrieved
    Given sname in secret_status
    Given metadata or description for an active secret has been updated
    When the current value of an active secret is retrieved
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: metadata or description for an active secret is updated then a new value is stored for an active secret
    Given sname in secret_status
    Given metadata or description for an active secret has been updated
    When a new value is stored for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: metadata or description for an active secret is updated then all secrets are listed
    Given sname in secret_status
    Given metadata or description for an active secret has been updated
    When all secrets are listed
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: metadata or description for an active secret is updated then tags are added to an active secret
    Given sname in secret_status
    Given metadata or description for an active secret has been updated
    When tags are added to an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: metadata or description for an active secret is updated then tags are removed from an active secret
    Given sname in secret_status
    Given metadata or description for an active secret has been updated
    When tags are removed from an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: metadata or description for an active secret is updated then the recovery window for a deleted secret expires
    Given sname in secret_status
    Given metadata or description for an active secret has been updated
    When the recovery window for a deleted secret expires
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: metadata or description for an active secret is updated then an automatic rotation event occurs for an active secret
    Given sname in secret_status
    Given metadata or description for an active secret has been updated
    When an automatic rotation event occurs for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: all secrets are listed then a secret is created
    Given all secrets have been listed
    Given sname not in secret_status
    When a secret is created
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: all secrets are listed then a secret is deleted
    Given all secrets have been listed
    Given sname in secret_status
    When a secret is deleted
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: all secrets are listed then a deleted secret is restored within the recovery window
    Given all secrets have been listed
    Given sname in secret_status
    When a deleted secret is restored within the recovery window
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: all secrets are listed then a secret is described
    Given all secrets have been listed
    Given sname in secret_status
    When a secret is described
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: all secrets are listed then the current value of an active secret is retrieved
    Given all secrets have been listed
    Given sname in secret_status
    When the current value of an active secret is retrieved
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: all secrets are listed then a new value is stored for an active secret
    Given all secrets have been listed
    Given sname in secret_status
    When a new value is stored for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: all secrets are listed then metadata or description for an active secret is updated
    Given all secrets have been listed
    Given sname in secret_status
    When metadata or description for an active secret is updated
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: all secrets are listed then tags are added to an active secret
    Given all secrets have been listed
    Given sname in secret_status
    When tags are added to an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: all secrets are listed then tags are removed from an active secret
    Given all secrets have been listed
    Given sname in secret_status
    When tags are removed from an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: all secrets are listed then the recovery window for a deleted secret expires
    Given all secrets have been listed
    Given sname in secret_status
    When the recovery window for a deleted secret expires
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: all secrets are listed then an automatic rotation event occurs for an active secret
    Given all secrets have been listed
    Given sname in secret_status
    When an automatic rotation event occurs for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are added to an active secret then a secret is created
    Given sname in secret_status
    Given tags have been added to an active secret
    When a secret is created
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are added to an active secret then a secret is deleted
    Given sname in secret_status
    Given tags have been added to an active secret
    When a secret is deleted
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are added to an active secret then a deleted secret is restored within the recovery window
    Given sname in secret_status
    Given tags have been added to an active secret
    When a deleted secret is restored within the recovery window
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are added to an active secret then a secret is described
    Given sname in secret_status
    Given tags have been added to an active secret
    When a secret is described
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are added to an active secret then the current value of an active secret is retrieved
    Given sname in secret_status
    Given tags have been added to an active secret
    When the current value of an active secret is retrieved
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are added to an active secret then a new value is stored for an active secret
    Given sname in secret_status
    Given tags have been added to an active secret
    When a new value is stored for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are added to an active secret then metadata or description for an active secret is updated
    Given sname in secret_status
    Given tags have been added to an active secret
    When metadata or description for an active secret is updated
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are added to an active secret then all secrets are listed
    Given sname in secret_status
    Given tags have been added to an active secret
    When all secrets are listed
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are added to an active secret then tags are removed from an active secret
    Given sname in secret_status
    Given tags have been added to an active secret
    When tags are removed from an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are added to an active secret then the recovery window for a deleted secret expires
    Given sname in secret_status
    Given tags have been added to an active secret
    When the recovery window for a deleted secret expires
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are added to an active secret then an automatic rotation event occurs for an active secret
    Given sname in secret_status
    Given tags have been added to an active secret
    When an automatic rotation event occurs for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are removed from an active secret then a secret is created
    Given sname in secret_status
    Given tags have been removed from an active secret
    When a secret is created
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are removed from an active secret then a secret is deleted
    Given sname in secret_status
    Given tags have been removed from an active secret
    When a secret is deleted
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are removed from an active secret then a deleted secret is restored within the recovery window
    Given sname in secret_status
    Given tags have been removed from an active secret
    When a deleted secret is restored within the recovery window
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are removed from an active secret then a secret is described
    Given sname in secret_status
    Given tags have been removed from an active secret
    When a secret is described
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are removed from an active secret then the current value of an active secret is retrieved
    Given sname in secret_status
    Given tags have been removed from an active secret
    When the current value of an active secret is retrieved
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are removed from an active secret then a new value is stored for an active secret
    Given sname in secret_status
    Given tags have been removed from an active secret
    When a new value is stored for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are removed from an active secret then metadata or description for an active secret is updated
    Given sname in secret_status
    Given tags have been removed from an active secret
    When metadata or description for an active secret is updated
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are removed from an active secret then all secrets are listed
    Given sname in secret_status
    Given tags have been removed from an active secret
    When all secrets are listed
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are removed from an active secret then tags are added to an active secret
    Given sname in secret_status
    Given tags have been removed from an active secret
    When tags are added to an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are removed from an active secret then the recovery window for a deleted secret expires
    Given sname in secret_status
    Given tags have been removed from an active secret
    When the recovery window for a deleted secret expires
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are removed from an active secret then an automatic rotation event occurs for an active secret
    Given sname in secret_status
    Given tags have been removed from an active secret
    When an automatic rotation event occurs for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the recovery window for a deleted secret expires then a secret is created
    Given sname in secret_status
    Given the recovery window for a deleted secret has expired
    When a secret is created
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the recovery window for a deleted secret expires then a secret is deleted
    Given sname in secret_status
    Given the recovery window for a deleted secret has expired
    When a secret is deleted
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the recovery window for a deleted secret expires then a deleted secret is restored within the recovery window
    Given sname in secret_status
    Given the recovery window for a deleted secret has expired
    When a deleted secret is restored within the recovery window
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the recovery window for a deleted secret expires then a secret is described
    Given sname in secret_status
    Given the recovery window for a deleted secret has expired
    When a secret is described
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the recovery window for a deleted secret expires then the current value of an active secret is retrieved
    Given sname in secret_status
    Given the recovery window for a deleted secret has expired
    When the current value of an active secret is retrieved
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the recovery window for a deleted secret expires then a new value is stored for an active secret
    Given sname in secret_status
    Given the recovery window for a deleted secret has expired
    When a new value is stored for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the recovery window for a deleted secret expires then metadata or description for an active secret is updated
    Given sname in secret_status
    Given the recovery window for a deleted secret has expired
    When metadata or description for an active secret is updated
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the recovery window for a deleted secret expires then all secrets are listed
    Given sname in secret_status
    Given the recovery window for a deleted secret has expired
    When all secrets are listed
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the recovery window for a deleted secret expires then tags are added to an active secret
    Given sname in secret_status
    Given the recovery window for a deleted secret has expired
    When tags are added to an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the recovery window for a deleted secret expires then tags are removed from an active secret
    Given sname in secret_status
    Given the recovery window for a deleted secret has expired
    When tags are removed from an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the recovery window for a deleted secret expires then an automatic rotation event occurs for an active secret
    Given sname in secret_status
    Given the recovery window for a deleted secret has expired
    When an automatic rotation event occurs for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: an automatic rotation event occurs for an active secret then a secret is created
    Given sname in secret_status
    Given an automatic rotation event has occurred for an active secret
    When a secret is created
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: an automatic rotation event occurs for an active secret then a secret is deleted
    Given sname in secret_status
    Given an automatic rotation event has occurred for an active secret
    When a secret is deleted
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: an automatic rotation event occurs for an active secret then a deleted secret is restored within the recovery window
    Given sname in secret_status
    Given an automatic rotation event has occurred for an active secret
    When a deleted secret is restored within the recovery window
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: an automatic rotation event occurs for an active secret then a secret is described
    Given sname in secret_status
    Given an automatic rotation event has occurred for an active secret
    When a secret is described
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: an automatic rotation event occurs for an active secret then the current value of an active secret is retrieved
    Given sname in secret_status
    Given an automatic rotation event has occurred for an active secret
    When the current value of an active secret is retrieved
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: an automatic rotation event occurs for an active secret then a new value is stored for an active secret
    Given sname in secret_status
    Given an automatic rotation event has occurred for an active secret
    When a new value is stored for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: an automatic rotation event occurs for an active secret then metadata or description for an active secret is updated
    Given sname in secret_status
    Given an automatic rotation event has occurred for an active secret
    When metadata or description for an active secret is updated
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: an automatic rotation event occurs for an active secret then all secrets are listed
    Given sname in secret_status
    Given an automatic rotation event has occurred for an active secret
    When all secrets are listed
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: an automatic rotation event occurs for an active secret then tags are added to an active secret
    Given sname in secret_status
    Given an automatic rotation event has occurred for an active secret
    When tags are added to an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: an automatic rotation event occurs for an active secret then tags are removed from an active secret
    Given sname in secret_status
    Given an automatic rotation event has occurred for an active secret
    When tags are removed from an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: an automatic rotation event occurs for an active secret then the recovery window for a deleted secret expires
    Given sname in secret_status
    Given an automatic rotation event has occurred for an active secret
    When the recovery window for a deleted secret expires
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is created then a secret is deleted then a deleted secret is restored within the recovery window
    Given sname not in secret_status
    Given a secret has been created
    Given a secret has been deleted
    When a deleted secret is restored within the recovery window
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is created then a deleted secret is restored within the recovery window then a secret is described
    Given sname not in secret_status
    Given a secret has been created
    Given a deleted secret has been restored within the recovery window
    When a secret is described
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is created then a secret is described then the current value of an active secret is retrieved
    Given sname not in secret_status
    Given a secret has been created
    Given a secret has been described
    When the current value of an active secret is retrieved
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is created then the current value of an active secret is retrieved then a new value is stored for an active secret
    Given sname not in secret_status
    Given a secret has been created
    Given the current value of an active secret has been retrieved
    When a new value is stored for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is created then a new value is stored for an active secret then metadata or description for an active secret is updated
    Given sname not in secret_status
    Given a secret has been created
    Given a new value has been stored for an active secret
    When metadata or description for an active secret is updated
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is created then metadata or description for an active secret is updated then all secrets are listed
    Given sname not in secret_status
    Given a secret has been created
    Given metadata or description for an active secret has been updated
    When all secrets are listed
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is created then all secrets are listed then tags are added to an active secret
    Given sname not in secret_status
    Given a secret has been created
    Given all secrets have been listed
    When tags are added to an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is created then tags are added to an active secret then tags are removed from an active secret
    Given sname not in secret_status
    Given a secret has been created
    Given tags have been added to an active secret
    When tags are removed from an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is created then tags are removed from an active secret then the recovery window for a deleted secret expires
    Given sname not in secret_status
    Given a secret has been created
    Given tags have been removed from an active secret
    When the recovery window for a deleted secret expires
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is created then the recovery window for a deleted secret expires then an automatic rotation event occurs for an active secret
    Given sname not in secret_status
    Given a secret has been created
    Given the recovery window for a deleted secret has expired
    When an automatic rotation event occurs for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is created then an automatic rotation event occurs for an active secret then a secret is deleted
    Given sname not in secret_status
    Given a secret has been created
    Given an automatic rotation event has occurred for an active secret
    When a secret is deleted
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is deleted then a secret is created then a secret is described
    Given sname in secret_status
    Given a secret has been deleted
    Given a secret has been created
    When a secret is described
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is deleted then a deleted secret is restored within the recovery window then the current value of an active secret is retrieved
    Given sname in secret_status
    Given a secret has been deleted
    Given a deleted secret has been restored within the recovery window
    When the current value of an active secret is retrieved
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is deleted then a secret is described then a new value is stored for an active secret
    Given sname in secret_status
    Given a secret has been deleted
    Given a secret has been described
    When a new value is stored for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is deleted then the current value of an active secret is retrieved then metadata or description for an active secret is updated
    Given sname in secret_status
    Given a secret has been deleted
    Given the current value of an active secret has been retrieved
    When metadata or description for an active secret is updated
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is deleted then a new value is stored for an active secret then all secrets are listed
    Given sname in secret_status
    Given a secret has been deleted
    Given a new value has been stored for an active secret
    When all secrets are listed
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is deleted then metadata or description for an active secret is updated then tags are added to an active secret
    Given sname in secret_status
    Given a secret has been deleted
    Given metadata or description for an active secret has been updated
    When tags are added to an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is deleted then all secrets are listed then tags are removed from an active secret
    Given sname in secret_status
    Given a secret has been deleted
    Given all secrets have been listed
    When tags are removed from an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is deleted then tags are added to an active secret then the recovery window for a deleted secret expires
    Given sname in secret_status
    Given a secret has been deleted
    Given tags have been added to an active secret
    When the recovery window for a deleted secret expires
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is deleted then tags are removed from an active secret then an automatic rotation event occurs for an active secret
    Given sname in secret_status
    Given a secret has been deleted
    Given tags have been removed from an active secret
    When an automatic rotation event occurs for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is deleted then the recovery window for a deleted secret expires then a secret is created
    Given sname in secret_status
    Given a secret has been deleted
    Given the recovery window for a deleted secret has expired
    When a secret is created
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is deleted then an automatic rotation event occurs for an active secret then a deleted secret is restored within the recovery window
    Given sname in secret_status
    Given a secret has been deleted
    Given an automatic rotation event has occurred for an active secret
    When a deleted secret is restored within the recovery window
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a deleted secret is restored within the recovery window then a secret is created then the current value of an active secret is retrieved
    Given sname in secret_status
    Given a deleted secret has been restored within the recovery window
    Given a secret has been created
    When the current value of an active secret is retrieved
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a deleted secret is restored within the recovery window then a secret is deleted then a new value is stored for an active secret
    Given sname in secret_status
    Given a deleted secret has been restored within the recovery window
    Given a secret has been deleted
    When a new value is stored for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a deleted secret is restored within the recovery window then a secret is described then metadata or description for an active secret is updated
    Given sname in secret_status
    Given a deleted secret has been restored within the recovery window
    Given a secret has been described
    When metadata or description for an active secret is updated
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a deleted secret is restored within the recovery window then the current value of an active secret is retrieved then all secrets are listed
    Given sname in secret_status
    Given a deleted secret has been restored within the recovery window
    Given the current value of an active secret has been retrieved
    When all secrets are listed
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a deleted secret is restored within the recovery window then a new value is stored for an active secret then tags are added to an active secret
    Given sname in secret_status
    Given a deleted secret has been restored within the recovery window
    Given a new value has been stored for an active secret
    When tags are added to an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a deleted secret is restored within the recovery window then metadata or description for an active secret is updated then tags are removed from an active secret
    Given sname in secret_status
    Given a deleted secret has been restored within the recovery window
    Given metadata or description for an active secret has been updated
    When tags are removed from an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a deleted secret is restored within the recovery window then all secrets are listed then the recovery window for a deleted secret expires
    Given sname in secret_status
    Given a deleted secret has been restored within the recovery window
    Given all secrets have been listed
    When the recovery window for a deleted secret expires
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a deleted secret is restored within the recovery window then tags are added to an active secret then an automatic rotation event occurs for an active secret
    Given sname in secret_status
    Given a deleted secret has been restored within the recovery window
    Given tags have been added to an active secret
    When an automatic rotation event occurs for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a deleted secret is restored within the recovery window then tags are removed from an active secret then a secret is created
    Given sname in secret_status
    Given a deleted secret has been restored within the recovery window
    Given tags have been removed from an active secret
    When a secret is created
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a deleted secret is restored within the recovery window then the recovery window for a deleted secret expires then a secret is deleted
    Given sname in secret_status
    Given a deleted secret has been restored within the recovery window
    Given the recovery window for a deleted secret has expired
    When a secret is deleted
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a deleted secret is restored within the recovery window then an automatic rotation event occurs for an active secret then a secret is described
    Given sname in secret_status
    Given a deleted secret has been restored within the recovery window
    Given an automatic rotation event has occurred for an active secret
    When a secret is described
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is described then a secret is created then a new value is stored for an active secret
    Given sname in secret_status
    Given a secret has been described
    Given a secret has been created
    When a new value is stored for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is described then a secret is deleted then metadata or description for an active secret is updated
    Given sname in secret_status
    Given a secret has been described
    Given a secret has been deleted
    When metadata or description for an active secret is updated
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is described then a deleted secret is restored within the recovery window then all secrets are listed
    Given sname in secret_status
    Given a secret has been described
    Given a deleted secret has been restored within the recovery window
    When all secrets are listed
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is described then the current value of an active secret is retrieved then tags are added to an active secret
    Given sname in secret_status
    Given a secret has been described
    Given the current value of an active secret has been retrieved
    When tags are added to an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is described then a new value is stored for an active secret then tags are removed from an active secret
    Given sname in secret_status
    Given a secret has been described
    Given a new value has been stored for an active secret
    When tags are removed from an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is described then metadata or description for an active secret is updated then the recovery window for a deleted secret expires
    Given sname in secret_status
    Given a secret has been described
    Given metadata or description for an active secret has been updated
    When the recovery window for a deleted secret expires
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is described then all secrets are listed then an automatic rotation event occurs for an active secret
    Given sname in secret_status
    Given a secret has been described
    Given all secrets have been listed
    When an automatic rotation event occurs for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is described then tags are added to an active secret then a secret is created
    Given sname in secret_status
    Given a secret has been described
    Given tags have been added to an active secret
    When a secret is created
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is described then tags are removed from an active secret then a secret is deleted
    Given sname in secret_status
    Given a secret has been described
    Given tags have been removed from an active secret
    When a secret is deleted
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is described then the recovery window for a deleted secret expires then a deleted secret is restored within the recovery window
    Given sname in secret_status
    Given a secret has been described
    Given the recovery window for a deleted secret has expired
    When a deleted secret is restored within the recovery window
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a secret is described then an automatic rotation event occurs for an active secret then the current value of an active secret is retrieved
    Given sname in secret_status
    Given a secret has been described
    Given an automatic rotation event has occurred for an active secret
    When the current value of an active secret is retrieved
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the current value of an active secret is retrieved then a secret is created then metadata or description for an active secret is updated
    Given sname in secret_status
    Given the current value of an active secret has been retrieved
    Given a secret has been created
    When metadata or description for an active secret is updated
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the current value of an active secret is retrieved then a secret is deleted then all secrets are listed
    Given sname in secret_status
    Given the current value of an active secret has been retrieved
    Given a secret has been deleted
    When all secrets are listed
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the current value of an active secret is retrieved then a deleted secret is restored within the recovery window then tags are added to an active secret
    Given sname in secret_status
    Given the current value of an active secret has been retrieved
    Given a deleted secret has been restored within the recovery window
    When tags are added to an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the current value of an active secret is retrieved then a secret is described then tags are removed from an active secret
    Given sname in secret_status
    Given the current value of an active secret has been retrieved
    Given a secret has been described
    When tags are removed from an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the current value of an active secret is retrieved then a new value is stored for an active secret then the recovery window for a deleted secret expires
    Given sname in secret_status
    Given the current value of an active secret has been retrieved
    Given a new value has been stored for an active secret
    When the recovery window for a deleted secret expires
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the current value of an active secret is retrieved then metadata or description for an active secret is updated then an automatic rotation event occurs for an active secret
    Given sname in secret_status
    Given the current value of an active secret has been retrieved
    Given metadata or description for an active secret has been updated
    When an automatic rotation event occurs for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the current value of an active secret is retrieved then all secrets are listed then a secret is created
    Given sname in secret_status
    Given the current value of an active secret has been retrieved
    Given all secrets have been listed
    When a secret is created
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the current value of an active secret is retrieved then tags are added to an active secret then a secret is deleted
    Given sname in secret_status
    Given the current value of an active secret has been retrieved
    Given tags have been added to an active secret
    When a secret is deleted
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the current value of an active secret is retrieved then tags are removed from an active secret then a deleted secret is restored within the recovery window
    Given sname in secret_status
    Given the current value of an active secret has been retrieved
    Given tags have been removed from an active secret
    When a deleted secret is restored within the recovery window
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the current value of an active secret is retrieved then the recovery window for a deleted secret expires then a secret is described
    Given sname in secret_status
    Given the current value of an active secret has been retrieved
    Given the recovery window for a deleted secret has expired
    When a secret is described
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the current value of an active secret is retrieved then an automatic rotation event occurs for an active secret then a new value is stored for an active secret
    Given sname in secret_status
    Given the current value of an active secret has been retrieved
    Given an automatic rotation event has occurred for an active secret
    When a new value is stored for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a new value is stored for an active secret then a secret is created then all secrets are listed
    Given sname in secret_status
    Given a new value has been stored for an active secret
    Given a secret has been created
    When all secrets are listed
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a new value is stored for an active secret then a secret is deleted then tags are added to an active secret
    Given sname in secret_status
    Given a new value has been stored for an active secret
    Given a secret has been deleted
    When tags are added to an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a new value is stored for an active secret then a deleted secret is restored within the recovery window then tags are removed from an active secret
    Given sname in secret_status
    Given a new value has been stored for an active secret
    Given a deleted secret has been restored within the recovery window
    When tags are removed from an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a new value is stored for an active secret then a secret is described then the recovery window for a deleted secret expires
    Given sname in secret_status
    Given a new value has been stored for an active secret
    Given a secret has been described
    When the recovery window for a deleted secret expires
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a new value is stored for an active secret then the current value of an active secret is retrieved then an automatic rotation event occurs for an active secret
    Given sname in secret_status
    Given a new value has been stored for an active secret
    Given the current value of an active secret has been retrieved
    When an automatic rotation event occurs for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a new value is stored for an active secret then metadata or description for an active secret is updated then a secret is created
    Given sname in secret_status
    Given a new value has been stored for an active secret
    Given metadata or description for an active secret has been updated
    When a secret is created
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a new value is stored for an active secret then all secrets are listed then a secret is deleted
    Given sname in secret_status
    Given a new value has been stored for an active secret
    Given all secrets have been listed
    When a secret is deleted
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a new value is stored for an active secret then tags are added to an active secret then a deleted secret is restored within the recovery window
    Given sname in secret_status
    Given a new value has been stored for an active secret
    Given tags have been added to an active secret
    When a deleted secret is restored within the recovery window
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a new value is stored for an active secret then tags are removed from an active secret then a secret is described
    Given sname in secret_status
    Given a new value has been stored for an active secret
    Given tags have been removed from an active secret
    When a secret is described
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a new value is stored for an active secret then the recovery window for a deleted secret expires then the current value of an active secret is retrieved
    Given sname in secret_status
    Given a new value has been stored for an active secret
    Given the recovery window for a deleted secret has expired
    When the current value of an active secret is retrieved
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: a new value is stored for an active secret then an automatic rotation event occurs for an active secret then metadata or description for an active secret is updated
    Given sname in secret_status
    Given a new value has been stored for an active secret
    Given an automatic rotation event has occurred for an active secret
    When metadata or description for an active secret is updated
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: metadata or description for an active secret is updated then a secret is created then tags are added to an active secret
    Given sname in secret_status
    Given metadata or description for an active secret has been updated
    Given a secret has been created
    When tags are added to an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: metadata or description for an active secret is updated then a secret is deleted then tags are removed from an active secret
    Given sname in secret_status
    Given metadata or description for an active secret has been updated
    Given a secret has been deleted
    When tags are removed from an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: metadata or description for an active secret is updated then a deleted secret is restored within the recovery window then the recovery window for a deleted secret expires
    Given sname in secret_status
    Given metadata or description for an active secret has been updated
    Given a deleted secret has been restored within the recovery window
    When the recovery window for a deleted secret expires
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: metadata or description for an active secret is updated then a secret is described then an automatic rotation event occurs for an active secret
    Given sname in secret_status
    Given metadata or description for an active secret has been updated
    Given a secret has been described
    When an automatic rotation event occurs for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: metadata or description for an active secret is updated then the current value of an active secret is retrieved then a secret is created
    Given sname in secret_status
    Given metadata or description for an active secret has been updated
    Given the current value of an active secret has been retrieved
    When a secret is created
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: metadata or description for an active secret is updated then a new value is stored for an active secret then a secret is deleted
    Given sname in secret_status
    Given metadata or description for an active secret has been updated
    Given a new value has been stored for an active secret
    When a secret is deleted
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: metadata or description for an active secret is updated then all secrets are listed then a deleted secret is restored within the recovery window
    Given sname in secret_status
    Given metadata or description for an active secret has been updated
    Given all secrets have been listed
    When a deleted secret is restored within the recovery window
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: metadata or description for an active secret is updated then tags are added to an active secret then a secret is described
    Given sname in secret_status
    Given metadata or description for an active secret has been updated
    Given tags have been added to an active secret
    When a secret is described
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: metadata or description for an active secret is updated then tags are removed from an active secret then the current value of an active secret is retrieved
    Given sname in secret_status
    Given metadata or description for an active secret has been updated
    Given tags have been removed from an active secret
    When the current value of an active secret is retrieved
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: metadata or description for an active secret is updated then the recovery window for a deleted secret expires then a new value is stored for an active secret
    Given sname in secret_status
    Given metadata or description for an active secret has been updated
    Given the recovery window for a deleted secret has expired
    When a new value is stored for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: metadata or description for an active secret is updated then an automatic rotation event occurs for an active secret then all secrets are listed
    Given sname in secret_status
    Given metadata or description for an active secret has been updated
    Given an automatic rotation event has occurred for an active secret
    When all secrets are listed
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: all secrets are listed then a secret is created then tags are removed from an active secret
    Given all secrets have been listed
    Given sname not in secret_status
    Given a secret has been created
    When tags are removed from an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: all secrets are listed then a secret is deleted then the recovery window for a deleted secret expires
    Given all secrets have been listed
    Given sname in secret_status
    Given a secret has been deleted
    When the recovery window for a deleted secret expires
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: all secrets are listed then a deleted secret is restored within the recovery window then an automatic rotation event occurs for an active secret
    Given all secrets have been listed
    Given sname in secret_status
    Given a deleted secret has been restored within the recovery window
    When an automatic rotation event occurs for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: all secrets are listed then a secret is described then a secret is created
    Given all secrets have been listed
    Given sname in secret_status
    Given a secret has been described
    When a secret is created
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: all secrets are listed then the current value of an active secret is retrieved then a secret is deleted
    Given all secrets have been listed
    Given sname in secret_status
    Given the current value of an active secret has been retrieved
    When a secret is deleted
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: all secrets are listed then a new value is stored for an active secret then a deleted secret is restored within the recovery window
    Given all secrets have been listed
    Given sname in secret_status
    Given a new value has been stored for an active secret
    When a deleted secret is restored within the recovery window
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: all secrets are listed then metadata or description for an active secret is updated then a secret is described
    Given all secrets have been listed
    Given sname in secret_status
    Given metadata or description for an active secret has been updated
    When a secret is described
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: all secrets are listed then tags are added to an active secret then the current value of an active secret is retrieved
    Given all secrets have been listed
    Given sname in secret_status
    Given tags have been added to an active secret
    When the current value of an active secret is retrieved
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: all secrets are listed then tags are removed from an active secret then a new value is stored for an active secret
    Given all secrets have been listed
    Given sname in secret_status
    Given tags have been removed from an active secret
    When a new value is stored for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: all secrets are listed then the recovery window for a deleted secret expires then metadata or description for an active secret is updated
    Given all secrets have been listed
    Given sname in secret_status
    Given the recovery window for a deleted secret has expired
    When metadata or description for an active secret is updated
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: all secrets are listed then an automatic rotation event occurs for an active secret then tags are added to an active secret
    Given all secrets have been listed
    Given sname in secret_status
    Given an automatic rotation event has occurred for an active secret
    When tags are added to an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are added to an active secret then a secret is created then the recovery window for a deleted secret expires
    Given sname in secret_status
    Given tags have been added to an active secret
    Given a secret has been created
    When the recovery window for a deleted secret expires
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are added to an active secret then a secret is deleted then an automatic rotation event occurs for an active secret
    Given sname in secret_status
    Given tags have been added to an active secret
    Given a secret has been deleted
    When an automatic rotation event occurs for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are added to an active secret then a deleted secret is restored within the recovery window then a secret is created
    Given sname in secret_status
    Given tags have been added to an active secret
    Given a deleted secret has been restored within the recovery window
    When a secret is created
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are added to an active secret then a secret is described then a secret is deleted
    Given sname in secret_status
    Given tags have been added to an active secret
    Given a secret has been described
    When a secret is deleted
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are added to an active secret then the current value of an active secret is retrieved then a deleted secret is restored within the recovery window
    Given sname in secret_status
    Given tags have been added to an active secret
    Given the current value of an active secret has been retrieved
    When a deleted secret is restored within the recovery window
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are added to an active secret then a new value is stored for an active secret then a secret is described
    Given sname in secret_status
    Given tags have been added to an active secret
    Given a new value has been stored for an active secret
    When a secret is described
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are added to an active secret then metadata or description for an active secret is updated then the current value of an active secret is retrieved
    Given sname in secret_status
    Given tags have been added to an active secret
    Given metadata or description for an active secret has been updated
    When the current value of an active secret is retrieved
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are added to an active secret then all secrets are listed then a new value is stored for an active secret
    Given sname in secret_status
    Given tags have been added to an active secret
    Given all secrets have been listed
    When a new value is stored for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are added to an active secret then tags are removed from an active secret then metadata or description for an active secret is updated
    Given sname in secret_status
    Given tags have been added to an active secret
    Given tags have been removed from an active secret
    When metadata or description for an active secret is updated
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are added to an active secret then the recovery window for a deleted secret expires then all secrets are listed
    Given sname in secret_status
    Given tags have been added to an active secret
    Given the recovery window for a deleted secret has expired
    When all secrets are listed
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are added to an active secret then an automatic rotation event occurs for an active secret then tags are removed from an active secret
    Given sname in secret_status
    Given tags have been added to an active secret
    Given an automatic rotation event has occurred for an active secret
    When tags are removed from an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are removed from an active secret then a secret is created then an automatic rotation event occurs for an active secret
    Given sname in secret_status
    Given tags have been removed from an active secret
    Given a secret has been created
    When an automatic rotation event occurs for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are removed from an active secret then a secret is deleted then a secret is created
    Given sname in secret_status
    Given tags have been removed from an active secret
    Given a secret has been deleted
    When a secret is created
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are removed from an active secret then a deleted secret is restored within the recovery window then a secret is deleted
    Given sname in secret_status
    Given tags have been removed from an active secret
    Given a deleted secret has been restored within the recovery window
    When a secret is deleted
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are removed from an active secret then a secret is described then a deleted secret is restored within the recovery window
    Given sname in secret_status
    Given tags have been removed from an active secret
    Given a secret has been described
    When a deleted secret is restored within the recovery window
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are removed from an active secret then the current value of an active secret is retrieved then a secret is described
    Given sname in secret_status
    Given tags have been removed from an active secret
    Given the current value of an active secret has been retrieved
    When a secret is described
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are removed from an active secret then a new value is stored for an active secret then the current value of an active secret is retrieved
    Given sname in secret_status
    Given tags have been removed from an active secret
    Given a new value has been stored for an active secret
    When the current value of an active secret is retrieved
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are removed from an active secret then metadata or description for an active secret is updated then a new value is stored for an active secret
    Given sname in secret_status
    Given tags have been removed from an active secret
    Given metadata or description for an active secret has been updated
    When a new value is stored for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are removed from an active secret then all secrets are listed then metadata or description for an active secret is updated
    Given sname in secret_status
    Given tags have been removed from an active secret
    Given all secrets have been listed
    When metadata or description for an active secret is updated
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are removed from an active secret then tags are added to an active secret then all secrets are listed
    Given sname in secret_status
    Given tags have been removed from an active secret
    Given tags have been added to an active secret
    When all secrets are listed
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are removed from an active secret then the recovery window for a deleted secret expires then tags are added to an active secret
    Given sname in secret_status
    Given tags have been removed from an active secret
    Given the recovery window for a deleted secret has expired
    When tags are added to an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: tags are removed from an active secret then an automatic rotation event occurs for an active secret then the recovery window for a deleted secret expires
    Given sname in secret_status
    Given tags have been removed from an active secret
    Given an automatic rotation event has occurred for an active secret
    When the recovery window for a deleted secret expires
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the recovery window for a deleted secret expires then a secret is created then a secret is deleted
    Given sname in secret_status
    Given the recovery window for a deleted secret has expired
    Given a secret has been created
    When a secret is deleted
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the recovery window for a deleted secret expires then a secret is deleted then a deleted secret is restored within the recovery window
    Given sname in secret_status
    Given the recovery window for a deleted secret has expired
    Given a secret has been deleted
    When a deleted secret is restored within the recovery window
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the recovery window for a deleted secret expires then a deleted secret is restored within the recovery window then a secret is described
    Given sname in secret_status
    Given the recovery window for a deleted secret has expired
    Given a deleted secret has been restored within the recovery window
    When a secret is described
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the recovery window for a deleted secret expires then a secret is described then the current value of an active secret is retrieved
    Given sname in secret_status
    Given the recovery window for a deleted secret has expired
    Given a secret has been described
    When the current value of an active secret is retrieved
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the recovery window for a deleted secret expires then the current value of an active secret is retrieved then a new value is stored for an active secret
    Given sname in secret_status
    Given the recovery window for a deleted secret has expired
    Given the current value of an active secret has been retrieved
    When a new value is stored for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the recovery window for a deleted secret expires then a new value is stored for an active secret then metadata or description for an active secret is updated
    Given sname in secret_status
    Given the recovery window for a deleted secret has expired
    Given a new value has been stored for an active secret
    When metadata or description for an active secret is updated
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the recovery window for a deleted secret expires then metadata or description for an active secret is updated then all secrets are listed
    Given sname in secret_status
    Given the recovery window for a deleted secret has expired
    Given metadata or description for an active secret has been updated
    When all secrets are listed
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the recovery window for a deleted secret expires then all secrets are listed then tags are added to an active secret
    Given sname in secret_status
    Given the recovery window for a deleted secret has expired
    Given all secrets have been listed
    When tags are added to an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the recovery window for a deleted secret expires then tags are added to an active secret then tags are removed from an active secret
    Given sname in secret_status
    Given the recovery window for a deleted secret has expired
    Given tags have been added to an active secret
    When tags are removed from an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the recovery window for a deleted secret expires then tags are removed from an active secret then an automatic rotation event occurs for an active secret
    Given sname in secret_status
    Given the recovery window for a deleted secret has expired
    Given tags have been removed from an active secret
    When an automatic rotation event occurs for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: the recovery window for a deleted secret expires then an automatic rotation event occurs for an active secret then a secret is created
    Given sname in secret_status
    Given the recovery window for a deleted secret has expired
    Given an automatic rotation event has occurred for an active secret
    When a secret is created
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: an automatic rotation event occurs for an active secret then a secret is created then a deleted secret is restored within the recovery window
    Given sname in secret_status
    Given an automatic rotation event has occurred for an active secret
    Given a secret has been created
    When a deleted secret is restored within the recovery window
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: an automatic rotation event occurs for an active secret then a secret is deleted then a secret is described
    Given sname in secret_status
    Given an automatic rotation event has occurred for an active secret
    Given a secret has been deleted
    When a secret is described
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: an automatic rotation event occurs for an active secret then a deleted secret is restored within the recovery window then the current value of an active secret is retrieved
    Given sname in secret_status
    Given an automatic rotation event has occurred for an active secret
    Given a deleted secret has been restored within the recovery window
    When the current value of an active secret is retrieved
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: an automatic rotation event occurs for an active secret then a secret is described then a new value is stored for an active secret
    Given sname in secret_status
    Given an automatic rotation event has occurred for an active secret
    Given a secret has been described
    When a new value is stored for an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: an automatic rotation event occurs for an active secret then the current value of an active secret is retrieved then metadata or description for an active secret is updated
    Given sname in secret_status
    Given an automatic rotation event has occurred for an active secret
    Given the current value of an active secret has been retrieved
    When metadata or description for an active secret is updated
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: an automatic rotation event occurs for an active secret then a new value is stored for an active secret then all secrets are listed
    Given sname in secret_status
    Given an automatic rotation event has occurred for an active secret
    Given a new value has been stored for an active secret
    When all secrets are listed
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: an automatic rotation event occurs for an active secret then metadata or description for an active secret is updated then tags are added to an active secret
    Given sname in secret_status
    Given an automatic rotation event has occurred for an active secret
    Given metadata or description for an active secret has been updated
    When tags are added to an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: an automatic rotation event occurs for an active secret then all secrets are listed then tags are removed from an active secret
    Given sname in secret_status
    Given an automatic rotation event has occurred for an active secret
    Given all secrets have been listed
    When tags are removed from an active secret
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: an automatic rotation event occurs for an active secret then tags are added to an active secret then the recovery window for a deleted secret expires
    Given sname in secret_status
    Given an automatic rotation event has occurred for an active secret
    Given tags have been added to an active secret
    When the recovery window for a deleted secret expires
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: an automatic rotation event occurs for an active secret then tags are removed from an active secret then a secret is created
    Given sname in secret_status
    Given an automatic rotation event has occurred for an active secret
    Given tags have been removed from an active secret
    When a secret is created
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned

  @exhaustive @sequence
  Scenario: an automatic rotation event occurs for an active secret then the recovery window for a deleted secret expires then a secret is deleted
    Given sname in secret_status
    Given an automatic rotation event has occurred for an active secret
    Given the recovery window for a deleted secret has expired
    When a secret is deleted
    Then every "ACTIVE" secret has a current version assigned
    And at most one current version exists per secret
    And at most one previous version exists per secret
    And a deleted secret with a closed recovery window cannot be restored
    And all secret names are unique
    And all version identifiers are unique across secrets
    And every deleted secret with an open recovery window can still be restored or expired
    And every active secret has a current version assigned
