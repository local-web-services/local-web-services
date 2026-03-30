@events @generated
Feature: Events - An Event Bus Is Deleted

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @minimal @happy @delete_event_bus
  Scenario: an event bus is deleted
    Given the event bus is not the default bus
    And the event bus exists
    And the event bus is "ACTIVE"
    And the event bus has no rules
    When an event bus is deleted
    Then the event bus is "DELETED"
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @guard @negative @delete_event_bus
  Scenario: an event bus is deleted fails when the event bus is the default bus
    Given the event bus is the default bus
    When an event bus is deleted
    Then the operation is rejected

  @guard @negative @delete_event_bus
  Scenario: an event bus is deleted fails when the event bus does not exist
    Given the event bus is not the default bus
    And the event bus does not exist
    When an event bus is deleted
    Then the operation is rejected

  @guard @negative @delete_event_bus @lifecycle
  Scenario: an event bus is deleted fails when the event bus is not "ACTIVE"
    Given the event bus is not the default bus
    And the event bus exists
    And the event bus is not "ACTIVE"
    When an event bus is deleted
    Then the operation is rejected

  @guard @negative @delete_event_bus
  Scenario: an event bus is deleted fails when the event bus has rules
    Given the event bus is not the default bus
    And the event bus exists
    And the event bus is "ACTIVE"
    And the event bus has rules
    When an event bus is deleted
    Then the operation is rejected
