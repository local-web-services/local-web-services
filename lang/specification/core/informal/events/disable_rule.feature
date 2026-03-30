@events @generated
Feature: Events - A Rule Is Disabled

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @minimal @happy @disable_rule
  Scenario: a rule is disabled
    Given the rule exists
    And the rule is "ENABLED"
    When a rule is disabled
    Then the rule is "DISABLED"
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @guard @negative @disable_rule
  Scenario: a rule is disabled fails when the rule does not exist
    Given the rule does not exist
    When a rule is disabled
    Then the operation is rejected

  @guard @negative @disable_rule
  Scenario: a rule is disabled fails when the rule is not "ENABLED"
    Given the rule exists
    And the rule is not "ENABLED"
    When a rule is disabled
    Then the operation is rejected
