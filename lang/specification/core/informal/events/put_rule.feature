@events @generated
Feature: Events - An Eventbridge Rule Is Created

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @minimal @happy @put_rule
  Scenario: an EventBridge rule is created
    Given the rule does not already exist
    And the event bus exists
    And the event bus is "ACTIVE"
    When an EventBridge rule is created
    Then the rule is "ENABLED"
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @guard @negative @put_rule
  Scenario: an EventBridge rule is created fails when the rule already exists
    Given the rule already exists
    When an EventBridge rule is created
    Then the operation is rejected

  @guard @negative @put_rule
  Scenario: an EventBridge rule is created fails when the event bus does not exist
    Given the rule does not already exist
    And the event bus does not exist
    When an EventBridge rule is created
    Then the operation is rejected

  @guard @negative @put_rule
  Scenario: an EventBridge rule is created fails when the event bus is not "ACTIVE"
    Given the rule does not already exist
    And the event bus exists
    And the event bus is not "ACTIVE"
    When an EventBridge rule is created
    Then the operation is rejected
