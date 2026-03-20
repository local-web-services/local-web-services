@events @generated
Feature: Events - Events Are Published To An Event Bus

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @minimal @happy @put_events
  Scenario: events are published to an event bus
    Given the event bus exists
    And the event bus is "ACTIVE"
    And a rule is associated with the event bus
    And the rule's event bus matches
    And the rule is "ENABLED"
    And a target is associated with the rule
    And the target association is active
    When events are published to an event bus
    Then matching enabled rules route the event to their targets
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @standard @negative @put_events
  Scenario: events are published to an event bus fails when the event bus does not exist
    Given the event bus does not exist
    When events are published to an event bus
    Then the operation is rejected

  @standard @negative @put_events
  Scenario: events are published to an event bus fails when the event bus is not "ACTIVE"
    Given the event bus exists
    And the event bus is not "ACTIVE"
    When events are published to an event bus
    Then the operation is rejected

  @standard @negative @put_events
  Scenario: events are published to an event bus fails when no rule is associated with the event bus
    Given the event bus exists
    And the event bus is "ACTIVE"
    And no rule is associated with the event bus
    When events are published to an event bus
    Then the operation is rejected

  @standard @negative @put_events
  Scenario: events are published to an event bus fails when the rule's event bus does not match
    Given the event bus exists
    And the event bus is "ACTIVE"
    And a rule is associated with the event bus
    And the rule's event bus does not match
    When events are published to an event bus
    Then the operation is rejected

  @standard @negative @put_events
  Scenario: events are published to an event bus fails when the rule is not "ENABLED"
    Given the event bus exists
    And the event bus is "ACTIVE"
    And a rule is associated with the event bus
    And the rule's event bus matches
    And the rule is not "ENABLED"
    When events are published to an event bus
    Then the operation is rejected

  @standard @negative @put_events
  Scenario: events are published to an event bus fails when no target is associated with the rule
    Given the event bus exists
    And the event bus is "ACTIVE"
    And a rule is associated with the event bus
    And the rule's event bus matches
    And the rule is "ENABLED"
    And no target is associated with the rule
    When events are published to an event bus
    Then the operation is rejected

  @standard @negative @put_events
  Scenario: events are published to an event bus fails when the target association is not active
    Given the event bus exists
    And the event bus is "ACTIVE"
    And a rule is associated with the event bus
    And the rule's event bus matches
    And the rule is "ENABLED"
    And a target is associated with the rule
    And the target association is not active
    When events are published to an event bus
    Then the operation is rejected
