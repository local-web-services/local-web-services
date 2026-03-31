@events @generated
Feature: events - An "Eventbridge" "Rule" Was "Enabled"

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @minimal @happy @enable_rule
  Scenario: an "eventbridge" "rule" was "ENABLED"
    Given the "eventbridge" "rule" existed
    And the "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "rule" was "ENABLED"
    Then the "eventbridge" "rule" will be "ENABLED"
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @guard @negative @enable_rule
  Scenario: an "eventbridge" "rule" was "ENABLED" fails when the "eventbridge" "rule" did not exist
    Given the "eventbridge" "rule" did not exist
    When an "eventbridge" "rule" was "ENABLED"
    Then the operation is rejected

  @guard @negative @enable_rule
  Scenario: an "eventbridge" "rule" was "ENABLED" fails when the "eventbridge" "rule" was not "DISABLED"
    Given the "eventbridge" "rule" existed
    And the "eventbridge" "rule" was not "DISABLED"
    When an "eventbridge" "rule" was "ENABLED"
    Then the operation is rejected
