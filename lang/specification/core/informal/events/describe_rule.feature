@events @generated
Feature: Events - An Eventbridge Rule Is Described

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @minimal @happy @describe_rule
  Scenario: an EventBridge rule is described
    Given the rule exists
    And the rule is not "DELETED"
    When an EventBridge rule is described
    Then the rule details are returned
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @guard @negative @describe_rule
  Scenario: an EventBridge rule is described fails when the rule does not exist
    Given the rule does not exist
    When an EventBridge rule is described
    Then the operation is rejected

  @guard @negative @describe_rule
  Scenario: an EventBridge rule is described fails when the rule is "DELETED"
    Given the rule exists
    And the rule is "DELETED"
    When an EventBridge rule is described
    Then the operation is rejected
