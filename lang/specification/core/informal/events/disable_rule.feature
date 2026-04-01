@events @generated
Feature: Events - An "Eventbridge" "Rule" Was "Disabled"

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @minimal @happy @disable_rule
  Scenario: an "eventbridge" "rule" was "DISABLED"
    Given the "eventbridge" "rule" existed
    And the "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "rule" was "DISABLED"
    Then the "eventbridge" "rule" will be "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @guard @negative @disable_rule
  Scenario: an "eventbridge" "rule" was "DISABLED" fails when the "eventbridge" "rule" did not exist
    Given the "eventbridge" "rule" did not exist
    When an "eventbridge" "rule" was "DISABLED"
    Then the operation is rejected

  @guard @negative @disable_rule
  Scenario: an "eventbridge" "rule" was "DISABLED" fails when the "eventbridge" "rule" was not "ENABLED"
    Given the "eventbridge" "rule" existed
    And the "eventbridge" "rule" was not "ENABLED"
    When an "eventbridge" "rule" was "DISABLED"
    Then the operation is rejected
