@events @generated
Feature: events - All Rules On An "Eventbridge" "Bus" Are Listed

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @minimal @happy @list_rules
  Scenario: all rules on an "eventbridge" "bus" are listed
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    When all rules on an "eventbridge" "bus" are listed
    Then the list of rules will be returned
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @guard @negative @list_rules
  Scenario: all rules on an "eventbridge" "bus" are listed fails when the "eventbridge" "bus" did not exist
    Given the "eventbridge" "bus" did not exist
    When all rules on an "eventbridge" "bus" are listed
    Then the operation is rejected

  @guard @negative @list_rules
  Scenario: all rules on an "eventbridge" "bus" are listed fails when the "eventbridge" "bus" was not "ACTIVE"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was not "ACTIVE"
    When all rules on an "eventbridge" "bus" are listed
    Then the operation is rejected
