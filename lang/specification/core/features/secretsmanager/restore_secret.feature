@secretsmanager @restore_secret @controlplane
Feature: SecretsManager RestoreSecret

  @happy
  Scenario: Restore a previously deleted secret
    Given a secret "e2e-restore-secret" was created with value "val"
    And the secret "e2e-restore-secret" was deleted
    When I restore secret "e2e-restore-secret"
    Then the command will succeed
    And secret "e2e-restore-secret" will appear in describe-secret
