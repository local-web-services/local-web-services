@secretsmanager @list_secret_version_ids @controlplane
Feature: SecretsManager ListSecretVersionIds

  @happy
  Scenario: List version IDs for an existing secret
    Given a secret "e2e-list-version-ids" was created with value "val"
    When I list secret version IDs for "e2e-list-version-ids"
    Then the command will succeed
