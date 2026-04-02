@events @generated
Feature: Events - An "Eventbridge" "Bus" Is Deleted

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @minimal @happy @delete_event_bus
  Scenario: an "eventbridge" "bus" is deleted
    Given the "eventbridge" "bus" is not the default eventbridge bus
    And the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And the "eventbridge" "bus" has no rules
    When an "eventbridge" "bus" is deleted
    Then the "eventbridge" "bus" will be deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @guard @negative @delete_event_bus
  Scenario: an "eventbridge" "bus" is deleted fails when the "eventbridge" "bus" is the default eventbridge bus
    Given the "eventbridge" "bus" is the default eventbridge bus
    When an "eventbridge" "bus" is deleted
    Then the operation is rejected

  @guard @negative @delete_event_bus
  Scenario: an "eventbridge" "bus" is deleted fails when the "eventbridge" "bus" did not exist
    Given the "eventbridge" "bus" is not the default eventbridge bus
    And the "eventbridge" "bus" did not exist
    When an "eventbridge" "bus" is deleted
    Then the operation is rejected

  @guard @negative @delete_event_bus @lifecycle
  Scenario: an "eventbridge" "bus" is deleted fails when the "eventbridge" "bus" was not "ACTIVE"
    Given the "eventbridge" "bus" is not the default eventbridge bus
    And the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was not "ACTIVE"
    When an "eventbridge" "bus" is deleted
    Then the operation is rejected

  @guard @negative @delete_event_bus
  Scenario: an "eventbridge" "bus" is deleted fails when the "eventbridge" "bus" has rules
    Given the "eventbridge" "bus" is not the default eventbridge bus
    And the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And the "eventbridge" "bus" has rules
    When an "eventbridge" "bus" is deleted
    Then the operation is rejected
