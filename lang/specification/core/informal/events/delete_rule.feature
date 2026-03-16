@events @generated
Feature: Events - An Eventbridge Rule Is Deleted

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @minimal @happy @delete_rule
  Scenario: an EventBridge rule is deleted
    Given the rule exists
    And the rule is not already "DELETED"
    And the rule has no active targets
    When an EventBridge rule is deleted
    Then the rule is "DELETED"
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @standard @negative @delete_rule
  Scenario: an EventBridge rule is deleted fails when the rule does not exist
    Given the rule does not exist
    When an EventBridge rule is deleted
    Then the operation is rejected

  @standard @negative @delete_rule
  Scenario: an EventBridge rule is deleted fails when the rule is already "DELETED"
    Given the rule exists
    And the rule is already "DELETED"
    When an EventBridge rule is deleted
    Then the operation is rejected

  @standard @negative @delete_rule
  Scenario: an EventBridge rule is deleted fails when the rule has active targets
    Given the rule exists
    And the rule is not already "DELETED"
    And the rule has active targets
    When an EventBridge rule is deleted
    Then the operation is rejected
