@secretsmanager @list_secrets @controlplane
Feature: SecretsManager ListSecrets

  @happy
  Scenario: List secrets includes a created secret
    Given a secret "e2e-list-secrets" was created with value "x"
    When I list secrets
    Then the command will succeed
    And the secret list will include "e2e-list-secrets"
