@secretsmanager @put_secret_value @dataplane
Feature: SecretsManager PutSecretValue

  @happy
  Scenario: Put a new value for an existing secret
    Given a secret "e2e-put-sv" was created with value "old"
    When I put secret value "new-value" for "e2e-put-sv"
    Then the command will succeed
    And secret "e2e-put-sv" will have value "new-value"
