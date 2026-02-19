@events @remove_targets @controlplane
Feature: Events RemoveTargets

  @happy
  Scenario: Remove targets from an existing rule
    Given a rule "e2e-rm-targets-rule" was created on event bus "default"
    And targets were added to rule "e2e-rm-targets-rule" on event bus "default"
    When I remove targets from rule "e2e-rm-targets-rule" on event bus "default"
    Then the command will succeed
    And rule "e2e-rm-targets-rule" will have no targets
