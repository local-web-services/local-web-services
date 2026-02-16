@events @describe_rule @controlplane
Feature: Events DescribeRule

  @happy
  Scenario: Describe an existing rule
    Given a rule "e2e-desc-rule" was created on event bus "default"
    When I describe rule "e2e-desc-rule" on event bus "default"
    Then the command will succeed
