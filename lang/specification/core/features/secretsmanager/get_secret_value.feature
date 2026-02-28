@secretsmanager @get_secret_value @dataplane
Feature: SecretsManager GetSecretValue

  @happy
  Scenario: Get the value of an existing secret
    Given a secret "e2e-get-sv" was created with value "my-secret"
    When I get secret value for "e2e-get-sv"
    Then the command will succeed
    And the output will contain secret value "my-secret"
