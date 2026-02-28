@events @list_rules @controlplane
Feature: Events ListRules

  @happy
  Scenario: List rules on the default bus
    When I list rules on event bus "default"
    Then the command will succeed
    And the output will contain a Rules key
