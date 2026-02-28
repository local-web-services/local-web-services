@secretsmanager @get_resource_policy @controlplane
Feature: SecretsManager GetResourcePolicy

  @happy
  Scenario: Get resource policy for an existing secret
    Given a secret "e2e-get-resource-policy" was created with value "val"
    When I get resource policy for "e2e-get-resource-policy"
    Then the command will succeed
