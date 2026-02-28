@secretsmanager @describe_secret @controlplane
Feature: SecretsManager DescribeSecret

  @happy
  Scenario: Describe an existing secret
    Given a secret "e2e-desc-secret" was created with value "val"
    When I describe secret "e2e-desc-secret"
    Then the command will succeed
    And the output will contain secret name "e2e-desc-secret"
