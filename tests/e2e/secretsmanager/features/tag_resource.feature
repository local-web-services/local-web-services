@secretsmanager @tag_resource @controlplane
Feature: SecretsManager TagResource

  @happy
  Scenario: Tag an existing secret
    Given a secret "e2e-tag-resource" was created with value "val"
    When I tag secret "e2e-tag-resource" with tags [{"Key": "env", "Value": "test"}]
    Then the command will succeed
