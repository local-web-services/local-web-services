@events @delete_rule @controlplane
Feature: Events DeleteRule

  @happy
  Scenario: Delete an existing rule
    Given a rule "e2e-del-rule" was created on event bus "default"
    When I delete rule "e2e-del-rule"
    Then the command will succeed
    And rule "e2e-del-rule" will not appear in list-rules on event bus "default"
