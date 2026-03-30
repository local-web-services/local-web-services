@events @generated
Feature: Events - Action Sequences

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @sequence
  Scenario: an event bus is created then an event bus is deleted
    Given name not in bus_status
    Given an event bus has been created
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then an event bus is described
    Given name not in bus_status
    Given an event bus has been created
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then all event buses are listed
    Given name not in bus_status
    Given an event bus has been created
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then an EventBridge rule is created
    Given name not in bus_status
    Given an event bus has been created
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then an EventBridge rule is deleted
    Given name not in bus_status
    Given an event bus has been created
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then an EventBridge rule is described
    Given name not in bus_status
    Given an event bus has been created
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then all rules on an event bus are listed
    Given name not in bus_status
    Given an event bus has been created
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then a rule is enabled
    Given name not in bus_status
    Given an event bus has been created
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then a rule is disabled
    Given name not in bus_status
    Given an event bus has been created
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then targets are added to a rule
    Given name not in bus_status
    Given an event bus has been created
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then targets are removed from a rule
    Given name not in bus_status
    Given an event bus has been created
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then targets for a rule are listed
    Given name not in bus_status
    Given an event bus has been created
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then events are published to an event bus
    Given name not in bus_status
    Given an event bus has been created
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then a dead-letter queue entry is retried or discarded
    Given name not in bus_status
    Given an event bus has been created
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then an event bus is created
    Given name is not 'default'
    Given an event bus has been deleted
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then an event bus is described
    Given name is not 'default'
    Given an event bus has been deleted
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then all event buses are listed
    Given name is not 'default'
    Given an event bus has been deleted
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then an EventBridge rule is created
    Given name is not 'default'
    Given an event bus has been deleted
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then an EventBridge rule is deleted
    Given name is not 'default'
    Given an event bus has been deleted
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then an EventBridge rule is described
    Given name is not 'default'
    Given an event bus has been deleted
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then all rules on an event bus are listed
    Given name is not 'default'
    Given an event bus has been deleted
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then a rule is enabled
    Given name is not 'default'
    Given an event bus has been deleted
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then a rule is disabled
    Given name is not 'default'
    Given an event bus has been deleted
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then targets are added to a rule
    Given name is not 'default'
    Given an event bus has been deleted
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then targets are removed from a rule
    Given name is not 'default'
    Given an event bus has been deleted
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then targets for a rule are listed
    Given name is not 'default'
    Given an event bus has been deleted
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then events are published to an event bus
    Given name is not 'default'
    Given an event bus has been deleted
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then a dead-letter queue entry is retried or discarded
    Given name is not 'default'
    Given an event bus has been deleted
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then an event bus is created
    Given name in bus_status
    Given an event bus has been described
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then an event bus is deleted
    Given name in bus_status
    Given an event bus has been described
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then all event buses are listed
    Given name in bus_status
    Given an event bus has been described
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then an EventBridge rule is created
    Given name in bus_status
    Given an event bus has been described
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then an EventBridge rule is deleted
    Given name in bus_status
    Given an event bus has been described
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then an EventBridge rule is described
    Given name in bus_status
    Given an event bus has been described
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then all rules on an event bus are listed
    Given name in bus_status
    Given an event bus has been described
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then a rule is enabled
    Given name in bus_status
    Given an event bus has been described
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then a rule is disabled
    Given name in bus_status
    Given an event bus has been described
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then targets are added to a rule
    Given name in bus_status
    Given an event bus has been described
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then targets are removed from a rule
    Given name in bus_status
    Given an event bus has been described
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then targets for a rule are listed
    Given name in bus_status
    Given an event bus has been described
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then events are published to an event bus
    Given name in bus_status
    Given an event bus has been described
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then a dead-letter queue entry is retried or discarded
    Given name in bus_status
    Given an event bus has been described
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then an event bus is created
    Given all event buses have been listed
    Given name not in bus_status
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then an event bus is deleted
    Given all event buses have been listed
    Given name is not 'default'
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then an event bus is described
    Given all event buses have been listed
    Given name in bus_status
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then an EventBridge rule is created
    Given all event buses have been listed
    Given rule_name not in rule_status
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then an EventBridge rule is deleted
    Given all event buses have been listed
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then an EventBridge rule is described
    Given all event buses have been listed
    Given rule_name in rule_status
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then all rules on an event bus are listed
    Given all event buses have been listed
    Given bus_name in bus_status
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then a rule is enabled
    Given all event buses have been listed
    Given rule_name in rule_status
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then a rule is disabled
    Given all event buses have been listed
    Given rule_name in rule_status
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then targets are added to a rule
    Given all event buses have been listed
    Given rule_name in rule_status
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then targets are removed from a rule
    Given all event buses have been listed
    Given rule_name in rule_status
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then targets for a rule are listed
    Given all event buses have been listed
    Given rule_name in rule_status
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then events are published to an event bus
    Given all event buses have been listed
    Given bus_name in bus_status
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then a dead-letter queue entry is retried or discarded
    Given all event buses have been listed
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then an event bus is created
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then an event bus is deleted
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then an event bus is described
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then all event buses are listed
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then an EventBridge rule is deleted
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then an EventBridge rule is described
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then all rules on an event bus are listed
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then a rule is enabled
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then a rule is disabled
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then targets are added to a rule
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then targets are removed from a rule
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then targets for a rule are listed
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then events are published to an event bus
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then a dead-letter queue entry is retried or discarded
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then an event bus is created
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then an event bus is deleted
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then an event bus is described
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then all event buses are listed
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then an EventBridge rule is created
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then an EventBridge rule is described
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then all rules on an event bus are listed
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then a rule is enabled
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then a rule is disabled
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then targets are added to a rule
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then targets are removed from a rule
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then targets for a rule are listed
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then events are published to an event bus
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then an event bus is created
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then an event bus is deleted
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then an event bus is described
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then all event buses are listed
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then an EventBridge rule is created
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then an EventBridge rule is deleted
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then all rules on an event bus are listed
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then a rule is enabled
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then a rule is disabled
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then targets are added to a rule
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then targets are removed from a rule
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then targets for a rule are listed
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then events are published to an event bus
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then an event bus is created
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then an event bus is deleted
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then an event bus is described
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then all event buses are listed
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then an EventBridge rule is created
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then an EventBridge rule is deleted
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then an EventBridge rule is described
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then a rule is enabled
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then a rule is disabled
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then targets are added to a rule
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then targets are removed from a rule
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then targets for a rule are listed
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then events are published to an event bus
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then a dead-letter queue entry is retried or discarded
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then an event bus is created
    Given rule_name in rule_status
    Given a rule has been enabled
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then an event bus is deleted
    Given rule_name in rule_status
    Given a rule has been enabled
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then an event bus is described
    Given rule_name in rule_status
    Given a rule has been enabled
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then all event buses are listed
    Given rule_name in rule_status
    Given a rule has been enabled
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then an EventBridge rule is created
    Given rule_name in rule_status
    Given a rule has been enabled
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then an EventBridge rule is deleted
    Given rule_name in rule_status
    Given a rule has been enabled
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then an EventBridge rule is described
    Given rule_name in rule_status
    Given a rule has been enabled
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then all rules on an event bus are listed
    Given rule_name in rule_status
    Given a rule has been enabled
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then a rule is disabled
    Given rule_name in rule_status
    Given a rule has been enabled
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then targets are added to a rule
    Given rule_name in rule_status
    Given a rule has been enabled
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then targets are removed from a rule
    Given rule_name in rule_status
    Given a rule has been enabled
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then targets for a rule are listed
    Given rule_name in rule_status
    Given a rule has been enabled
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then events are published to an event bus
    Given rule_name in rule_status
    Given a rule has been enabled
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    Given a rule has been enabled
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then an event bus is created
    Given rule_name in rule_status
    Given a rule has been disabled
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then an event bus is deleted
    Given rule_name in rule_status
    Given a rule has been disabled
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then an event bus is described
    Given rule_name in rule_status
    Given a rule has been disabled
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then all event buses are listed
    Given rule_name in rule_status
    Given a rule has been disabled
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then an EventBridge rule is created
    Given rule_name in rule_status
    Given a rule has been disabled
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then an EventBridge rule is deleted
    Given rule_name in rule_status
    Given a rule has been disabled
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then an EventBridge rule is described
    Given rule_name in rule_status
    Given a rule has been disabled
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then all rules on an event bus are listed
    Given rule_name in rule_status
    Given a rule has been disabled
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then a rule is enabled
    Given rule_name in rule_status
    Given a rule has been disabled
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then targets are added to a rule
    Given rule_name in rule_status
    Given a rule has been disabled
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then targets are removed from a rule
    Given rule_name in rule_status
    Given a rule has been disabled
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then targets for a rule are listed
    Given rule_name in rule_status
    Given a rule has been disabled
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then events are published to an event bus
    Given rule_name in rule_status
    Given a rule has been disabled
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    Given a rule has been disabled
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then an event bus is created
    Given rule_name in rule_status
    Given targets have been added to a rule
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then an event bus is deleted
    Given rule_name in rule_status
    Given targets have been added to a rule
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then an event bus is described
    Given rule_name in rule_status
    Given targets have been added to a rule
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then all event buses are listed
    Given rule_name in rule_status
    Given targets have been added to a rule
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then an EventBridge rule is created
    Given rule_name in rule_status
    Given targets have been added to a rule
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then an EventBridge rule is deleted
    Given rule_name in rule_status
    Given targets have been added to a rule
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then an EventBridge rule is described
    Given rule_name in rule_status
    Given targets have been added to a rule
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then all rules on an event bus are listed
    Given rule_name in rule_status
    Given targets have been added to a rule
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then a rule is enabled
    Given rule_name in rule_status
    Given targets have been added to a rule
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then a rule is disabled
    Given rule_name in rule_status
    Given targets have been added to a rule
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then targets are removed from a rule
    Given rule_name in rule_status
    Given targets have been added to a rule
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then targets for a rule are listed
    Given rule_name in rule_status
    Given targets have been added to a rule
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then events are published to an event bus
    Given rule_name in rule_status
    Given targets have been added to a rule
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    Given targets have been added to a rule
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then an event bus is created
    Given rule_name in rule_status
    Given targets have been removed from a rule
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then an event bus is deleted
    Given rule_name in rule_status
    Given targets have been removed from a rule
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then an event bus is described
    Given rule_name in rule_status
    Given targets have been removed from a rule
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then all event buses are listed
    Given rule_name in rule_status
    Given targets have been removed from a rule
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then an EventBridge rule is created
    Given rule_name in rule_status
    Given targets have been removed from a rule
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then an EventBridge rule is deleted
    Given rule_name in rule_status
    Given targets have been removed from a rule
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then an EventBridge rule is described
    Given rule_name in rule_status
    Given targets have been removed from a rule
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then all rules on an event bus are listed
    Given rule_name in rule_status
    Given targets have been removed from a rule
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then a rule is enabled
    Given rule_name in rule_status
    Given targets have been removed from a rule
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then a rule is disabled
    Given rule_name in rule_status
    Given targets have been removed from a rule
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then targets are added to a rule
    Given rule_name in rule_status
    Given targets have been removed from a rule
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then targets for a rule are listed
    Given rule_name in rule_status
    Given targets have been removed from a rule
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then events are published to an event bus
    Given rule_name in rule_status
    Given targets have been removed from a rule
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    Given targets have been removed from a rule
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then an event bus is created
    Given rule_name in rule_status
    Given targets for a rule have been listed
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then an event bus is deleted
    Given rule_name in rule_status
    Given targets for a rule have been listed
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then an event bus is described
    Given rule_name in rule_status
    Given targets for a rule have been listed
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then all event buses are listed
    Given rule_name in rule_status
    Given targets for a rule have been listed
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then an EventBridge rule is created
    Given rule_name in rule_status
    Given targets for a rule have been listed
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then an EventBridge rule is deleted
    Given rule_name in rule_status
    Given targets for a rule have been listed
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then an EventBridge rule is described
    Given rule_name in rule_status
    Given targets for a rule have been listed
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then all rules on an event bus are listed
    Given rule_name in rule_status
    Given targets for a rule have been listed
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then a rule is enabled
    Given rule_name in rule_status
    Given targets for a rule have been listed
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then a rule is disabled
    Given rule_name in rule_status
    Given targets for a rule have been listed
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then targets are added to a rule
    Given rule_name in rule_status
    Given targets for a rule have been listed
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then targets are removed from a rule
    Given rule_name in rule_status
    Given targets for a rule have been listed
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then events are published to an event bus
    Given rule_name in rule_status
    Given targets for a rule have been listed
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    Given targets for a rule have been listed
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then an event bus is created
    Given bus_name in bus_status
    Given events have been published to an event bus
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then an event bus is deleted
    Given bus_name in bus_status
    Given events have been published to an event bus
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then an event bus is described
    Given bus_name in bus_status
    Given events have been published to an event bus
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then all event buses are listed
    Given bus_name in bus_status
    Given events have been published to an event bus
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then an EventBridge rule is created
    Given bus_name in bus_status
    Given events have been published to an event bus
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then an EventBridge rule is deleted
    Given bus_name in bus_status
    Given events have been published to an event bus
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then an EventBridge rule is described
    Given bus_name in bus_status
    Given events have been published to an event bus
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then all rules on an event bus are listed
    Given bus_name in bus_status
    Given events have been published to an event bus
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then a rule is enabled
    Given bus_name in bus_status
    Given events have been published to an event bus
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then a rule is disabled
    Given bus_name in bus_status
    Given events have been published to an event bus
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then targets are added to a rule
    Given bus_name in bus_status
    Given events have been published to an event bus
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then targets are removed from a rule
    Given bus_name in bus_status
    Given events have been published to an event bus
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then targets for a rule are listed
    Given bus_name in bus_status
    Given events have been published to an event bus
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then a dead-letter queue entry is retried or discarded
    Given bus_name in bus_status
    Given events have been published to an event bus
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an event bus is created
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an event bus is deleted
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an event bus is described
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then all event buses are listed
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an EventBridge rule is created
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an EventBridge rule is deleted
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an EventBridge rule is described
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then all rules on an event bus are listed
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then a rule is enabled
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then a rule is disabled
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then targets are added to a rule
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then targets are removed from a rule
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then targets for a rule are listed
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then events are published to an event bus
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then an event bus is deleted then an event bus is described
    Given name not in bus_status
    Given an event bus has been created
    Given an event bus has been deleted
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then an event bus is described then all event buses are listed
    Given name not in bus_status
    Given an event bus has been created
    Given an event bus has been described
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then all event buses are listed then an EventBridge rule is created
    Given name not in bus_status
    Given an event bus has been created
    Given all event buses have been listed
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then an EventBridge rule is created then an EventBridge rule is deleted
    Given name not in bus_status
    Given an event bus has been created
    Given an EventBridge rule has been created
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then an EventBridge rule is deleted then an EventBridge rule is described
    Given name not in bus_status
    Given an event bus has been created
    Given an EventBridge rule has been deleted
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then an EventBridge rule is described then all rules on an event bus are listed
    Given name not in bus_status
    Given an event bus has been created
    Given an EventBridge rule has been described
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then all rules on an event bus are listed then a rule is enabled
    Given name not in bus_status
    Given an event bus has been created
    Given all rules on an event bus have been listed
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then a rule is enabled then a rule is disabled
    Given name not in bus_status
    Given an event bus has been created
    Given a rule has been enabled
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then a rule is disabled then targets are added to a rule
    Given name not in bus_status
    Given an event bus has been created
    Given a rule has been disabled
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then targets are added to a rule then targets are removed from a rule
    Given name not in bus_status
    Given an event bus has been created
    Given targets have been added to a rule
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then targets are removed from a rule then targets for a rule are listed
    Given name not in bus_status
    Given an event bus has been created
    Given targets have been removed from a rule
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then targets for a rule are listed then events are published to an event bus
    Given name not in bus_status
    Given an event bus has been created
    Given targets for a rule have been listed
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then events are published to an event bus then a dead-letter queue entry is retried or discarded
    Given name not in bus_status
    Given an event bus has been created
    Given events have been published to an event bus
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is created then a dead-letter queue entry is retried or discarded then an event bus is deleted
    Given name not in bus_status
    Given an event bus has been created
    Given a dead-letter queue entry has been retried or discarded
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then an event bus is created then all event buses are listed
    Given name is not 'default'
    Given an event bus has been deleted
    Given an event bus has been created
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then an event bus is described then an EventBridge rule is created
    Given name is not 'default'
    Given an event bus has been deleted
    Given an event bus has been described
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then all event buses are listed then an EventBridge rule is deleted
    Given name is not 'default'
    Given an event bus has been deleted
    Given all event buses have been listed
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then an EventBridge rule is created then an EventBridge rule is described
    Given name is not 'default'
    Given an event bus has been deleted
    Given an EventBridge rule has been created
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then an EventBridge rule is deleted then all rules on an event bus are listed
    Given name is not 'default'
    Given an event bus has been deleted
    Given an EventBridge rule has been deleted
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then an EventBridge rule is described then a rule is enabled
    Given name is not 'default'
    Given an event bus has been deleted
    Given an EventBridge rule has been described
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then all rules on an event bus are listed then a rule is disabled
    Given name is not 'default'
    Given an event bus has been deleted
    Given all rules on an event bus have been listed
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then a rule is enabled then targets are added to a rule
    Given name is not 'default'
    Given an event bus has been deleted
    Given a rule has been enabled
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then a rule is disabled then targets are removed from a rule
    Given name is not 'default'
    Given an event bus has been deleted
    Given a rule has been disabled
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then targets are added to a rule then targets for a rule are listed
    Given name is not 'default'
    Given an event bus has been deleted
    Given targets have been added to a rule
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then targets are removed from a rule then events are published to an event bus
    Given name is not 'default'
    Given an event bus has been deleted
    Given targets have been removed from a rule
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then targets for a rule are listed then a dead-letter queue entry is retried or discarded
    Given name is not 'default'
    Given an event bus has been deleted
    Given targets for a rule have been listed
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then events are published to an event bus then an event bus is created
    Given name is not 'default'
    Given an event bus has been deleted
    Given events have been published to an event bus
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is deleted then a dead-letter queue entry is retried or discarded then an event bus is described
    Given name is not 'default'
    Given an event bus has been deleted
    Given a dead-letter queue entry has been retried or discarded
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then an event bus is created then an EventBridge rule is created
    Given name in bus_status
    Given an event bus has been described
    Given an event bus has been created
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then an event bus is deleted then an EventBridge rule is deleted
    Given name in bus_status
    Given an event bus has been described
    Given an event bus has been deleted
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then all event buses are listed then an EventBridge rule is described
    Given name in bus_status
    Given an event bus has been described
    Given all event buses have been listed
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then an EventBridge rule is created then all rules on an event bus are listed
    Given name in bus_status
    Given an event bus has been described
    Given an EventBridge rule has been created
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then an EventBridge rule is deleted then a rule is enabled
    Given name in bus_status
    Given an event bus has been described
    Given an EventBridge rule has been deleted
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then an EventBridge rule is described then a rule is disabled
    Given name in bus_status
    Given an event bus has been described
    Given an EventBridge rule has been described
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then all rules on an event bus are listed then targets are added to a rule
    Given name in bus_status
    Given an event bus has been described
    Given all rules on an event bus have been listed
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then a rule is enabled then targets are removed from a rule
    Given name in bus_status
    Given an event bus has been described
    Given a rule has been enabled
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then a rule is disabled then targets for a rule are listed
    Given name in bus_status
    Given an event bus has been described
    Given a rule has been disabled
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then targets are added to a rule then events are published to an event bus
    Given name in bus_status
    Given an event bus has been described
    Given targets have been added to a rule
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then targets are removed from a rule then a dead-letter queue entry is retried or discarded
    Given name in bus_status
    Given an event bus has been described
    Given targets have been removed from a rule
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then targets for a rule are listed then an event bus is created
    Given name in bus_status
    Given an event bus has been described
    Given targets for a rule have been listed
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then events are published to an event bus then an event bus is deleted
    Given name in bus_status
    Given an event bus has been described
    Given events have been published to an event bus
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an event bus is described then a dead-letter queue entry is retried or discarded then all event buses are listed
    Given name in bus_status
    Given an event bus has been described
    Given a dead-letter queue entry has been retried or discarded
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then an event bus is created then an EventBridge rule is deleted
    Given all event buses have been listed
    Given name not in bus_status
    Given an event bus has been created
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then an event bus is deleted then an EventBridge rule is described
    Given all event buses have been listed
    Given name is not 'default'
    Given an event bus has been deleted
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then an event bus is described then all rules on an event bus are listed
    Given all event buses have been listed
    Given name in bus_status
    Given an event bus has been described
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then an EventBridge rule is created then a rule is enabled
    Given all event buses have been listed
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then an EventBridge rule is deleted then a rule is disabled
    Given all event buses have been listed
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then an EventBridge rule is described then targets are added to a rule
    Given all event buses have been listed
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then all rules on an event bus are listed then targets are removed from a rule
    Given all event buses have been listed
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then a rule is enabled then targets for a rule are listed
    Given all event buses have been listed
    Given rule_name in rule_status
    Given a rule has been enabled
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then a rule is disabled then events are published to an event bus
    Given all event buses have been listed
    Given rule_name in rule_status
    Given a rule has been disabled
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then targets are added to a rule then a dead-letter queue entry is retried or discarded
    Given all event buses have been listed
    Given rule_name in rule_status
    Given targets have been added to a rule
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then targets are removed from a rule then an event bus is created
    Given all event buses have been listed
    Given rule_name in rule_status
    Given targets have been removed from a rule
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then targets for a rule are listed then an event bus is deleted
    Given all event buses have been listed
    Given rule_name in rule_status
    Given targets for a rule have been listed
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then events are published to an event bus then an event bus is described
    Given all event buses have been listed
    Given bus_name in bus_status
    Given events have been published to an event bus
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all event buses are listed then a dead-letter queue entry is retried or discarded then an EventBridge rule is created
    Given all event buses have been listed
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then an event bus is created then an EventBridge rule is described
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    Given an event bus has been created
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then an event bus is deleted then all rules on an event bus are listed
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    Given an event bus has been deleted
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then an event bus is described then a rule is enabled
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    Given an event bus has been described
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then all event buses are listed then a rule is disabled
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    Given all event buses have been listed
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then an EventBridge rule is deleted then targets are added to a rule
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    Given an EventBridge rule has been deleted
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then an EventBridge rule is described then targets are removed from a rule
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    Given an EventBridge rule has been described
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then all rules on an event bus are listed then targets for a rule are listed
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    Given all rules on an event bus have been listed
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then a rule is enabled then events are published to an event bus
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    Given a rule has been enabled
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then a rule is disabled then a dead-letter queue entry is retried or discarded
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    Given a rule has been disabled
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then targets are added to a rule then an event bus is created
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    Given targets have been added to a rule
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then targets are removed from a rule then an event bus is deleted
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    Given targets have been removed from a rule
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then targets for a rule are listed then an event bus is described
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    Given targets for a rule have been listed
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then events are published to an event bus then all event buses are listed
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    Given events have been published to an event bus
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is created then a dead-letter queue entry is retried or discarded then an EventBridge rule is deleted
    Given rule_name not in rule_status
    Given an EventBridge rule has been created
    Given a dead-letter queue entry has been retried or discarded
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then an event bus is created then all rules on an event bus are listed
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    Given an event bus has been created
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then an event bus is deleted then a rule is enabled
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    Given an event bus has been deleted
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then an event bus is described then a rule is disabled
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    Given an event bus has been described
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then all event buses are listed then targets are added to a rule
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    Given all event buses have been listed
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then an EventBridge rule is created then targets are removed from a rule
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    Given an EventBridge rule has been created
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then an EventBridge rule is described then targets for a rule are listed
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    Given an EventBridge rule has been described
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then all rules on an event bus are listed then events are published to an event bus
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    Given all rules on an event bus have been listed
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then a rule is enabled then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    Given a rule has been enabled
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then a rule is disabled then an event bus is created
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    Given a rule has been disabled
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then targets are added to a rule then an event bus is deleted
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    Given targets have been added to a rule
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then targets are removed from a rule then an event bus is described
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    Given targets have been removed from a rule
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then targets for a rule are listed then all event buses are listed
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    Given targets for a rule have been listed
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then events are published to an event bus then an EventBridge rule is created
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    Given events have been published to an event bus
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is deleted then a dead-letter queue entry is retried or discarded then an EventBridge rule is described
    Given rule_name in rule_status
    Given an EventBridge rule has been deleted
    Given a dead-letter queue entry has been retried or discarded
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then an event bus is created then a rule is enabled
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    Given an event bus has been created
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then an event bus is deleted then a rule is disabled
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    Given an event bus has been deleted
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then an event bus is described then targets are added to a rule
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    Given an event bus has been described
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then all event buses are listed then targets are removed from a rule
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    Given all event buses have been listed
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then an EventBridge rule is created then targets for a rule are listed
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    Given an EventBridge rule has been created
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then an EventBridge rule is deleted then events are published to an event bus
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    Given an EventBridge rule has been deleted
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then all rules on an event bus are listed then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    Given all rules on an event bus have been listed
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then a rule is enabled then an event bus is created
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    Given a rule has been enabled
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then a rule is disabled then an event bus is deleted
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    Given a rule has been disabled
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then targets are added to a rule then an event bus is described
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    Given targets have been added to a rule
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then targets are removed from a rule then all event buses are listed
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    Given targets have been removed from a rule
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then targets for a rule are listed then an EventBridge rule is created
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    Given targets for a rule have been listed
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then events are published to an event bus then an EventBridge rule is deleted
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    Given events have been published to an event bus
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: an EventBridge rule is described then a dead-letter queue entry is retried or discarded then all rules on an event bus are listed
    Given rule_name in rule_status
    Given an EventBridge rule has been described
    Given a dead-letter queue entry has been retried or discarded
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then an event bus is created then a rule is disabled
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    Given an event bus has been created
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then an event bus is deleted then targets are added to a rule
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    Given an event bus has been deleted
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then an event bus is described then targets are removed from a rule
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    Given an event bus has been described
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then all event buses are listed then targets for a rule are listed
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    Given all event buses have been listed
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then an EventBridge rule is created then events are published to an event bus
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    Given an EventBridge rule has been created
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then an EventBridge rule is deleted then a dead-letter queue entry is retried or discarded
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    Given an EventBridge rule has been deleted
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then an EventBridge rule is described then an event bus is created
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    Given an EventBridge rule has been described
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then a rule is enabled then an event bus is deleted
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    Given a rule has been enabled
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then a rule is disabled then an event bus is described
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    Given a rule has been disabled
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then targets are added to a rule then all event buses are listed
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    Given targets have been added to a rule
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then targets are removed from a rule then an EventBridge rule is created
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    Given targets have been removed from a rule
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then targets for a rule are listed then an EventBridge rule is deleted
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    Given targets for a rule have been listed
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then events are published to an event bus then an EventBridge rule is described
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    Given events have been published to an event bus
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: all rules on an event bus are listed then a dead-letter queue entry is retried or discarded then a rule is enabled
    Given bus_name in bus_status
    Given all rules on an event bus have been listed
    Given a dead-letter queue entry has been retried or discarded
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then an event bus is created then targets are added to a rule
    Given rule_name in rule_status
    Given a rule has been enabled
    Given an event bus has been created
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then an event bus is deleted then targets are removed from a rule
    Given rule_name in rule_status
    Given a rule has been enabled
    Given an event bus has been deleted
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then an event bus is described then targets for a rule are listed
    Given rule_name in rule_status
    Given a rule has been enabled
    Given an event bus has been described
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then all event buses are listed then events are published to an event bus
    Given rule_name in rule_status
    Given a rule has been enabled
    Given all event buses have been listed
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then an EventBridge rule is created then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    Given a rule has been enabled
    Given an EventBridge rule has been created
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then an EventBridge rule is deleted then an event bus is created
    Given rule_name in rule_status
    Given a rule has been enabled
    Given an EventBridge rule has been deleted
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then an EventBridge rule is described then an event bus is deleted
    Given rule_name in rule_status
    Given a rule has been enabled
    Given an EventBridge rule has been described
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then all rules on an event bus are listed then an event bus is described
    Given rule_name in rule_status
    Given a rule has been enabled
    Given all rules on an event bus have been listed
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then a rule is disabled then all event buses are listed
    Given rule_name in rule_status
    Given a rule has been enabled
    Given a rule has been disabled
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then targets are added to a rule then an EventBridge rule is created
    Given rule_name in rule_status
    Given a rule has been enabled
    Given targets have been added to a rule
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then targets are removed from a rule then an EventBridge rule is deleted
    Given rule_name in rule_status
    Given a rule has been enabled
    Given targets have been removed from a rule
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then targets for a rule are listed then an EventBridge rule is described
    Given rule_name in rule_status
    Given a rule has been enabled
    Given targets for a rule have been listed
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then events are published to an event bus then all rules on an event bus are listed
    Given rule_name in rule_status
    Given a rule has been enabled
    Given events have been published to an event bus
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is enabled then a dead-letter queue entry is retried or discarded then a rule is disabled
    Given rule_name in rule_status
    Given a rule has been enabled
    Given a dead-letter queue entry has been retried or discarded
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then an event bus is created then targets are removed from a rule
    Given rule_name in rule_status
    Given a rule has been disabled
    Given an event bus has been created
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then an event bus is deleted then targets for a rule are listed
    Given rule_name in rule_status
    Given a rule has been disabled
    Given an event bus has been deleted
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then an event bus is described then events are published to an event bus
    Given rule_name in rule_status
    Given a rule has been disabled
    Given an event bus has been described
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then all event buses are listed then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    Given a rule has been disabled
    Given all event buses have been listed
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then an EventBridge rule is created then an event bus is created
    Given rule_name in rule_status
    Given a rule has been disabled
    Given an EventBridge rule has been created
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then an EventBridge rule is deleted then an event bus is deleted
    Given rule_name in rule_status
    Given a rule has been disabled
    Given an EventBridge rule has been deleted
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then an EventBridge rule is described then an event bus is described
    Given rule_name in rule_status
    Given a rule has been disabled
    Given an EventBridge rule has been described
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then all rules on an event bus are listed then all event buses are listed
    Given rule_name in rule_status
    Given a rule has been disabled
    Given all rules on an event bus have been listed
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then a rule is enabled then an EventBridge rule is created
    Given rule_name in rule_status
    Given a rule has been disabled
    Given a rule has been enabled
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then targets are added to a rule then an EventBridge rule is deleted
    Given rule_name in rule_status
    Given a rule has been disabled
    Given targets have been added to a rule
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then targets are removed from a rule then an EventBridge rule is described
    Given rule_name in rule_status
    Given a rule has been disabled
    Given targets have been removed from a rule
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then targets for a rule are listed then all rules on an event bus are listed
    Given rule_name in rule_status
    Given a rule has been disabled
    Given targets for a rule have been listed
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then events are published to an event bus then a rule is enabled
    Given rule_name in rule_status
    Given a rule has been disabled
    Given events have been published to an event bus
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a rule is disabled then a dead-letter queue entry is retried or discarded then targets are added to a rule
    Given rule_name in rule_status
    Given a rule has been disabled
    Given a dead-letter queue entry has been retried or discarded
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then an event bus is created then targets for a rule are listed
    Given rule_name in rule_status
    Given targets have been added to a rule
    Given an event bus has been created
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then an event bus is deleted then events are published to an event bus
    Given rule_name in rule_status
    Given targets have been added to a rule
    Given an event bus has been deleted
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then an event bus is described then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    Given targets have been added to a rule
    Given an event bus has been described
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then all event buses are listed then an event bus is created
    Given rule_name in rule_status
    Given targets have been added to a rule
    Given all event buses have been listed
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then an EventBridge rule is created then an event bus is deleted
    Given rule_name in rule_status
    Given targets have been added to a rule
    Given an EventBridge rule has been created
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then an EventBridge rule is deleted then an event bus is described
    Given rule_name in rule_status
    Given targets have been added to a rule
    Given an EventBridge rule has been deleted
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then an EventBridge rule is described then all event buses are listed
    Given rule_name in rule_status
    Given targets have been added to a rule
    Given an EventBridge rule has been described
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then all rules on an event bus are listed then an EventBridge rule is created
    Given rule_name in rule_status
    Given targets have been added to a rule
    Given all rules on an event bus have been listed
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then a rule is enabled then an EventBridge rule is deleted
    Given rule_name in rule_status
    Given targets have been added to a rule
    Given a rule has been enabled
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then a rule is disabled then an EventBridge rule is described
    Given rule_name in rule_status
    Given targets have been added to a rule
    Given a rule has been disabled
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then targets are removed from a rule then all rules on an event bus are listed
    Given rule_name in rule_status
    Given targets have been added to a rule
    Given targets have been removed from a rule
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then targets for a rule are listed then a rule is enabled
    Given rule_name in rule_status
    Given targets have been added to a rule
    Given targets for a rule have been listed
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then events are published to an event bus then a rule is disabled
    Given rule_name in rule_status
    Given targets have been added to a rule
    Given events have been published to an event bus
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are added to a rule then a dead-letter queue entry is retried or discarded then targets are removed from a rule
    Given rule_name in rule_status
    Given targets have been added to a rule
    Given a dead-letter queue entry has been retried or discarded
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then an event bus is created then events are published to an event bus
    Given rule_name in rule_status
    Given targets have been removed from a rule
    Given an event bus has been created
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then an event bus is deleted then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    Given targets have been removed from a rule
    Given an event bus has been deleted
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then an event bus is described then an event bus is created
    Given rule_name in rule_status
    Given targets have been removed from a rule
    Given an event bus has been described
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then all event buses are listed then an event bus is deleted
    Given rule_name in rule_status
    Given targets have been removed from a rule
    Given all event buses have been listed
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then an EventBridge rule is created then an event bus is described
    Given rule_name in rule_status
    Given targets have been removed from a rule
    Given an EventBridge rule has been created
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then an EventBridge rule is deleted then all event buses are listed
    Given rule_name in rule_status
    Given targets have been removed from a rule
    Given an EventBridge rule has been deleted
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then an EventBridge rule is described then an EventBridge rule is created
    Given rule_name in rule_status
    Given targets have been removed from a rule
    Given an EventBridge rule has been described
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then all rules on an event bus are listed then an EventBridge rule is deleted
    Given rule_name in rule_status
    Given targets have been removed from a rule
    Given all rules on an event bus have been listed
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then a rule is enabled then an EventBridge rule is described
    Given rule_name in rule_status
    Given targets have been removed from a rule
    Given a rule has been enabled
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then a rule is disabled then all rules on an event bus are listed
    Given rule_name in rule_status
    Given targets have been removed from a rule
    Given a rule has been disabled
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then targets are added to a rule then a rule is enabled
    Given rule_name in rule_status
    Given targets have been removed from a rule
    Given targets have been added to a rule
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then targets for a rule are listed then a rule is disabled
    Given rule_name in rule_status
    Given targets have been removed from a rule
    Given targets for a rule have been listed
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then events are published to an event bus then targets are added to a rule
    Given rule_name in rule_status
    Given targets have been removed from a rule
    Given events have been published to an event bus
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets are removed from a rule then a dead-letter queue entry is retried or discarded then targets for a rule are listed
    Given rule_name in rule_status
    Given targets have been removed from a rule
    Given a dead-letter queue entry has been retried or discarded
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then an event bus is created then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    Given targets for a rule have been listed
    Given an event bus has been created
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then an event bus is deleted then an event bus is created
    Given rule_name in rule_status
    Given targets for a rule have been listed
    Given an event bus has been deleted
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then an event bus is described then an event bus is deleted
    Given rule_name in rule_status
    Given targets for a rule have been listed
    Given an event bus has been described
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then all event buses are listed then an event bus is described
    Given rule_name in rule_status
    Given targets for a rule have been listed
    Given all event buses have been listed
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then an EventBridge rule is created then all event buses are listed
    Given rule_name in rule_status
    Given targets for a rule have been listed
    Given an EventBridge rule has been created
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then an EventBridge rule is deleted then an EventBridge rule is created
    Given rule_name in rule_status
    Given targets for a rule have been listed
    Given an EventBridge rule has been deleted
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then an EventBridge rule is described then an EventBridge rule is deleted
    Given rule_name in rule_status
    Given targets for a rule have been listed
    Given an EventBridge rule has been described
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then all rules on an event bus are listed then an EventBridge rule is described
    Given rule_name in rule_status
    Given targets for a rule have been listed
    Given all rules on an event bus have been listed
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then a rule is enabled then all rules on an event bus are listed
    Given rule_name in rule_status
    Given targets for a rule have been listed
    Given a rule has been enabled
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then a rule is disabled then a rule is enabled
    Given rule_name in rule_status
    Given targets for a rule have been listed
    Given a rule has been disabled
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then targets are added to a rule then a rule is disabled
    Given rule_name in rule_status
    Given targets for a rule have been listed
    Given targets have been added to a rule
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then targets are removed from a rule then targets are added to a rule
    Given rule_name in rule_status
    Given targets for a rule have been listed
    Given targets have been removed from a rule
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then events are published to an event bus then targets are removed from a rule
    Given rule_name in rule_status
    Given targets for a rule have been listed
    Given events have been published to an event bus
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: targets for a rule are listed then a dead-letter queue entry is retried or discarded then events are published to an event bus
    Given rule_name in rule_status
    Given targets for a rule have been listed
    Given a dead-letter queue entry has been retried or discarded
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then an event bus is created then an event bus is deleted
    Given bus_name in bus_status
    Given events have been published to an event bus
    Given an event bus has been created
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then an event bus is deleted then an event bus is described
    Given bus_name in bus_status
    Given events have been published to an event bus
    Given an event bus has been deleted
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then an event bus is described then all event buses are listed
    Given bus_name in bus_status
    Given events have been published to an event bus
    Given an event bus has been described
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then all event buses are listed then an EventBridge rule is created
    Given bus_name in bus_status
    Given events have been published to an event bus
    Given all event buses have been listed
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then an EventBridge rule is created then an EventBridge rule is deleted
    Given bus_name in bus_status
    Given events have been published to an event bus
    Given an EventBridge rule has been created
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then an EventBridge rule is deleted then an EventBridge rule is described
    Given bus_name in bus_status
    Given events have been published to an event bus
    Given an EventBridge rule has been deleted
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then an EventBridge rule is described then all rules on an event bus are listed
    Given bus_name in bus_status
    Given events have been published to an event bus
    Given an EventBridge rule has been described
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then all rules on an event bus are listed then a rule is enabled
    Given bus_name in bus_status
    Given events have been published to an event bus
    Given all rules on an event bus have been listed
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then a rule is enabled then a rule is disabled
    Given bus_name in bus_status
    Given events have been published to an event bus
    Given a rule has been enabled
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then a rule is disabled then targets are added to a rule
    Given bus_name in bus_status
    Given events have been published to an event bus
    Given a rule has been disabled
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then targets are added to a rule then targets are removed from a rule
    Given bus_name in bus_status
    Given events have been published to an event bus
    Given targets have been added to a rule
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then targets are removed from a rule then targets for a rule are listed
    Given bus_name in bus_status
    Given events have been published to an event bus
    Given targets have been removed from a rule
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then targets for a rule are listed then a dead-letter queue entry is retried or discarded
    Given bus_name in bus_status
    Given events have been published to an event bus
    Given targets for a rule have been listed
    When a dead-letter queue entry is retried or discarded
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: events are published to an event bus then a dead-letter queue entry is retried or discarded then an event bus is created
    Given bus_name in bus_status
    Given events have been published to an event bus
    Given a dead-letter queue entry has been retried or discarded
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an event bus is created then an event bus is described
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    Given an event bus has been created
    When an event bus is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an event bus is deleted then all event buses are listed
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    Given an event bus has been deleted
    When all event buses are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an event bus is described then an EventBridge rule is created
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    Given an event bus has been described
    When an EventBridge rule is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then all event buses are listed then an EventBridge rule is deleted
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    Given all event buses have been listed
    When an EventBridge rule is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an EventBridge rule is created then an EventBridge rule is described
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    Given an EventBridge rule has been created
    When an EventBridge rule is described
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an EventBridge rule is deleted then all rules on an event bus are listed
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    Given an EventBridge rule has been deleted
    When all rules on an event bus are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an EventBridge rule is described then a rule is enabled
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    Given an EventBridge rule has been described
    When a rule is enabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then all rules on an event bus are listed then a rule is disabled
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    Given all rules on an event bus have been listed
    When a rule is disabled
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then a rule is enabled then targets are added to a rule
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    Given a rule has been enabled
    When targets are added to a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then a rule is disabled then targets are removed from a rule
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    Given a rule has been disabled
    When targets are removed from a rule
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then targets are added to a rule then targets for a rule are listed
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    Given targets have been added to a rule
    When targets for a rule are listed
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then targets are removed from a rule then events are published to an event bus
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    Given targets have been removed from a rule
    When events are published to an event bus
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then targets for a rule are listed then an event bus is created
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    Given targets for a rule have been listed
    When an event bus is created
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @sequence
  Scenario: a dead-letter queue entry is retried or discarded then events are published to an event bus then an event bus is deleted
    Given len(dlq) > 0
    Given a dead-letter queue entry has been retried or discarded
    Given events have been published to an event bus
    When an event bus is deleted
    Then every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity
