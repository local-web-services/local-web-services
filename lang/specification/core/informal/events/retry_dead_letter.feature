@events @generated
Feature: Events - A Dead-Letter "Eventbridge" "Dead-Letter Queue" Entry Is Retried Or Discarded

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @minimal @happy @retry_dead_letter @internal
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given the "eventbridge" "dead-letter queue" was not empty
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Then the entry will be removed from the "eventbridge" "dead-letter queue"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @guard @negative @retry_dead_letter @internal
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded fails when the "eventbridge" "dead-letter queue" was empty
    Given the "eventbridge" "dead-letter queue" was empty
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Then the operation is rejected
