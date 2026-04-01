@events @generated
Feature: Events - Action Sequences

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "bus" is deleted
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "bus" is described
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then all "eventbridge" "bus"es are listed
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "rule" is created
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "rule" is deleted
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "rule" is described
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then all rules on an "eventbridge" "bus" are listed
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "rule" was "ENABLED"
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "rule" was "DISABLED"
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then targets are added to an "eventbridge" "rule"
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then targets are removed from an "eventbridge" "rule"
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then targets for an "eventbridge" "rule" are listed
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then events are published to an "eventbridge" "bus"
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then an "eventbridge" "bus" is described
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then all "eventbridge" "bus"es are listed
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then an "eventbridge" "rule" is created
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then an "eventbridge" "rule" is deleted
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then an "eventbridge" "rule" is described
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then all rules on an "eventbridge" "bus" are listed
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then an "eventbridge" "rule" was "ENABLED"
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then an "eventbridge" "rule" was "DISABLED"
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then targets are added to an "eventbridge" "rule"
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then targets are removed from an "eventbridge" "rule"
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then targets for an "eventbridge" "rule" are listed
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then events are published to an "eventbridge" "bus"
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then an "eventbridge" "bus" is created
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then an "eventbridge" "bus" is deleted
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then all "eventbridge" "bus"es are listed
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then an "eventbridge" "rule" is created
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then an "eventbridge" "rule" is deleted
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then an "eventbridge" "rule" is described
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then all rules on an "eventbridge" "bus" are listed
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then an "eventbridge" "rule" was "ENABLED"
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then an "eventbridge" "rule" was "DISABLED"
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then targets are added to an "eventbridge" "rule"
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then targets are removed from an "eventbridge" "rule"
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then targets for an "eventbridge" "rule" are listed
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then events are published to an "eventbridge" "bus"
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then an "eventbridge" "bus" is created
    When all "eventbridge" "bus"es are listed
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then an "eventbridge" "bus" is deleted
    When all "eventbridge" "bus"es are listed
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then an "eventbridge" "bus" is described
    When all "eventbridge" "bus"es are listed
    Given name in bus_status
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then an "eventbridge" "rule" is created
    When all "eventbridge" "bus"es are listed
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then an "eventbridge" "rule" is deleted
    When all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then an "eventbridge" "rule" is described
    When all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then all rules on an "eventbridge" "bus" are listed
    When all "eventbridge" "bus"es are listed
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then an "eventbridge" "rule" was "ENABLED"
    When all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then an "eventbridge" "rule" was "DISABLED"
    When all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then targets are added to an "eventbridge" "rule"
    When all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then targets are removed from an "eventbridge" "rule"
    When all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then targets for an "eventbridge" "rule" are listed
    When all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then events are published to an "eventbridge" "bus"
    When all "eventbridge" "bus"es are listed
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When all "eventbridge" "bus"es are listed
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then an "eventbridge" "bus" is created
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then an "eventbridge" "bus" is deleted
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then an "eventbridge" "bus" is described
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then all "eventbridge" "bus"es are listed
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then an "eventbridge" "rule" is deleted
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then an "eventbridge" "rule" is described
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then all rules on an "eventbridge" "bus" are listed
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then an "eventbridge" "rule" was "ENABLED"
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then an "eventbridge" "rule" was "DISABLED"
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then targets are added to an "eventbridge" "rule"
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then targets are removed from an "eventbridge" "rule"
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then targets for an "eventbridge" "rule" are listed
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then events are published to an "eventbridge" "bus"
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then an "eventbridge" "bus" is created
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then an "eventbridge" "bus" is deleted
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then an "eventbridge" "bus" is described
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then an "eventbridge" "rule" is created
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then an "eventbridge" "rule" is described
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then all rules on an "eventbridge" "bus" are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then an "eventbridge" "rule" was "ENABLED"
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then an "eventbridge" "rule" was "DISABLED"
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then targets are added to an "eventbridge" "rule"
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then targets are removed from an "eventbridge" "rule"
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then targets for an "eventbridge" "rule" are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then events are published to an "eventbridge" "bus"
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then an "eventbridge" "bus" is created
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then an "eventbridge" "bus" is deleted
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then an "eventbridge" "bus" is described
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then an "eventbridge" "rule" is created
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then an "eventbridge" "rule" is deleted
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then all rules on an "eventbridge" "bus" are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then an "eventbridge" "rule" was "ENABLED"
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then an "eventbridge" "rule" was "DISABLED"
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then targets are added to an "eventbridge" "rule"
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then targets are removed from an "eventbridge" "rule"
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then targets for an "eventbridge" "rule" are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then events are published to an "eventbridge" "bus"
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then an "eventbridge" "bus" is created
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then an "eventbridge" "bus" is deleted
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then an "eventbridge" "bus" is described
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then all "eventbridge" "bus"es are listed
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then an "eventbridge" "rule" is created
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then an "eventbridge" "rule" is deleted
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then an "eventbridge" "rule" is described
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then an "eventbridge" "rule" was "ENABLED"
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then an "eventbridge" "rule" was "DISABLED"
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then targets are added to an "eventbridge" "rule"
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then targets are removed from an "eventbridge" "rule"
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then targets for an "eventbridge" "rule" are listed
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then events are published to an "eventbridge" "bus"
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "bus" is created
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "bus" is deleted
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "bus" is described
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "rule" is created
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "rule" is deleted
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "rule" is described
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then all rules on an "eventbridge" "bus" are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "rule" was "DISABLED"
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then targets are added to an "eventbridge" "rule"
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then targets are removed from an "eventbridge" "rule"
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then targets for an "eventbridge" "rule" are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then events are published to an "eventbridge" "bus"
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an "eventbridge" "bus" is created
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an "eventbridge" "bus" is deleted
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an "eventbridge" "bus" is described
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an "eventbridge" "rule" is created
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an "eventbridge" "rule" is deleted
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an "eventbridge" "rule" is described
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then all rules on an "eventbridge" "bus" are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an "eventbridge" "rule" was "ENABLED"
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then targets are added to an "eventbridge" "rule"
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then targets are removed from an "eventbridge" "rule"
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then targets for an "eventbridge" "rule" are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then events are published to an "eventbridge" "bus"
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then an "eventbridge" "bus" is created
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then an "eventbridge" "bus" is deleted
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then an "eventbridge" "bus" is described
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then an "eventbridge" "rule" is created
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then an "eventbridge" "rule" is deleted
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then an "eventbridge" "rule" is described
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then all rules on an "eventbridge" "bus" are listed
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then an "eventbridge" "rule" was "ENABLED"
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then an "eventbridge" "rule" was "DISABLED"
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then targets are removed from an "eventbridge" "rule"
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then targets for an "eventbridge" "rule" are listed
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then events are published to an "eventbridge" "bus"
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then an "eventbridge" "bus" is created
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then an "eventbridge" "bus" is deleted
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then an "eventbridge" "bus" is described
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then an "eventbridge" "rule" is created
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then an "eventbridge" "rule" is deleted
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then an "eventbridge" "rule" is described
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then all rules on an "eventbridge" "bus" are listed
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then an "eventbridge" "rule" was "ENABLED"
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then an "eventbridge" "rule" was "DISABLED"
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then targets are added to an "eventbridge" "rule"
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then targets for an "eventbridge" "rule" are listed
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then events are published to an "eventbridge" "bus"
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then an "eventbridge" "bus" is created
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then an "eventbridge" "bus" is deleted
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then an "eventbridge" "bus" is described
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then an "eventbridge" "rule" is created
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then an "eventbridge" "rule" is deleted
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then an "eventbridge" "rule" is described
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then all rules on an "eventbridge" "bus" are listed
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then an "eventbridge" "rule" was "ENABLED"
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then an "eventbridge" "rule" was "DISABLED"
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then targets are added to an "eventbridge" "rule"
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then targets are removed from an "eventbridge" "rule"
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then events are published to an "eventbridge" "bus"
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then an "eventbridge" "bus" is created
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then an "eventbridge" "bus" is deleted
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then an "eventbridge" "bus" is described
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then all "eventbridge" "bus"es are listed
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then an "eventbridge" "rule" is created
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then an "eventbridge" "rule" is deleted
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then an "eventbridge" "rule" is described
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then all rules on an "eventbridge" "bus" are listed
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then an "eventbridge" "rule" was "ENABLED"
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then an "eventbridge" "rule" was "DISABLED"
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then targets are added to an "eventbridge" "rule"
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then targets are removed from an "eventbridge" "rule"
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then targets for an "eventbridge" "rule" are listed
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "bus" is created
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "bus" is deleted
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "bus" is described
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then all "eventbridge" "bus"es are listed
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "rule" is created
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "rule" is deleted
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "rule" is described
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then all rules on an "eventbridge" "bus" are listed
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "rule" was "ENABLED"
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "rule" was "DISABLED"
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then targets are added to an "eventbridge" "rule"
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then targets are removed from an "eventbridge" "rule"
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then targets for an "eventbridge" "rule" are listed
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then events are published to an "eventbridge" "bus"
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "bus" is deleted then an "eventbridge" "bus" is described
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "bus" is described then all "eventbridge" "bus"es are listed
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "bus" is described
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then all "eventbridge" "bus"es are listed then an "eventbridge" "rule" is created
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When all "eventbridge" "bus"es are listed
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "rule" is created then an "eventbridge" "rule" is deleted
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" is created
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "rule" is deleted then an "eventbridge" "rule" is described
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" is deleted
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "rule" is described then all rules on an "eventbridge" "bus" are listed
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" is described
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then all rules on an "eventbridge" "bus" are listed then an "eventbridge" "rule" was "ENABLED"
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "rule" was "DISABLED"
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "rule" was "DISABLED" then targets are added to an "eventbridge" "rule"
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" was "DISABLED"
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then targets are added to an "eventbridge" "rule" then targets are removed from an "eventbridge" "rule"
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When targets are added to an "eventbridge" "rule"
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then targets are removed from an "eventbridge" "rule" then targets for an "eventbridge" "rule" are listed
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When targets are removed from an "eventbridge" "rule"
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then targets for an "eventbridge" "rule" are listed then events are published to an "eventbridge" "bus"
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When targets for an "eventbridge" "rule" are listed
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then events are published to an "eventbridge" "bus" then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When events are published to an "eventbridge" "bus"
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is created then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "bus" is deleted
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created then all "eventbridge" "bus"es are listed
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then an "eventbridge" "bus" is described then an "eventbridge" "rule" is created
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is described
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then all "eventbridge" "bus"es are listed then an "eventbridge" "rule" is deleted
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When all "eventbridge" "bus"es are listed
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then an "eventbridge" "rule" is created then an "eventbridge" "rule" is described
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When an "eventbridge" "rule" is created
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then an "eventbridge" "rule" is deleted then all rules on an "eventbridge" "bus" are listed
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When an "eventbridge" "rule" is deleted
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then an "eventbridge" "rule" is described then an "eventbridge" "rule" was "ENABLED"
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When an "eventbridge" "rule" is described
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then all rules on an "eventbridge" "bus" are listed then an "eventbridge" "rule" was "DISABLED"
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then an "eventbridge" "rule" was "ENABLED" then targets are added to an "eventbridge" "rule"
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When an "eventbridge" "rule" was "ENABLED"
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then an "eventbridge" "rule" was "DISABLED" then targets are removed from an "eventbridge" "rule"
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When an "eventbridge" "rule" was "DISABLED"
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then targets are added to an "eventbridge" "rule" then targets for an "eventbridge" "rule" are listed
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When targets are added to an "eventbridge" "rule"
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then targets are removed from an "eventbridge" "rule" then events are published to an "eventbridge" "bus"
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When targets are removed from an "eventbridge" "rule"
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then targets for an "eventbridge" "rule" are listed then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When targets for an "eventbridge" "rule" are listed
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then events are published to an "eventbridge" "bus" then an "eventbridge" "bus" is created
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is deleted then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "bus" is described
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then an "eventbridge" "bus" is created then an "eventbridge" "rule" is created
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then an "eventbridge" "bus" is deleted then an "eventbridge" "rule" is deleted
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When an "eventbridge" "bus" is deleted
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then all "eventbridge" "bus"es are listed then an "eventbridge" "rule" is described
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When all "eventbridge" "bus"es are listed
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then an "eventbridge" "rule" is created then all rules on an "eventbridge" "bus" are listed
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When an "eventbridge" "rule" is created
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then an "eventbridge" "rule" is deleted then an "eventbridge" "rule" was "ENABLED"
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When an "eventbridge" "rule" is deleted
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then an "eventbridge" "rule" is described then an "eventbridge" "rule" was "DISABLED"
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When an "eventbridge" "rule" is described
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then all rules on an "eventbridge" "bus" are listed then targets are added to an "eventbridge" "rule"
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When all rules on an "eventbridge" "bus" are listed
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then an "eventbridge" "rule" was "ENABLED" then targets are removed from an "eventbridge" "rule"
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When an "eventbridge" "rule" was "ENABLED"
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then an "eventbridge" "rule" was "DISABLED" then targets for an "eventbridge" "rule" are listed
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When an "eventbridge" "rule" was "DISABLED"
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then targets are added to an "eventbridge" "rule" then events are published to an "eventbridge" "bus"
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When targets are added to an "eventbridge" "rule"
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then targets are removed from an "eventbridge" "rule" then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When targets are removed from an "eventbridge" "rule"
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then targets for an "eventbridge" "rule" are listed then an "eventbridge" "bus" is created
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then events are published to an "eventbridge" "bus" then an "eventbridge" "bus" is deleted
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "bus" is described then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then all "eventbridge" "bus"es are listed
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then an "eventbridge" "bus" is created then an "eventbridge" "rule" is deleted
    When all "eventbridge" "bus"es are listed
    Given name not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then an "eventbridge" "bus" is deleted then an "eventbridge" "rule" is described
    When all "eventbridge" "bus"es are listed
    Given name is not 'default'
    When an "eventbridge" "bus" is deleted
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then an "eventbridge" "bus" is described then all rules on an "eventbridge" "bus" are listed
    When all "eventbridge" "bus"es are listed
    Given name in bus_status
    When an "eventbridge" "bus" is described
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then an "eventbridge" "rule" is created then an "eventbridge" "rule" was "ENABLED"
    When all "eventbridge" "bus"es are listed
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then an "eventbridge" "rule" is deleted then an "eventbridge" "rule" was "DISABLED"
    When all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then an "eventbridge" "rule" is described then targets are added to an "eventbridge" "rule"
    When all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then all rules on an "eventbridge" "bus" are listed then targets are removed from an "eventbridge" "rule"
    When all "eventbridge" "bus"es are listed
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then an "eventbridge" "rule" was "ENABLED" then targets for an "eventbridge" "rule" are listed
    When all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then an "eventbridge" "rule" was "DISABLED" then events are published to an "eventbridge" "bus"
    When all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then targets are added to an "eventbridge" "rule" then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then targets are removed from an "eventbridge" "rule" then an "eventbridge" "bus" is created
    When all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then targets for an "eventbridge" "rule" are listed then an "eventbridge" "bus" is deleted
    When all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then events are published to an "eventbridge" "bus" then an "eventbridge" "bus" is described
    When all "eventbridge" "bus"es are listed
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all "eventbridge" "bus"es are listed then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "rule" is created
    When all "eventbridge" "bus"es are listed
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then an "eventbridge" "bus" is created then an "eventbridge" "rule" is described
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then an "eventbridge" "bus" is deleted then all rules on an "eventbridge" "bus" are listed
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When an "eventbridge" "bus" is deleted
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then an "eventbridge" "bus" is described then an "eventbridge" "rule" was "ENABLED"
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When an "eventbridge" "bus" is described
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then all "eventbridge" "bus"es are listed then an "eventbridge" "rule" was "DISABLED"
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When all "eventbridge" "bus"es are listed
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then an "eventbridge" "rule" is deleted then targets are added to an "eventbridge" "rule"
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When an "eventbridge" "rule" is deleted
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then an "eventbridge" "rule" is described then targets are removed from an "eventbridge" "rule"
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When an "eventbridge" "rule" is described
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then all rules on an "eventbridge" "bus" are listed then targets for an "eventbridge" "rule" are listed
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When all rules on an "eventbridge" "bus" are listed
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then an "eventbridge" "rule" was "ENABLED" then events are published to an "eventbridge" "bus"
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When an "eventbridge" "rule" was "ENABLED"
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then an "eventbridge" "rule" was "DISABLED" then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When an "eventbridge" "rule" was "DISABLED"
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then targets are added to an "eventbridge" "rule" then an "eventbridge" "bus" is created
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When targets are added to an "eventbridge" "rule"
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then targets are removed from an "eventbridge" "rule" then an "eventbridge" "bus" is deleted
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When targets are removed from an "eventbridge" "rule"
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then targets for an "eventbridge" "rule" are listed then an "eventbridge" "bus" is described
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then events are published to an "eventbridge" "bus" then all "eventbridge" "bus"es are listed
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When events are published to an "eventbridge" "bus"
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is created then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "rule" is deleted
    Given rule_name not in rule_status
    When an "eventbridge" "rule" is created
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then an "eventbridge" "bus" is created then all rules on an "eventbridge" "bus" are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When an "eventbridge" "bus" is created
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then an "eventbridge" "bus" is deleted then an "eventbridge" "rule" was "ENABLED"
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When an "eventbridge" "bus" is deleted
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then an "eventbridge" "bus" is described then an "eventbridge" "rule" was "DISABLED"
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When an "eventbridge" "bus" is described
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then all "eventbridge" "bus"es are listed then targets are added to an "eventbridge" "rule"
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When all "eventbridge" "bus"es are listed
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then an "eventbridge" "rule" is created then targets are removed from an "eventbridge" "rule"
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When an "eventbridge" "rule" is created
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then an "eventbridge" "rule" is described then targets for an "eventbridge" "rule" are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When an "eventbridge" "rule" is described
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then all rules on an "eventbridge" "bus" are listed then events are published to an "eventbridge" "bus"
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When all rules on an "eventbridge" "bus" are listed
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then an "eventbridge" "rule" was "ENABLED" then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When an "eventbridge" "rule" was "ENABLED"
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then an "eventbridge" "rule" was "DISABLED" then an "eventbridge" "bus" is created
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When an "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then targets are added to an "eventbridge" "rule" then an "eventbridge" "bus" is deleted
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When targets are added to an "eventbridge" "rule"
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then targets are removed from an "eventbridge" "rule" then an "eventbridge" "bus" is described
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When targets are removed from an "eventbridge" "rule"
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then targets for an "eventbridge" "rule" are listed then all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When targets for an "eventbridge" "rule" are listed
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then events are published to an "eventbridge" "bus" then an "eventbridge" "rule" is created
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is deleted then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "rule" is described
    Given rule_name in rule_status
    When an "eventbridge" "rule" is deleted
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then an "eventbridge" "bus" is created then an "eventbridge" "rule" was "ENABLED"
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then an "eventbridge" "bus" is deleted then an "eventbridge" "rule" was "DISABLED"
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When an "eventbridge" "bus" is deleted
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then an "eventbridge" "bus" is described then targets are added to an "eventbridge" "rule"
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When an "eventbridge" "bus" is described
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then all "eventbridge" "bus"es are listed then targets are removed from an "eventbridge" "rule"
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When all "eventbridge" "bus"es are listed
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then an "eventbridge" "rule" is created then targets for an "eventbridge" "rule" are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When an "eventbridge" "rule" is created
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then an "eventbridge" "rule" is deleted then events are published to an "eventbridge" "bus"
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When an "eventbridge" "rule" is deleted
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then all rules on an "eventbridge" "bus" are listed then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When all rules on an "eventbridge" "bus" are listed
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "bus" is created
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then an "eventbridge" "rule" was "DISABLED" then an "eventbridge" "bus" is deleted
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When an "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then targets are added to an "eventbridge" "rule" then an "eventbridge" "bus" is described
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When targets are added to an "eventbridge" "rule"
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then targets are removed from an "eventbridge" "rule" then all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When targets are removed from an "eventbridge" "rule"
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then targets for an "eventbridge" "rule" are listed then an "eventbridge" "rule" is created
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then events are published to an "eventbridge" "bus" then an "eventbridge" "rule" is deleted
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" is described then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then all rules on an "eventbridge" "bus" are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" is described
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then an "eventbridge" "bus" is created then an "eventbridge" "rule" was "DISABLED"
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then an "eventbridge" "bus" is deleted then targets are added to an "eventbridge" "rule"
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "bus" is deleted
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then an "eventbridge" "bus" is described then targets are removed from an "eventbridge" "rule"
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "bus" is described
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then all "eventbridge" "bus"es are listed then targets for an "eventbridge" "rule" are listed
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When all "eventbridge" "bus"es are listed
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then an "eventbridge" "rule" is created then events are published to an "eventbridge" "bus"
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "rule" is created
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then an "eventbridge" "rule" is deleted then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "rule" is deleted
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then an "eventbridge" "rule" is described then an "eventbridge" "bus" is created
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "rule" is described
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "bus" is deleted
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then an "eventbridge" "rule" was "DISABLED" then an "eventbridge" "bus" is described
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then targets are added to an "eventbridge" "rule" then all "eventbridge" "bus"es are listed
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When targets are added to an "eventbridge" "rule"
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then targets are removed from an "eventbridge" "rule" then an "eventbridge" "rule" is created
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When targets are removed from an "eventbridge" "rule"
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then targets for an "eventbridge" "rule" are listed then an "eventbridge" "rule" is deleted
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then events are published to an "eventbridge" "bus" then an "eventbridge" "rule" is described
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an "eventbridge" "bus" are listed then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "rule" was "ENABLED"
    Given bus_name in bus_status
    When all rules on an "eventbridge" "bus" are listed
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "bus" is created then targets are added to an "eventbridge" "rule"
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "bus" is created
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "bus" is deleted then targets are removed from an "eventbridge" "rule"
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "bus" is deleted
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "bus" is described then targets for an "eventbridge" "rule" are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "bus" is described
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then all "eventbridge" "bus"es are listed then events are published to an "eventbridge" "bus"
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When all "eventbridge" "bus"es are listed
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "rule" is created then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "rule" is created
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "rule" is deleted then an "eventbridge" "bus" is created
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "rule" is deleted
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "rule" is described then an "eventbridge" "bus" is deleted
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "rule" is described
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then all rules on an "eventbridge" "bus" are listed then an "eventbridge" "bus" is described
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "rule" was "DISABLED" then all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "rule" was "DISABLED"
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then targets are added to an "eventbridge" "rule" then an "eventbridge" "rule" is created
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When targets are added to an "eventbridge" "rule"
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then targets are removed from an "eventbridge" "rule" then an "eventbridge" "rule" is deleted
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When targets are removed from an "eventbridge" "rule"
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then targets for an "eventbridge" "rule" are listed then an "eventbridge" "rule" is described
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then events are published to an "eventbridge" "bus" then all rules on an "eventbridge" "bus" are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When events are published to an "eventbridge" "bus"
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "rule" was "DISABLED"
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an "eventbridge" "bus" is created then targets are removed from an "eventbridge" "rule"
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "bus" is created
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an "eventbridge" "bus" is deleted then targets for an "eventbridge" "rule" are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "bus" is deleted
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an "eventbridge" "bus" is described then events are published to an "eventbridge" "bus"
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "bus" is described
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then all "eventbridge" "bus"es are listed then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When all "eventbridge" "bus"es are listed
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an "eventbridge" "rule" is created then an "eventbridge" "bus" is created
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "rule" is created
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an "eventbridge" "rule" is deleted then an "eventbridge" "bus" is deleted
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "rule" is deleted
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an "eventbridge" "rule" is described then an "eventbridge" "bus" is described
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "rule" is described
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then all rules on an "eventbridge" "bus" are listed then all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When all rules on an "eventbridge" "bus" are listed
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "rule" is created
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then targets are added to an "eventbridge" "rule" then an "eventbridge" "rule" is deleted
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When targets are added to an "eventbridge" "rule"
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then targets are removed from an "eventbridge" "rule" then an "eventbridge" "rule" is described
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When targets are removed from an "eventbridge" "rule"
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then targets for an "eventbridge" "rule" are listed then all rules on an "eventbridge" "bus" are listed
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When targets for an "eventbridge" "rule" are listed
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then events are published to an "eventbridge" "bus" then an "eventbridge" "rule" was "ENABLED"
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then targets are added to an "eventbridge" "rule"
    Given rule_name in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then an "eventbridge" "bus" is created then targets for an "eventbridge" "rule" are listed
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When an "eventbridge" "bus" is created
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then an "eventbridge" "bus" is deleted then events are published to an "eventbridge" "bus"
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When an "eventbridge" "bus" is deleted
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then an "eventbridge" "bus" is described then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When an "eventbridge" "bus" is described
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then all "eventbridge" "bus"es are listed then an "eventbridge" "bus" is created
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When all "eventbridge" "bus"es are listed
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then an "eventbridge" "rule" is created then an "eventbridge" "bus" is deleted
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When an "eventbridge" "rule" is created
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then an "eventbridge" "rule" is deleted then an "eventbridge" "bus" is described
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When an "eventbridge" "rule" is deleted
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then an "eventbridge" "rule" is described then all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When an "eventbridge" "rule" is described
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then all rules on an "eventbridge" "bus" are listed then an "eventbridge" "rule" is created
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "rule" is deleted
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then an "eventbridge" "rule" was "DISABLED" then an "eventbridge" "rule" is described
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When an "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then targets are removed from an "eventbridge" "rule" then all rules on an "eventbridge" "bus" are listed
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When targets are removed from an "eventbridge" "rule"
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then targets for an "eventbridge" "rule" are listed then an "eventbridge" "rule" was "ENABLED"
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then events are published to an "eventbridge" "bus" then an "eventbridge" "rule" was "DISABLED"
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to an "eventbridge" "rule" then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then targets are removed from an "eventbridge" "rule"
    Given rule_name in rule_status
    When targets are added to an "eventbridge" "rule"
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then an "eventbridge" "bus" is created then events are published to an "eventbridge" "bus"
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When an "eventbridge" "bus" is created
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then an "eventbridge" "bus" is deleted then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When an "eventbridge" "bus" is deleted
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then an "eventbridge" "bus" is described then an "eventbridge" "bus" is created
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When an "eventbridge" "bus" is described
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then all "eventbridge" "bus"es are listed then an "eventbridge" "bus" is deleted
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When all "eventbridge" "bus"es are listed
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then an "eventbridge" "rule" is created then an "eventbridge" "bus" is described
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When an "eventbridge" "rule" is created
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then an "eventbridge" "rule" is deleted then all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When an "eventbridge" "rule" is deleted
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then an "eventbridge" "rule" is described then an "eventbridge" "rule" is created
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When an "eventbridge" "rule" is described
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then all rules on an "eventbridge" "bus" are listed then an "eventbridge" "rule" is deleted
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "rule" is described
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then an "eventbridge" "rule" was "DISABLED" then all rules on an "eventbridge" "bus" are listed
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When an "eventbridge" "rule" was "DISABLED"
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then targets are added to an "eventbridge" "rule" then an "eventbridge" "rule" was "ENABLED"
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When targets are added to an "eventbridge" "rule"
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then targets for an "eventbridge" "rule" are listed then an "eventbridge" "rule" was "DISABLED"
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then events are published to an "eventbridge" "bus" then targets are added to an "eventbridge" "rule"
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When events are published to an "eventbridge" "bus"
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from an "eventbridge" "rule" then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then targets for an "eventbridge" "rule" are listed
    Given rule_name in rule_status
    When targets are removed from an "eventbridge" "rule"
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then an "eventbridge" "bus" is created then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "bus" is created
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then an "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then an "eventbridge" "bus" is described then an "eventbridge" "bus" is deleted
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "bus" is described
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then all "eventbridge" "bus"es are listed then an "eventbridge" "bus" is described
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When all "eventbridge" "bus"es are listed
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then an "eventbridge" "rule" is created then all "eventbridge" "bus"es are listed
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "rule" is created
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then an "eventbridge" "rule" is deleted then an "eventbridge" "rule" is created
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "rule" is deleted
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then an "eventbridge" "rule" is described then an "eventbridge" "rule" is deleted
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "rule" is described
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then all rules on an "eventbridge" "bus" are listed then an "eventbridge" "rule" is described
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then an "eventbridge" "rule" was "ENABLED" then all rules on an "eventbridge" "bus" are listed
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "rule" was "ENABLED"
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then an "eventbridge" "rule" was "DISABLED" then an "eventbridge" "rule" was "ENABLED"
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then targets are added to an "eventbridge" "rule" then an "eventbridge" "rule" was "DISABLED"
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When targets are added to an "eventbridge" "rule"
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then targets are removed from an "eventbridge" "rule" then targets are added to an "eventbridge" "rule"
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When targets are removed from an "eventbridge" "rule"
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then events are published to an "eventbridge" "bus" then targets are removed from an "eventbridge" "rule"
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When events are published to an "eventbridge" "bus"
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: targets for an "eventbridge" "rule" are listed then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then events are published to an "eventbridge" "bus"
    Given rule_name in rule_status
    When targets for an "eventbridge" "rule" are listed
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then an "eventbridge" "bus" is created then an "eventbridge" "bus" is deleted
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "bus" is created
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then an "eventbridge" "bus" is deleted then an "eventbridge" "bus" is described
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then an "eventbridge" "bus" is described then all "eventbridge" "bus"es are listed
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "bus" is described
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then all "eventbridge" "bus"es are listed then an "eventbridge" "rule" is created
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When all "eventbridge" "bus"es are listed
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then an "eventbridge" "rule" is created then an "eventbridge" "rule" is deleted
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "rule" is created
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then an "eventbridge" "rule" is deleted then an "eventbridge" "rule" is described
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "rule" is deleted
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then an "eventbridge" "rule" is described then all rules on an "eventbridge" "bus" are listed
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "rule" is described
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then all rules on an "eventbridge" "bus" are listed then an "eventbridge" "rule" was "ENABLED"
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "rule" was "DISABLED"
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then an "eventbridge" "rule" was "DISABLED" then targets are added to an "eventbridge" "rule"
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "rule" was "DISABLED"
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then targets are added to an "eventbridge" "rule" then targets are removed from an "eventbridge" "rule"
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When targets are added to an "eventbridge" "rule"
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then targets are removed from an "eventbridge" "rule" then targets for an "eventbridge" "rule" are listed
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When targets are removed from an "eventbridge" "rule"
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then targets for an "eventbridge" "rule" are listed then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When targets for an "eventbridge" "rule" are listed
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an "eventbridge" "bus" then a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "bus" is created
    Given bus_name in bus_status
    When events are published to an "eventbridge" "bus"
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "bus" is created then an "eventbridge" "bus" is described
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "bus" is created
    When an "eventbridge" "bus" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "bus" is deleted then all "eventbridge" "bus"es are listed
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "bus" is deleted
    When all "eventbridge" "bus"es are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "bus" is described then an "eventbridge" "rule" is created
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "bus" is described
    When an "eventbridge" "rule" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then all "eventbridge" "bus"es are listed then an "eventbridge" "rule" is deleted
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When all "eventbridge" "bus"es are listed
    When an "eventbridge" "rule" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "rule" is created then an "eventbridge" "rule" is described
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "rule" is created
    When an "eventbridge" "rule" is described
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "rule" is deleted then all rules on an "eventbridge" "bus" are listed
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "rule" is deleted
    When all rules on an "eventbridge" "bus" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "rule" is described then an "eventbridge" "rule" was "ENABLED"
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "rule" is described
    When an "eventbridge" "rule" was "ENABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then all rules on an "eventbridge" "bus" are listed then an "eventbridge" "rule" was "DISABLED"
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When all rules on an "eventbridge" "bus" are listed
    When an "eventbridge" "rule" was "DISABLED"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "rule" was "ENABLED" then targets are added to an "eventbridge" "rule"
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "rule" was "ENABLED"
    When targets are added to an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then an "eventbridge" "rule" was "DISABLED" then targets are removed from an "eventbridge" "rule"
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When an "eventbridge" "rule" was "DISABLED"
    When targets are removed from an "eventbridge" "rule"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then targets are added to an "eventbridge" "rule" then targets for an "eventbridge" "rule" are listed
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When targets are added to an "eventbridge" "rule"
    When targets for an "eventbridge" "rule" are listed
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then targets are removed from an "eventbridge" "rule" then events are published to an "eventbridge" "bus"
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When targets are removed from an "eventbridge" "rule"
    When events are published to an "eventbridge" "bus"
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then targets for an "eventbridge" "rule" are listed then an "eventbridge" "bus" is created
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When targets for an "eventbridge" "rule" are listed
    When an "eventbridge" "bus" is created
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded then events are published to an "eventbridge" "bus" then an "eventbridge" "bus" is deleted
    Given len(dlq) > 0
    When a dead-letter "eventbridge" "dead-letter queue" entry is retried or discarded
    When events are published to an "eventbridge" "bus"
    When an "eventbridge" "bus" is deleted
    And every "eventbridge" "bus" has a valid status ("ACTIVE" or "DELETED")
    And every "eventbridge" "rule" has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every "eventbridge" "rule" references an "eventbridge" "bus" that exists
    And the default "eventbridge" "bus" cannot be deleted
    And an "eventbridge" "rule" can only be deleted when it has no targets
    And no enabled "eventbridge" "rule" references a deleted "eventbridge" "bus"
    And the "eventbridge" "dead-letter queue" never exceeds its bounded capacity
