@events @generated
Feature: events - Events Are Published To An "Eventbridge" "Bus"

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @minimal @happy @put_events
  Scenario: events are published to an "eventbridge" "bus"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And an "eventbridge" "rule" is associated with the "eventbridge" "bus"
    And the "eventbridge" "rule"'s event eventbridge bus matches
    And the "eventbridge" "rule" was "ENABLED"
    And a target is associated with the "eventbridge" "rule"
    And the target association was "ACTIVE"
    When events are published to an "eventbridge" "bus"
    Then matching enabled rules route the event to their targets
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @guard @negative @put_events
  Scenario: events are published to an "eventbridge" "bus" fails when the "eventbridge" "bus" did not exist
    Given the "eventbridge" "bus" did not exist
    When events are published to an "eventbridge" "bus"
    Then the operation is rejected

  @guard @negative @put_events
  Scenario: events are published to an "eventbridge" "bus" fails when the "eventbridge" "bus" was not "ACTIVE"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was not "ACTIVE"
    When events are published to an "eventbridge" "bus"
    Then the operation is rejected

  @guard @negative @put_events
  Scenario: events are published to an "eventbridge" "bus" fails when no eventbridge rule is associated with the "eventbridge" "bus"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And no eventbridge rule is associated with the "eventbridge" "bus"
    When events are published to an "eventbridge" "bus"
    Then the operation is rejected

  @guard @negative @put_events
  Scenario: events are published to an "eventbridge" "bus" fails when the "eventbridge" "rule"'s event eventbridge bus does not match
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And an "eventbridge" "rule" is associated with the "eventbridge" "bus"
    And the "eventbridge" "rule"'s event eventbridge bus does not match
    When events are published to an "eventbridge" "bus"
    Then the operation is rejected

  @guard @negative @put_events
  Scenario: events are published to an "eventbridge" "bus" fails when the "eventbridge" "rule" was not "ENABLED"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And an "eventbridge" "rule" is associated with the "eventbridge" "bus"
    And the "eventbridge" "rule"'s event eventbridge bus matches
    And the "eventbridge" "rule" was not "ENABLED"
    When events are published to an "eventbridge" "bus"
    Then the operation is rejected

  @guard @negative @put_events
  Scenario: events are published to an "eventbridge" "bus" fails when no target is associated with the "eventbridge" "rule"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And an "eventbridge" "rule" is associated with the "eventbridge" "bus"
    And the "eventbridge" "rule"'s event eventbridge bus matches
    And the "eventbridge" "rule" was "ENABLED"
    And no target is associated with the "eventbridge" "rule"
    When events are published to an "eventbridge" "bus"
    Then the operation is rejected

  @guard @negative @put_events
  Scenario: events are published to an "eventbridge" "bus" fails when the target association was not "ACTIVE"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And an "eventbridge" "rule" is associated with the "eventbridge" "bus"
    And the "eventbridge" "rule"'s event eventbridge bus matches
    And the "eventbridge" "rule" was "ENABLED"
    And a target is associated with the "eventbridge" "rule"
    And the target association was not "ACTIVE"
    When events are published to an "eventbridge" "bus"
    Then the operation is rejected
