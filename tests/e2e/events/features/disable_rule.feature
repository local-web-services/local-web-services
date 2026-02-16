@events @disable_rule @controlplane
Feature: Events DisableRule

  @happy
  Scenario: Disable an existing rule
    Given a rule "e2e-disable-rule" was created on event bus "default"
    When I disable rule "e2e-disable-rule" on event bus "default"
    Then the command will succeed
