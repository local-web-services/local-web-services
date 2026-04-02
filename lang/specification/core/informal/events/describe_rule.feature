@events @generated
Feature: Events - An "Eventbridge" "Rule" Is Described

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @minimal @happy @describe_rule
  Scenario: an "eventbridge" "rule" is described
    Given the "eventbridge" "rule" existed
    And the "eventbridge" "rule" was not "DELETED"
    When an "eventbridge" "rule" is described
    Then the "eventbridge" "rule" details will be returned
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @guard @negative @describe_rule
  Scenario: an "eventbridge" "rule" is described fails when the "eventbridge" "rule" did not exist
    Given the "eventbridge" "rule" did not exist
    When an "eventbridge" "rule" is described
    Then the operation is rejected

  @guard @negative @describe_rule
  Scenario: an "eventbridge" "rule" is described fails when the "eventbridge" "rule" was "DELETED"
    Given the "eventbridge" "rule" existed
    And the "eventbridge" "rule" was "DELETED"
    When an "eventbridge" "rule" is described
    Then the operation is rejected
