@events @generated
Feature: Events - Targets Are Removed From A Rule

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @minimal @happy @remove_targets
  Scenario: targets are removed from a rule
    Given the rule exists
    And the rule is not "DELETED"
    And the target is associated with the rule
    And the target association is active
    When targets are removed from a rule
    Then the targets are disassociated from the rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @standard @negative @remove_targets
  Scenario: targets are removed from a rule fails when the rule does not exist
    Given the rule does not exist
    When targets are removed from a rule
    Then the operation is rejected

  @standard @negative @remove_targets
  Scenario: targets are removed from a rule fails when the rule is "DELETED"
    Given the rule exists
    And the rule is "DELETED"
    When targets are removed from a rule
    Then the operation is rejected

  @standard @negative @remove_targets
  Scenario: targets are removed from a rule fails when the target is not associated with the rule
    Given the rule exists
    And the rule is not "DELETED"
    And the target is not associated with the rule
    When targets are removed from a rule
    Then the operation is rejected

  @standard @negative @remove_targets @internal
  Scenario: targets are removed from a rule fails when the target association is not active
    Given the rule exists
    And the rule is not "DELETED"
    And the target is associated with the rule
    And the target association is not active
    When targets are removed from a rule
    Then the operation is rejected
