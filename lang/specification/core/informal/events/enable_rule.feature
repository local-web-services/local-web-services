@events @generated
Feature: Events - A Rule Is Enabled

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @minimal @happy @enable_rule
  Scenario: a rule is enabled
    Given the rule exists
    And the rule is "DISABLED"
    When a rule is enabled
    Then the rule is "ENABLED"
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @standard @negative @enable_rule
  Scenario: a rule is enabled fails when the rule does not exist
    Given the rule does not exist
    When a rule is enabled
    Then the operation is rejected

  @standard @negative @enable_rule
  Scenario: a rule is enabled fails when the rule is not "DISABLED"
    Given the rule exists
    And the rule is not "DISABLED"
    When a rule is enabled
    Then the operation is rejected
