@secretsmanager @update_secret @controlplane
Feature: SecretsManager UpdateSecret

  @happy
  Scenario: Update an existing secret with a new value
    Given a secret "e2e-update-secret" was created with value "old-val"
    When I update secret "e2e-update-secret" with value "new-val"
    Then the command will succeed
    And secret "e2e-update-secret" will have value "new-val"
