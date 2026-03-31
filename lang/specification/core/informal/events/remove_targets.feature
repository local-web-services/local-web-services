@events @generated
Feature: events - Targets Are Removed From An "Eventbridge" "Rule"

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @minimal @happy @remove_targets
  Scenario: targets are removed from an "eventbridge" "rule"
    Given the "eventbridge" "rule" existed
    And the "eventbridge" "rule" was not "DELETED"
    And the target is associated with the "eventbridge" "rule"
    And the target association was "ACTIVE"
    When targets are removed from an "eventbridge" "rule"
    Then the targets are disassociated from the "eventbridge" "rule"
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @guard @negative @remove_targets
  Scenario: targets are removed from an "eventbridge" "rule" fails when the "eventbridge" "rule" did not exist
    Given the "eventbridge" "rule" did not exist
    When targets are removed from an "eventbridge" "rule"
    Then the operation is rejected

  @guard @negative @remove_targets
  Scenario: targets are removed from an "eventbridge" "rule" fails when the "eventbridge" "rule" was "DELETED"
    Given the "eventbridge" "rule" existed
    And the "eventbridge" "rule" was "DELETED"
    When targets are removed from an "eventbridge" "rule"
    Then the operation is rejected

  @guard @negative @remove_targets
  Scenario: targets are removed from an "eventbridge" "rule" fails when the target is not associated with the "eventbridge" "rule"
    Given the "eventbridge" "rule" existed
    And the "eventbridge" "rule" was not "DELETED"
    And the target is not associated with the "eventbridge" "rule"
    When targets are removed from an "eventbridge" "rule"
    Then the operation is rejected

  @guard @negative @remove_targets
  Scenario: targets are removed from an "eventbridge" "rule" fails when the target association was not "ACTIVE"
    Given the "eventbridge" "rule" existed
    And the "eventbridge" "rule" was not "DELETED"
    And the target is associated with the "eventbridge" "rule"
    And the target association was not "ACTIVE"
    When targets are removed from an "eventbridge" "rule"
    Then the operation is rejected
