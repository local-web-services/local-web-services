@events @generated
Feature: Events - Targets Are Added To A Rule

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @minimal @happy @put_targets
  Scenario: targets are added to a rule
    Given the rule exists
    And the rule is not "DELETED"
    When targets are added to a rule
    Then the targets are associated with the rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @guard @negative @put_targets
  Scenario: targets are added to a rule fails when the rule does not exist
    Given the rule does not exist
    When targets are added to a rule
    Then the operation is rejected

  @guard @negative @put_targets
  Scenario: targets are added to a rule fails when the rule is "DELETED"
    Given the rule exists
    And the rule is "DELETED"
    When targets are added to a rule
    Then the operation is rejected
