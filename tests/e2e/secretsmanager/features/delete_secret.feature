@secretsmanager @delete_secret @controlplane
Feature: SecretsManager DeleteSecret

  @happy
  Scenario: Delete an existing secret with force flag
    Given a secret "e2e-del-secret" was created with value "gone"
    When I delete secret "e2e-del-secret" with force delete without recovery
    Then the command will succeed
    And secret "e2e-del-secret" will not appear in list-secrets
