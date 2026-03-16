@events @generated
Feature: Events - All Rules On An Event Bus Are Listed

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @minimal @happy @list_rules
  Scenario: all rules on an event bus are listed
    Given the event bus exists
    And the event bus is "ACTIVE"
    When all rules on an event bus are listed
    Then the list of rules is returned
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @standard @negative @list_rules
  Scenario: all rules on an event bus are listed fails when the event bus does not exist
    Given the event bus does not exist
    When all rules on an event bus are listed
    Then the operation is rejected

  @standard @negative @list_rules
  Scenario: all rules on an event bus are listed fails when the event bus is not "ACTIVE"
    Given the event bus exists
    And the event bus is not "ACTIVE"
    When all rules on an event bus are listed
    Then the operation is rejected
