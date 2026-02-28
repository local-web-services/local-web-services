@secretsmanager @create_secret @controlplane
Feature: SecretsManager CreateSecret

  @happy
  Scenario: Create a new secret with a string value
    When I create secret "e2e-create-secret" with value "s3cret"
    Then the command will succeed
    And the output will contain secret name "e2e-create-secret"
    And secret "e2e-create-secret" will have value "s3cret"

  @happy
  Scenario: Create a secret with a description
    When I create secret "e2e-create-secret-desc" with value "val" and description "A test secret"
    Then the command will succeed
    And secret "e2e-create-secret-desc" will appear in describe-secret
