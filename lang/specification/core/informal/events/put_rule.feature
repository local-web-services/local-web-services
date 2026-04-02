@events @generated
Feature: Events - An "Eventbridge" "Rule" Is Created

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @minimal @happy @put_rule
  Scenario: an "eventbridge" "rule" is created
    Given the "eventbridge" "rule" did not already exist
    And the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    When an "eventbridge" "rule" is created
    Then the "eventbridge" "rule" will be "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @guard @negative @put_rule
  Scenario: an "eventbridge" "rule" is created fails when the "eventbridge" "rule" already existed
    Given the "eventbridge" "rule" already existed
    When an "eventbridge" "rule" is created
    Then the operation is rejected

  @guard @negative @put_rule
  Scenario: an "eventbridge" "rule" is created fails when the "eventbridge" "bus" did not exist
    Given the "eventbridge" "rule" did not already exist
    And the "eventbridge" "bus" did not exist
    When an "eventbridge" "rule" is created
    Then the operation is rejected

  @guard @negative @put_rule
  Scenario: an "eventbridge" "rule" is created fails when the "eventbridge" "bus" was not "ACTIVE"
    Given the "eventbridge" "rule" did not already exist
    And the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was not "ACTIVE"
    When an "eventbridge" "rule" is created
    Then the operation is rejected
