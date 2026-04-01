@events @generated
Feature: events - An "Eventbridge" "Rule" Is Deleted

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @minimal @happy @delete_rule
  Scenario: an "eventbridge" "rule" is deleted
    Given the "eventbridge" "rule" existed
    And the "eventbridge" "rule" is not already "DELETED"
    And the "eventbridge" "rule" has no active targets
    When an "eventbridge" "rule" is deleted
    Then the "eventbridge" "rule" will be "DELETED"
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @guard @negative @delete_rule
  Scenario: an "eventbridge" "rule" is deleted fails when the "eventbridge" "rule" did not exist
    Given the "eventbridge" "rule" did not exist
    When an "eventbridge" "rule" is deleted
    Then the operation is rejected

  @guard @negative @delete_rule
  Scenario: an "eventbridge" "rule" is deleted fails when the "eventbridge" "rule" is already "DELETED"
    Given the "eventbridge" "rule" existed
    And the "eventbridge" "rule" is already "DELETED"
    When an "eventbridge" "rule" is deleted
    Then the operation is rejected

  @guard @negative @delete_rule
  Scenario: an "eventbridge" "rule" is deleted fails when the "eventbridge" "rule" has active targets
    Given the "eventbridge" "rule" existed
    And the "eventbridge" "rule" is not already "DELETED"
    And the "eventbridge" "rule" has active targets
    When an "eventbridge" "rule" is deleted
    Then the operation is rejected
