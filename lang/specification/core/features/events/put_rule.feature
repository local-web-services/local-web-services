@events @put_rule @controlplane
Feature: Events PutRule

  @happy
  Scenario: Put a new rule on the default bus
    When I put rule "e2e-put-rule" on event bus "default"
    Then the command will succeed
    And rule "e2e-put-rule" will appear in list-rules on event bus "default"
