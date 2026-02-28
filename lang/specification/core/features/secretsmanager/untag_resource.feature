@secretsmanager @untag_resource @controlplane
Feature: SecretsManager UntagResource

  @happy
  Scenario: Untag an existing secret
    Given a secret "e2e-untag-resource" was created with value "val"
    And tags [{"Key": "env", "Value": "test"}] were added to secret "e2e-untag-resource"
    When I untag secret "e2e-untag-resource" with tag keys ["env"]
    Then the command will succeed
    And secret "e2e-untag-resource" will not have tag "env"
