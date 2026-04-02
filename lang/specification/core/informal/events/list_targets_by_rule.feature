@events @generated
Feature: Events - Targets For An "Eventbridge" "Rule" Are Listed

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @minimal @happy @list_targets_by_rule
  Scenario: targets for an "eventbridge" "rule" are listed
    Given the "eventbridge" "rule" existed
    And the "eventbridge" "rule" was not "DELETED"
    When targets for an "eventbridge" "rule" are listed
    Then the list of "eventbridge" "rule" targets will be returned
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @guard @negative @list_targets_by_rule
  Scenario: targets for an "eventbridge" "rule" are listed fails when the "eventbridge" "rule" did not exist
    Given the "eventbridge" "rule" did not exist
    When targets for an "eventbridge" "rule" are listed
    Then the operation is rejected

  @guard @negative @list_targets_by_rule
  Scenario: targets for an "eventbridge" "rule" are listed fails when the "eventbridge" "rule" was "DELETED"
    Given the "eventbridge" "rule" existed
    And the "eventbridge" "rule" was "DELETED"
    When targets for an "eventbridge" "rule" are listed
    Then the operation is rejected
