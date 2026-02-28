@events @put_targets @controlplane
Feature: Events PutTargets

  @happy
  Scenario: Put targets on an existing rule
    Given a rule "e2e-put-targets-rule" was created on event bus "default"
    When I put targets on rule "e2e-put-targets-rule" on event bus "default"
    Then the command will succeed
    And rule "e2e-put-targets-rule" will have a target in list-targets-by-rule
