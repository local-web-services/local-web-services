@events @generated
Feature: Events - Action Sequences

  # Generated from FizzBee spec: events.fizz
  # Safety invariants: EventBusStatusValid, RuleStatusValid, RulePatternTypeValid, RuleBusExists, DefaultBusCannotBeDeleted, DeleteRuleRequiresNoTargets, RuleOnlyEnabledOnActiveBus, DeadLetterQueueBounded

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an event bus is created then an event bus is deleted
    Given name not in bus_status
    When an event bus is created
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then an event bus is described
    Given name not in bus_status
    When an event bus is created
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then all event buses are listed
    Given name not in bus_status
    When an event bus is created
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then an EventBridge rule is created
    Given name not in bus_status
    When an event bus is created
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then an EventBridge rule is deleted
    Given name not in bus_status
    When an event bus is created
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then an EventBridge rule is described
    Given name not in bus_status
    When an event bus is created
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then all rules on an event bus are listed
    Given name not in bus_status
    When an event bus is created
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then a rule is enabled
    Given name not in bus_status
    When an event bus is created
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then a rule is disabled
    Given name not in bus_status
    When an event bus is created
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then targets are added to a rule
    Given name not in bus_status
    When an event bus is created
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then targets are removed from a rule
    Given name not in bus_status
    When an event bus is created
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then targets for a rule are listed
    Given name not in bus_status
    When an event bus is created
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then events are published to an event bus
    Given name not in bus_status
    When an event bus is created
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then a dead-letter queue entry is retried or discarded
    Given name not in bus_status
    When an event bus is created
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then an event bus is created
    Given name is not 'default'
    When an event bus is deleted
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then an event bus is described
    Given name is not 'default'
    When an event bus is deleted
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then all event buses are listed
    Given name is not 'default'
    When an event bus is deleted
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then an EventBridge rule is created
    Given name is not 'default'
    When an event bus is deleted
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then an EventBridge rule is deleted
    Given name is not 'default'
    When an event bus is deleted
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then an EventBridge rule is described
    Given name is not 'default'
    When an event bus is deleted
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then all rules on an event bus are listed
    Given name is not 'default'
    When an event bus is deleted
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then a rule is enabled
    Given name is not 'default'
    When an event bus is deleted
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then a rule is disabled
    Given name is not 'default'
    When an event bus is deleted
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then targets are added to a rule
    Given name is not 'default'
    When an event bus is deleted
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then targets are removed from a rule
    Given name is not 'default'
    When an event bus is deleted
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then targets for a rule are listed
    Given name is not 'default'
    When an event bus is deleted
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then events are published to an event bus
    Given name is not 'default'
    When an event bus is deleted
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then a dead-letter queue entry is retried or discarded
    Given name is not 'default'
    When an event bus is deleted
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then an event bus is created
    Given name in bus_status
    When an event bus is described
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then an event bus is deleted
    Given name in bus_status
    When an event bus is described
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then all event buses are listed
    Given name in bus_status
    When an event bus is described
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then an EventBridge rule is created
    Given name in bus_status
    When an event bus is described
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then an EventBridge rule is deleted
    Given name in bus_status
    When an event bus is described
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then an EventBridge rule is described
    Given name in bus_status
    When an event bus is described
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then all rules on an event bus are listed
    Given name in bus_status
    When an event bus is described
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then a rule is enabled
    Given name in bus_status
    When an event bus is described
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then a rule is disabled
    Given name in bus_status
    When an event bus is described
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then targets are added to a rule
    Given name in bus_status
    When an event bus is described
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then targets are removed from a rule
    Given name in bus_status
    When an event bus is described
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then targets for a rule are listed
    Given name in bus_status
    When an event bus is described
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then events are published to an event bus
    Given name in bus_status
    When an event bus is described
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then a dead-letter queue entry is retried or discarded
    Given name in bus_status
    When an event bus is described
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then an event bus is created
    When all event buses are listed
    Given name not in bus_status
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then an event bus is deleted
    When all event buses are listed
    Given name is not 'default'
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then an event bus is described
    When all event buses are listed
    Given name in bus_status
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then an EventBridge rule is created
    When all event buses are listed
    Given rule_name not in rule_status
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then an EventBridge rule is deleted
    When all event buses are listed
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then an EventBridge rule is described
    When all event buses are listed
    Given rule_name in rule_status
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then all rules on an event bus are listed
    When all event buses are listed
    Given bus_name in bus_status
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then a rule is enabled
    When all event buses are listed
    Given rule_name in rule_status
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then a rule is disabled
    When all event buses are listed
    Given rule_name in rule_status
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then targets are added to a rule
    When all event buses are listed
    Given rule_name in rule_status
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then targets are removed from a rule
    When all event buses are listed
    Given rule_name in rule_status
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then targets for a rule are listed
    When all event buses are listed
    Given rule_name in rule_status
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then events are published to an event bus
    When all event buses are listed
    Given bus_name in bus_status
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then a dead-letter queue entry is retried or discarded
    When all event buses are listed
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then an event bus is created
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then an event bus is deleted
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then an event bus is described
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then all event buses are listed
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then an EventBridge rule is deleted
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then an EventBridge rule is described
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then all rules on an event bus are listed
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then a rule is enabled
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then a rule is disabled
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then targets are added to a rule
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then targets are removed from a rule
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then targets for a rule are listed
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then events are published to an event bus
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then a dead-letter queue entry is retried or discarded
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then an event bus is created
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then an event bus is deleted
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then an event bus is described
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then all event buses are listed
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then an EventBridge rule is created
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then an EventBridge rule is described
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then all rules on an event bus are listed
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then a rule is enabled
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then a rule is disabled
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then targets are added to a rule
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then targets are removed from a rule
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then targets for a rule are listed
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then events are published to an event bus
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then an event bus is created
    Given rule_name in rule_status
    When an EventBridge rule is described
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then an event bus is deleted
    Given rule_name in rule_status
    When an EventBridge rule is described
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then an event bus is described
    Given rule_name in rule_status
    When an EventBridge rule is described
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then all event buses are listed
    Given rule_name in rule_status
    When an EventBridge rule is described
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then an EventBridge rule is created
    Given rule_name in rule_status
    When an EventBridge rule is described
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then an EventBridge rule is deleted
    Given rule_name in rule_status
    When an EventBridge rule is described
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then all rules on an event bus are listed
    Given rule_name in rule_status
    When an EventBridge rule is described
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then a rule is enabled
    Given rule_name in rule_status
    When an EventBridge rule is described
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then a rule is disabled
    Given rule_name in rule_status
    When an EventBridge rule is described
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then targets are added to a rule
    Given rule_name in rule_status
    When an EventBridge rule is described
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then targets are removed from a rule
    Given rule_name in rule_status
    When an EventBridge rule is described
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then targets for a rule are listed
    Given rule_name in rule_status
    When an EventBridge rule is described
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then events are published to an event bus
    Given rule_name in rule_status
    When an EventBridge rule is described
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    When an EventBridge rule is described
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then an event bus is created
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then an event bus is deleted
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then an event bus is described
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then all event buses are listed
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then an EventBridge rule is created
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then an EventBridge rule is deleted
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then an EventBridge rule is described
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then a rule is enabled
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then a rule is disabled
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then targets are added to a rule
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then targets are removed from a rule
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then targets for a rule are listed
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then events are published to an event bus
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then a dead-letter queue entry is retried or discarded
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then an event bus is created
    Given rule_name in rule_status
    When a rule is enabled
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then an event bus is deleted
    Given rule_name in rule_status
    When a rule is enabled
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then an event bus is described
    Given rule_name in rule_status
    When a rule is enabled
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then all event buses are listed
    Given rule_name in rule_status
    When a rule is enabled
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then an EventBridge rule is created
    Given rule_name in rule_status
    When a rule is enabled
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then an EventBridge rule is deleted
    Given rule_name in rule_status
    When a rule is enabled
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then an EventBridge rule is described
    Given rule_name in rule_status
    When a rule is enabled
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then all rules on an event bus are listed
    Given rule_name in rule_status
    When a rule is enabled
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then a rule is disabled
    Given rule_name in rule_status
    When a rule is enabled
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then targets are added to a rule
    Given rule_name in rule_status
    When a rule is enabled
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then targets are removed from a rule
    Given rule_name in rule_status
    When a rule is enabled
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then targets for a rule are listed
    Given rule_name in rule_status
    When a rule is enabled
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then events are published to an event bus
    Given rule_name in rule_status
    When a rule is enabled
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    When a rule is enabled
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then an event bus is created
    Given rule_name in rule_status
    When a rule is disabled
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then an event bus is deleted
    Given rule_name in rule_status
    When a rule is disabled
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then an event bus is described
    Given rule_name in rule_status
    When a rule is disabled
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then all event buses are listed
    Given rule_name in rule_status
    When a rule is disabled
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then an EventBridge rule is created
    Given rule_name in rule_status
    When a rule is disabled
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then an EventBridge rule is deleted
    Given rule_name in rule_status
    When a rule is disabled
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then an EventBridge rule is described
    Given rule_name in rule_status
    When a rule is disabled
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then all rules on an event bus are listed
    Given rule_name in rule_status
    When a rule is disabled
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then a rule is enabled
    Given rule_name in rule_status
    When a rule is disabled
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then targets are added to a rule
    Given rule_name in rule_status
    When a rule is disabled
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then targets are removed from a rule
    Given rule_name in rule_status
    When a rule is disabled
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then targets for a rule are listed
    Given rule_name in rule_status
    When a rule is disabled
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then events are published to an event bus
    Given rule_name in rule_status
    When a rule is disabled
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    When a rule is disabled
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then an event bus is created
    Given rule_name in rule_status
    When targets are added to a rule
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then an event bus is deleted
    Given rule_name in rule_status
    When targets are added to a rule
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then an event bus is described
    Given rule_name in rule_status
    When targets are added to a rule
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then all event buses are listed
    Given rule_name in rule_status
    When targets are added to a rule
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then an EventBridge rule is created
    Given rule_name in rule_status
    When targets are added to a rule
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then an EventBridge rule is deleted
    Given rule_name in rule_status
    When targets are added to a rule
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then an EventBridge rule is described
    Given rule_name in rule_status
    When targets are added to a rule
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then all rules on an event bus are listed
    Given rule_name in rule_status
    When targets are added to a rule
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then a rule is enabled
    Given rule_name in rule_status
    When targets are added to a rule
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then a rule is disabled
    Given rule_name in rule_status
    When targets are added to a rule
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then targets are removed from a rule
    Given rule_name in rule_status
    When targets are added to a rule
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then targets for a rule are listed
    Given rule_name in rule_status
    When targets are added to a rule
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then events are published to an event bus
    Given rule_name in rule_status
    When targets are added to a rule
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    When targets are added to a rule
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then an event bus is created
    Given rule_name in rule_status
    When targets are removed from a rule
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then an event bus is deleted
    Given rule_name in rule_status
    When targets are removed from a rule
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then an event bus is described
    Given rule_name in rule_status
    When targets are removed from a rule
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then all event buses are listed
    Given rule_name in rule_status
    When targets are removed from a rule
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then an EventBridge rule is created
    Given rule_name in rule_status
    When targets are removed from a rule
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then an EventBridge rule is deleted
    Given rule_name in rule_status
    When targets are removed from a rule
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then an EventBridge rule is described
    Given rule_name in rule_status
    When targets are removed from a rule
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then all rules on an event bus are listed
    Given rule_name in rule_status
    When targets are removed from a rule
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then a rule is enabled
    Given rule_name in rule_status
    When targets are removed from a rule
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then a rule is disabled
    Given rule_name in rule_status
    When targets are removed from a rule
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then targets are added to a rule
    Given rule_name in rule_status
    When targets are removed from a rule
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then targets for a rule are listed
    Given rule_name in rule_status
    When targets are removed from a rule
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then events are published to an event bus
    Given rule_name in rule_status
    When targets are removed from a rule
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    When targets are removed from a rule
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then an event bus is created
    Given rule_name in rule_status
    When targets for a rule are listed
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then an event bus is deleted
    Given rule_name in rule_status
    When targets for a rule are listed
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then an event bus is described
    Given rule_name in rule_status
    When targets for a rule are listed
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then all event buses are listed
    Given rule_name in rule_status
    When targets for a rule are listed
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then an EventBridge rule is created
    Given rule_name in rule_status
    When targets for a rule are listed
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then an EventBridge rule is deleted
    Given rule_name in rule_status
    When targets for a rule are listed
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then an EventBridge rule is described
    Given rule_name in rule_status
    When targets for a rule are listed
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then all rules on an event bus are listed
    Given rule_name in rule_status
    When targets for a rule are listed
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then a rule is enabled
    Given rule_name in rule_status
    When targets for a rule are listed
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then a rule is disabled
    Given rule_name in rule_status
    When targets for a rule are listed
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then targets are added to a rule
    Given rule_name in rule_status
    When targets for a rule are listed
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then targets are removed from a rule
    Given rule_name in rule_status
    When targets for a rule are listed
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then events are published to an event bus
    Given rule_name in rule_status
    When targets for a rule are listed
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    When targets for a rule are listed
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then an event bus is created
    Given bus_name in bus_status
    When events are published to an event bus
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then an event bus is deleted
    Given bus_name in bus_status
    When events are published to an event bus
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then an event bus is described
    Given bus_name in bus_status
    When events are published to an event bus
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then all event buses are listed
    Given bus_name in bus_status
    When events are published to an event bus
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then an EventBridge rule is created
    Given bus_name in bus_status
    When events are published to an event bus
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then an EventBridge rule is deleted
    Given bus_name in bus_status
    When events are published to an event bus
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then an EventBridge rule is described
    Given bus_name in bus_status
    When events are published to an event bus
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then all rules on an event bus are listed
    Given bus_name in bus_status
    When events are published to an event bus
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then a rule is enabled
    Given bus_name in bus_status
    When events are published to an event bus
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then a rule is disabled
    Given bus_name in bus_status
    When events are published to an event bus
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then targets are added to a rule
    Given bus_name in bus_status
    When events are published to an event bus
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then targets are removed from a rule
    Given bus_name in bus_status
    When events are published to an event bus
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then targets for a rule are listed
    Given bus_name in bus_status
    When events are published to an event bus
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then a dead-letter queue entry is retried or discarded
    Given bus_name in bus_status
    When events are published to an event bus
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an event bus is created
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an event bus is deleted
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an event bus is described
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then all event buses are listed
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an EventBridge rule is created
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an EventBridge rule is deleted
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an EventBridge rule is described
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then all rules on an event bus are listed
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then a rule is enabled
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then a rule is disabled
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then targets are added to a rule
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then targets are removed from a rule
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then targets for a rule are listed
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then events are published to an event bus
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then an event bus is deleted then an event bus is described
    Given name not in bus_status
    When an event bus is created
    When an event bus is deleted
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then an event bus is described then all event buses are listed
    Given name not in bus_status
    When an event bus is created
    When an event bus is described
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then all event buses are listed then an EventBridge rule is created
    Given name not in bus_status
    When an event bus is created
    When all event buses are listed
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then an EventBridge rule is created then an EventBridge rule is deleted
    Given name not in bus_status
    When an event bus is created
    When an EventBridge rule is created
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then an EventBridge rule is deleted then an EventBridge rule is described
    Given name not in bus_status
    When an event bus is created
    When an EventBridge rule is deleted
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then an EventBridge rule is described then all rules on an event bus are listed
    Given name not in bus_status
    When an event bus is created
    When an EventBridge rule is described
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then all rules on an event bus are listed then a rule is enabled
    Given name not in bus_status
    When an event bus is created
    When all rules on an event bus are listed
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then a rule is enabled then a rule is disabled
    Given name not in bus_status
    When an event bus is created
    When a rule is enabled
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then a rule is disabled then targets are added to a rule
    Given name not in bus_status
    When an event bus is created
    When a rule is disabled
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then targets are added to a rule then targets are removed from a rule
    Given name not in bus_status
    When an event bus is created
    When targets are added to a rule
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then targets are removed from a rule then targets for a rule are listed
    Given name not in bus_status
    When an event bus is created
    When targets are removed from a rule
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then targets for a rule are listed then events are published to an event bus
    Given name not in bus_status
    When an event bus is created
    When targets for a rule are listed
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then events are published to an event bus then a dead-letter queue entry is retried or discarded
    Given name not in bus_status
    When an event bus is created
    When events are published to an event bus
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is created then a dead-letter queue entry is retried or discarded then an event bus is deleted
    Given name not in bus_status
    When an event bus is created
    When a dead-letter queue entry is retried or discarded
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then an event bus is created then all event buses are listed
    Given name is not 'default'
    When an event bus is deleted
    When an event bus is created
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then an event bus is described then an EventBridge rule is created
    Given name is not 'default'
    When an event bus is deleted
    When an event bus is described
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then all event buses are listed then an EventBridge rule is deleted
    Given name is not 'default'
    When an event bus is deleted
    When all event buses are listed
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then an EventBridge rule is created then an EventBridge rule is described
    Given name is not 'default'
    When an event bus is deleted
    When an EventBridge rule is created
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then an EventBridge rule is deleted then all rules on an event bus are listed
    Given name is not 'default'
    When an event bus is deleted
    When an EventBridge rule is deleted
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then an EventBridge rule is described then a rule is enabled
    Given name is not 'default'
    When an event bus is deleted
    When an EventBridge rule is described
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then all rules on an event bus are listed then a rule is disabled
    Given name is not 'default'
    When an event bus is deleted
    When all rules on an event bus are listed
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then a rule is enabled then targets are added to a rule
    Given name is not 'default'
    When an event bus is deleted
    When a rule is enabled
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then a rule is disabled then targets are removed from a rule
    Given name is not 'default'
    When an event bus is deleted
    When a rule is disabled
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then targets are added to a rule then targets for a rule are listed
    Given name is not 'default'
    When an event bus is deleted
    When targets are added to a rule
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then targets are removed from a rule then events are published to an event bus
    Given name is not 'default'
    When an event bus is deleted
    When targets are removed from a rule
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then targets for a rule are listed then a dead-letter queue entry is retried or discarded
    Given name is not 'default'
    When an event bus is deleted
    When targets for a rule are listed
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then events are published to an event bus then an event bus is created
    Given name is not 'default'
    When an event bus is deleted
    When events are published to an event bus
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is deleted then a dead-letter queue entry is retried or discarded then an event bus is described
    Given name is not 'default'
    When an event bus is deleted
    When a dead-letter queue entry is retried or discarded
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then an event bus is created then an EventBridge rule is created
    Given name in bus_status
    When an event bus is described
    When an event bus is created
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then an event bus is deleted then an EventBridge rule is deleted
    Given name in bus_status
    When an event bus is described
    When an event bus is deleted
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then all event buses are listed then an EventBridge rule is described
    Given name in bus_status
    When an event bus is described
    When all event buses are listed
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then an EventBridge rule is created then all rules on an event bus are listed
    Given name in bus_status
    When an event bus is described
    When an EventBridge rule is created
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then an EventBridge rule is deleted then a rule is enabled
    Given name in bus_status
    When an event bus is described
    When an EventBridge rule is deleted
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then an EventBridge rule is described then a rule is disabled
    Given name in bus_status
    When an event bus is described
    When an EventBridge rule is described
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then all rules on an event bus are listed then targets are added to a rule
    Given name in bus_status
    When an event bus is described
    When all rules on an event bus are listed
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then a rule is enabled then targets are removed from a rule
    Given name in bus_status
    When an event bus is described
    When a rule is enabled
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then a rule is disabled then targets for a rule are listed
    Given name in bus_status
    When an event bus is described
    When a rule is disabled
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then targets are added to a rule then events are published to an event bus
    Given name in bus_status
    When an event bus is described
    When targets are added to a rule
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then targets are removed from a rule then a dead-letter queue entry is retried or discarded
    Given name in bus_status
    When an event bus is described
    When targets are removed from a rule
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then targets for a rule are listed then an event bus is created
    Given name in bus_status
    When an event bus is described
    When targets for a rule are listed
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then events are published to an event bus then an event bus is deleted
    Given name in bus_status
    When an event bus is described
    When events are published to an event bus
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an event bus is described then a dead-letter queue entry is retried or discarded then all event buses are listed
    Given name in bus_status
    When an event bus is described
    When a dead-letter queue entry is retried or discarded
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then an event bus is created then an EventBridge rule is deleted
    When all event buses are listed
    Given name not in bus_status
    When an event bus is created
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then an event bus is deleted then an EventBridge rule is described
    When all event buses are listed
    Given name is not 'default'
    When an event bus is deleted
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then an event bus is described then all rules on an event bus are listed
    When all event buses are listed
    Given name in bus_status
    When an event bus is described
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then an EventBridge rule is created then a rule is enabled
    When all event buses are listed
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then an EventBridge rule is deleted then a rule is disabled
    When all event buses are listed
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then an EventBridge rule is described then targets are added to a rule
    When all event buses are listed
    Given rule_name in rule_status
    When an EventBridge rule is described
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then all rules on an event bus are listed then targets are removed from a rule
    When all event buses are listed
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then a rule is enabled then targets for a rule are listed
    When all event buses are listed
    Given rule_name in rule_status
    When a rule is enabled
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then a rule is disabled then events are published to an event bus
    When all event buses are listed
    Given rule_name in rule_status
    When a rule is disabled
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then targets are added to a rule then a dead-letter queue entry is retried or discarded
    When all event buses are listed
    Given rule_name in rule_status
    When targets are added to a rule
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then targets are removed from a rule then an event bus is created
    When all event buses are listed
    Given rule_name in rule_status
    When targets are removed from a rule
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then targets for a rule are listed then an event bus is deleted
    When all event buses are listed
    Given rule_name in rule_status
    When targets for a rule are listed
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then events are published to an event bus then an event bus is described
    When all event buses are listed
    Given bus_name in bus_status
    When events are published to an event bus
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all event buses are listed then a dead-letter queue entry is retried or discarded then an EventBridge rule is created
    When all event buses are listed
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then an event bus is created then an EventBridge rule is described
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When an event bus is created
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then an event bus is deleted then all rules on an event bus are listed
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When an event bus is deleted
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then an event bus is described then a rule is enabled
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When an event bus is described
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then all event buses are listed then a rule is disabled
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When all event buses are listed
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then an EventBridge rule is deleted then targets are added to a rule
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When an EventBridge rule is deleted
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then an EventBridge rule is described then targets are removed from a rule
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When an EventBridge rule is described
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then all rules on an event bus are listed then targets for a rule are listed
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When all rules on an event bus are listed
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then a rule is enabled then events are published to an event bus
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When a rule is enabled
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then a rule is disabled then a dead-letter queue entry is retried or discarded
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When a rule is disabled
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then targets are added to a rule then an event bus is created
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When targets are added to a rule
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then targets are removed from a rule then an event bus is deleted
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When targets are removed from a rule
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then targets for a rule are listed then an event bus is described
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When targets for a rule are listed
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then events are published to an event bus then all event buses are listed
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When events are published to an event bus
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is created then a dead-letter queue entry is retried or discarded then an EventBridge rule is deleted
    Given rule_name not in rule_status
    When an EventBridge rule is created
    When a dead-letter queue entry is retried or discarded
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then an event bus is created then all rules on an event bus are listed
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When an event bus is created
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then an event bus is deleted then a rule is enabled
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When an event bus is deleted
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then an event bus is described then a rule is disabled
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When an event bus is described
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then all event buses are listed then targets are added to a rule
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When all event buses are listed
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then an EventBridge rule is created then targets are removed from a rule
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When an EventBridge rule is created
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then an EventBridge rule is described then targets for a rule are listed
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When an EventBridge rule is described
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then all rules on an event bus are listed then events are published to an event bus
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When all rules on an event bus are listed
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then a rule is enabled then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When a rule is enabled
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then a rule is disabled then an event bus is created
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When a rule is disabled
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then targets are added to a rule then an event bus is deleted
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When targets are added to a rule
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then targets are removed from a rule then an event bus is described
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When targets are removed from a rule
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then targets for a rule are listed then all event buses are listed
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When targets for a rule are listed
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then events are published to an event bus then an EventBridge rule is created
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When events are published to an event bus
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is deleted then a dead-letter queue entry is retried or discarded then an EventBridge rule is described
    Given rule_name in rule_status
    When an EventBridge rule is deleted
    When a dead-letter queue entry is retried or discarded
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then an event bus is created then a rule is enabled
    Given rule_name in rule_status
    When an EventBridge rule is described
    When an event bus is created
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then an event bus is deleted then a rule is disabled
    Given rule_name in rule_status
    When an EventBridge rule is described
    When an event bus is deleted
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then an event bus is described then targets are added to a rule
    Given rule_name in rule_status
    When an EventBridge rule is described
    When an event bus is described
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then all event buses are listed then targets are removed from a rule
    Given rule_name in rule_status
    When an EventBridge rule is described
    When all event buses are listed
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then an EventBridge rule is created then targets for a rule are listed
    Given rule_name in rule_status
    When an EventBridge rule is described
    When an EventBridge rule is created
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then an EventBridge rule is deleted then events are published to an event bus
    Given rule_name in rule_status
    When an EventBridge rule is described
    When an EventBridge rule is deleted
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then all rules on an event bus are listed then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    When an EventBridge rule is described
    When all rules on an event bus are listed
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then a rule is enabled then an event bus is created
    Given rule_name in rule_status
    When an EventBridge rule is described
    When a rule is enabled
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then a rule is disabled then an event bus is deleted
    Given rule_name in rule_status
    When an EventBridge rule is described
    When a rule is disabled
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then targets are added to a rule then an event bus is described
    Given rule_name in rule_status
    When an EventBridge rule is described
    When targets are added to a rule
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then targets are removed from a rule then all event buses are listed
    Given rule_name in rule_status
    When an EventBridge rule is described
    When targets are removed from a rule
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then targets for a rule are listed then an EventBridge rule is created
    Given rule_name in rule_status
    When an EventBridge rule is described
    When targets for a rule are listed
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then events are published to an event bus then an EventBridge rule is deleted
    Given rule_name in rule_status
    When an EventBridge rule is described
    When events are published to an event bus
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: an EventBridge rule is described then a dead-letter queue entry is retried or discarded then all rules on an event bus are listed
    Given rule_name in rule_status
    When an EventBridge rule is described
    When a dead-letter queue entry is retried or discarded
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then an event bus is created then a rule is disabled
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When an event bus is created
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then an event bus is deleted then targets are added to a rule
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When an event bus is deleted
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then an event bus is described then targets are removed from a rule
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When an event bus is described
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then all event buses are listed then targets for a rule are listed
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When all event buses are listed
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then an EventBridge rule is created then events are published to an event bus
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When an EventBridge rule is created
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then an EventBridge rule is deleted then a dead-letter queue entry is retried or discarded
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When an EventBridge rule is deleted
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then an EventBridge rule is described then an event bus is created
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When an EventBridge rule is described
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then a rule is enabled then an event bus is deleted
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When a rule is enabled
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then a rule is disabled then an event bus is described
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When a rule is disabled
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then targets are added to a rule then all event buses are listed
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When targets are added to a rule
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then targets are removed from a rule then an EventBridge rule is created
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When targets are removed from a rule
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then targets for a rule are listed then an EventBridge rule is deleted
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When targets for a rule are listed
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then events are published to an event bus then an EventBridge rule is described
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When events are published to an event bus
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: all rules on an event bus are listed then a dead-letter queue entry is retried or discarded then a rule is enabled
    Given bus_name in bus_status
    When all rules on an event bus are listed
    When a dead-letter queue entry is retried or discarded
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then an event bus is created then targets are added to a rule
    Given rule_name in rule_status
    When a rule is enabled
    When an event bus is created
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then an event bus is deleted then targets are removed from a rule
    Given rule_name in rule_status
    When a rule is enabled
    When an event bus is deleted
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then an event bus is described then targets for a rule are listed
    Given rule_name in rule_status
    When a rule is enabled
    When an event bus is described
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then all event buses are listed then events are published to an event bus
    Given rule_name in rule_status
    When a rule is enabled
    When all event buses are listed
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then an EventBridge rule is created then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    When a rule is enabled
    When an EventBridge rule is created
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then an EventBridge rule is deleted then an event bus is created
    Given rule_name in rule_status
    When a rule is enabled
    When an EventBridge rule is deleted
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then an EventBridge rule is described then an event bus is deleted
    Given rule_name in rule_status
    When a rule is enabled
    When an EventBridge rule is described
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then all rules on an event bus are listed then an event bus is described
    Given rule_name in rule_status
    When a rule is enabled
    When all rules on an event bus are listed
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then a rule is disabled then all event buses are listed
    Given rule_name in rule_status
    When a rule is enabled
    When a rule is disabled
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then targets are added to a rule then an EventBridge rule is created
    Given rule_name in rule_status
    When a rule is enabled
    When targets are added to a rule
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then targets are removed from a rule then an EventBridge rule is deleted
    Given rule_name in rule_status
    When a rule is enabled
    When targets are removed from a rule
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then targets for a rule are listed then an EventBridge rule is described
    Given rule_name in rule_status
    When a rule is enabled
    When targets for a rule are listed
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then events are published to an event bus then all rules on an event bus are listed
    Given rule_name in rule_status
    When a rule is enabled
    When events are published to an event bus
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is enabled then a dead-letter queue entry is retried or discarded then a rule is disabled
    Given rule_name in rule_status
    When a rule is enabled
    When a dead-letter queue entry is retried or discarded
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then an event bus is created then targets are removed from a rule
    Given rule_name in rule_status
    When a rule is disabled
    When an event bus is created
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then an event bus is deleted then targets for a rule are listed
    Given rule_name in rule_status
    When a rule is disabled
    When an event bus is deleted
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then an event bus is described then events are published to an event bus
    Given rule_name in rule_status
    When a rule is disabled
    When an event bus is described
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then all event buses are listed then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    When a rule is disabled
    When all event buses are listed
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then an EventBridge rule is created then an event bus is created
    Given rule_name in rule_status
    When a rule is disabled
    When an EventBridge rule is created
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then an EventBridge rule is deleted then an event bus is deleted
    Given rule_name in rule_status
    When a rule is disabled
    When an EventBridge rule is deleted
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then an EventBridge rule is described then an event bus is described
    Given rule_name in rule_status
    When a rule is disabled
    When an EventBridge rule is described
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then all rules on an event bus are listed then all event buses are listed
    Given rule_name in rule_status
    When a rule is disabled
    When all rules on an event bus are listed
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then a rule is enabled then an EventBridge rule is created
    Given rule_name in rule_status
    When a rule is disabled
    When a rule is enabled
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then targets are added to a rule then an EventBridge rule is deleted
    Given rule_name in rule_status
    When a rule is disabled
    When targets are added to a rule
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then targets are removed from a rule then an EventBridge rule is described
    Given rule_name in rule_status
    When a rule is disabled
    When targets are removed from a rule
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then targets for a rule are listed then all rules on an event bus are listed
    Given rule_name in rule_status
    When a rule is disabled
    When targets for a rule are listed
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then events are published to an event bus then a rule is enabled
    Given rule_name in rule_status
    When a rule is disabled
    When events are published to an event bus
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a rule is disabled then a dead-letter queue entry is retried or discarded then targets are added to a rule
    Given rule_name in rule_status
    When a rule is disabled
    When a dead-letter queue entry is retried or discarded
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then an event bus is created then targets for a rule are listed
    Given rule_name in rule_status
    When targets are added to a rule
    When an event bus is created
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then an event bus is deleted then events are published to an event bus
    Given rule_name in rule_status
    When targets are added to a rule
    When an event bus is deleted
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then an event bus is described then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    When targets are added to a rule
    When an event bus is described
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then all event buses are listed then an event bus is created
    Given rule_name in rule_status
    When targets are added to a rule
    When all event buses are listed
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then an EventBridge rule is created then an event bus is deleted
    Given rule_name in rule_status
    When targets are added to a rule
    When an EventBridge rule is created
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then an EventBridge rule is deleted then an event bus is described
    Given rule_name in rule_status
    When targets are added to a rule
    When an EventBridge rule is deleted
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then an EventBridge rule is described then all event buses are listed
    Given rule_name in rule_status
    When targets are added to a rule
    When an EventBridge rule is described
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then all rules on an event bus are listed then an EventBridge rule is created
    Given rule_name in rule_status
    When targets are added to a rule
    When all rules on an event bus are listed
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then a rule is enabled then an EventBridge rule is deleted
    Given rule_name in rule_status
    When targets are added to a rule
    When a rule is enabled
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then a rule is disabled then an EventBridge rule is described
    Given rule_name in rule_status
    When targets are added to a rule
    When a rule is disabled
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then targets are removed from a rule then all rules on an event bus are listed
    Given rule_name in rule_status
    When targets are added to a rule
    When targets are removed from a rule
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then targets for a rule are listed then a rule is enabled
    Given rule_name in rule_status
    When targets are added to a rule
    When targets for a rule are listed
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then events are published to an event bus then a rule is disabled
    Given rule_name in rule_status
    When targets are added to a rule
    When events are published to an event bus
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are added to a rule then a dead-letter queue entry is retried or discarded then targets are removed from a rule
    Given rule_name in rule_status
    When targets are added to a rule
    When a dead-letter queue entry is retried or discarded
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then an event bus is created then events are published to an event bus
    Given rule_name in rule_status
    When targets are removed from a rule
    When an event bus is created
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then an event bus is deleted then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    When targets are removed from a rule
    When an event bus is deleted
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then an event bus is described then an event bus is created
    Given rule_name in rule_status
    When targets are removed from a rule
    When an event bus is described
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then all event buses are listed then an event bus is deleted
    Given rule_name in rule_status
    When targets are removed from a rule
    When all event buses are listed
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then an EventBridge rule is created then an event bus is described
    Given rule_name in rule_status
    When targets are removed from a rule
    When an EventBridge rule is created
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then an EventBridge rule is deleted then all event buses are listed
    Given rule_name in rule_status
    When targets are removed from a rule
    When an EventBridge rule is deleted
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then an EventBridge rule is described then an EventBridge rule is created
    Given rule_name in rule_status
    When targets are removed from a rule
    When an EventBridge rule is described
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then all rules on an event bus are listed then an EventBridge rule is deleted
    Given rule_name in rule_status
    When targets are removed from a rule
    When all rules on an event bus are listed
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then a rule is enabled then an EventBridge rule is described
    Given rule_name in rule_status
    When targets are removed from a rule
    When a rule is enabled
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then a rule is disabled then all rules on an event bus are listed
    Given rule_name in rule_status
    When targets are removed from a rule
    When a rule is disabled
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then targets are added to a rule then a rule is enabled
    Given rule_name in rule_status
    When targets are removed from a rule
    When targets are added to a rule
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then targets for a rule are listed then a rule is disabled
    Given rule_name in rule_status
    When targets are removed from a rule
    When targets for a rule are listed
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then events are published to an event bus then targets are added to a rule
    Given rule_name in rule_status
    When targets are removed from a rule
    When events are published to an event bus
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets are removed from a rule then a dead-letter queue entry is retried or discarded then targets for a rule are listed
    Given rule_name in rule_status
    When targets are removed from a rule
    When a dead-letter queue entry is retried or discarded
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then an event bus is created then a dead-letter queue entry is retried or discarded
    Given rule_name in rule_status
    When targets for a rule are listed
    When an event bus is created
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then an event bus is deleted then an event bus is created
    Given rule_name in rule_status
    When targets for a rule are listed
    When an event bus is deleted
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then an event bus is described then an event bus is deleted
    Given rule_name in rule_status
    When targets for a rule are listed
    When an event bus is described
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then all event buses are listed then an event bus is described
    Given rule_name in rule_status
    When targets for a rule are listed
    When all event buses are listed
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then an EventBridge rule is created then all event buses are listed
    Given rule_name in rule_status
    When targets for a rule are listed
    When an EventBridge rule is created
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then an EventBridge rule is deleted then an EventBridge rule is created
    Given rule_name in rule_status
    When targets for a rule are listed
    When an EventBridge rule is deleted
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then an EventBridge rule is described then an EventBridge rule is deleted
    Given rule_name in rule_status
    When targets for a rule are listed
    When an EventBridge rule is described
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then all rules on an event bus are listed then an EventBridge rule is described
    Given rule_name in rule_status
    When targets for a rule are listed
    When all rules on an event bus are listed
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then a rule is enabled then all rules on an event bus are listed
    Given rule_name in rule_status
    When targets for a rule are listed
    When a rule is enabled
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then a rule is disabled then a rule is enabled
    Given rule_name in rule_status
    When targets for a rule are listed
    When a rule is disabled
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then targets are added to a rule then a rule is disabled
    Given rule_name in rule_status
    When targets for a rule are listed
    When targets are added to a rule
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then targets are removed from a rule then targets are added to a rule
    Given rule_name in rule_status
    When targets for a rule are listed
    When targets are removed from a rule
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then events are published to an event bus then targets are removed from a rule
    Given rule_name in rule_status
    When targets for a rule are listed
    When events are published to an event bus
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: targets for a rule are listed then a dead-letter queue entry is retried or discarded then events are published to an event bus
    Given rule_name in rule_status
    When targets for a rule are listed
    When a dead-letter queue entry is retried or discarded
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then an event bus is created then an event bus is deleted
    Given bus_name in bus_status
    When events are published to an event bus
    When an event bus is created
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then an event bus is deleted then an event bus is described
    Given bus_name in bus_status
    When events are published to an event bus
    When an event bus is deleted
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then an event bus is described then all event buses are listed
    Given bus_name in bus_status
    When events are published to an event bus
    When an event bus is described
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then all event buses are listed then an EventBridge rule is created
    Given bus_name in bus_status
    When events are published to an event bus
    When all event buses are listed
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then an EventBridge rule is created then an EventBridge rule is deleted
    Given bus_name in bus_status
    When events are published to an event bus
    When an EventBridge rule is created
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then an EventBridge rule is deleted then an EventBridge rule is described
    Given bus_name in bus_status
    When events are published to an event bus
    When an EventBridge rule is deleted
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then an EventBridge rule is described then all rules on an event bus are listed
    Given bus_name in bus_status
    When events are published to an event bus
    When an EventBridge rule is described
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then all rules on an event bus are listed then a rule is enabled
    Given bus_name in bus_status
    When events are published to an event bus
    When all rules on an event bus are listed
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then a rule is enabled then a rule is disabled
    Given bus_name in bus_status
    When events are published to an event bus
    When a rule is enabled
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then a rule is disabled then targets are added to a rule
    Given bus_name in bus_status
    When events are published to an event bus
    When a rule is disabled
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then targets are added to a rule then targets are removed from a rule
    Given bus_name in bus_status
    When events are published to an event bus
    When targets are added to a rule
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then targets are removed from a rule then targets for a rule are listed
    Given bus_name in bus_status
    When events are published to an event bus
    When targets are removed from a rule
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then targets for a rule are listed then a dead-letter queue entry is retried or discarded
    Given bus_name in bus_status
    When events are published to an event bus
    When targets for a rule are listed
    When a dead-letter queue entry is retried or discarded
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: events are published to an event bus then a dead-letter queue entry is retried or discarded then an event bus is created
    Given bus_name in bus_status
    When events are published to an event bus
    When a dead-letter queue entry is retried or discarded
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an event bus is created then an event bus is described
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When an event bus is created
    When an event bus is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an event bus is deleted then all event buses are listed
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When an event bus is deleted
    When all event buses are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an event bus is described then an EventBridge rule is created
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When an event bus is described
    When an EventBridge rule is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then all event buses are listed then an EventBridge rule is deleted
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When all event buses are listed
    When an EventBridge rule is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an EventBridge rule is created then an EventBridge rule is described
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When an EventBridge rule is created
    When an EventBridge rule is described
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an EventBridge rule is deleted then all rules on an event bus are listed
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When an EventBridge rule is deleted
    When all rules on an event bus are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then an EventBridge rule is described then a rule is enabled
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When an EventBridge rule is described
    When a rule is enabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then all rules on an event bus are listed then a rule is disabled
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When all rules on an event bus are listed
    When a rule is disabled
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then a rule is enabled then targets are added to a rule
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When a rule is enabled
    When targets are added to a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then a rule is disabled then targets are removed from a rule
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When a rule is disabled
    When targets are removed from a rule
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then targets are added to a rule then targets for a rule are listed
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When targets are added to a rule
    When targets for a rule are listed
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then targets are removed from a rule then events are published to an event bus
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When targets are removed from a rule
    When events are published to an event bus
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then targets for a rule are listed then an event bus is created
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When targets for a rule are listed
    When an event bus is created
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity

  @exhaustive @sequence
  Scenario: a dead-letter queue entry is retried or discarded then events are published to an event bus then an event bus is deleted
    Given len(dlq) > 0
    When a dead-letter queue entry is retried or discarded
    When events are published to an event bus
    When an event bus is deleted
    And every event bus has a valid status ("ACTIVE" or "DELETED")
    And every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")
    And every rule has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")
    And every rule references an event bus that exists
    And the default event bus cannot be deleted
    And a rule can only be deleted when it has no targets
    And no enabled rule references a deleted event bus
    And the dead-letter queue never exceeds its bounded capacity
