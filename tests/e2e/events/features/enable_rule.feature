@events @enable_rule @controlplane
Feature: Events EnableRule

  @happy
  Scenario: Enable an existing rule
    Given a rule "e2e-enable-rule" was created on event bus "default"
    When I enable rule "e2e-enable-rule" on event bus "default"
    Then the command will succeed
