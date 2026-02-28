@events @list_targets_by_rule @controlplane
Feature: Events ListTargetsByRule

  @happy
  Scenario: List targets for an existing rule
    Given a rule "e2e-list-targets-rule" was created on event bus "default"
    When I list targets by rule "e2e-list-targets-rule" on event bus "default"
    Then the command will succeed
