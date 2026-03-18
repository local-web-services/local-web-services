@eventssns @generated
Feature: EventsSns - Action Sequences

  # Generated from FizzBee spec: events_sns.fizz
  # Safety invariants: RuleReferencesActiveBus, MessageRequiresActiveTopic

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an "SNS" topic is created
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an "SNS" topic is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is created to route matching events to an "SNS" topic
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is created to route matching events to an "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event is published to the bus and routed to the target "SNS" topic
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an event is published to the bus and routed to the target "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a subscriber consumes a message from the "SNS" topic
    Given bid not in bus_status
    When an EventBridge event bus is created
    When a subscriber consumes a message from the "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an EventBridge event bus is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an EventBridge rule is created to route matching events to an "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When an EventBridge rule is created to route matching events to an "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an event is published to the bus and routed to the target "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When an event is published to the bus and routed to the target "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a subscriber consumes a message from the "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When a subscriber consumes a message from the "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then an EventBridge event bus is created
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then an "SNS" topic is created
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When an "SNS" topic is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then an event is published to the bus and routed to the target "SNS" topic
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When an event is published to the bus and routed to the target "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then a subscriber consumes a message from the "SNS" topic
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When a subscriber consumes a message from the "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then an EventBridge event bus is created
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SNS" topic
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then an "SNS" topic is created
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SNS" topic
    When an "SNS" topic is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then an EventBridge rule is created to route matching events to an "SNS" topic
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SNS" topic
    When an EventBridge rule is created to route matching events to an "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then a subscriber consumes a message from the "SNS" topic
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SNS" topic
    When a subscriber consumes a message from the "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an EventBridge event bus is created
    Given mid in msg_status
    When a subscriber consumes a message from the "SNS" topic
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an "SNS" topic is created
    Given mid in msg_status
    When a subscriber consumes a message from the "SNS" topic
    When an "SNS" topic is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an EventBridge rule is created to route matching events to an "SNS" topic
    Given mid in msg_status
    When a subscriber consumes a message from the "SNS" topic
    When an EventBridge rule is created to route matching events to an "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an event is published to the bus and routed to the target "SNS" topic
    Given mid in msg_status
    When a subscriber consumes a message from the "SNS" topic
    When an event is published to the bus and routed to the target "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an "SNS" topic is created then an EventBridge rule is created to route matching events to an "SNS" topic
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an "SNS" topic is created
    When an EventBridge rule is created to route matching events to an "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an "SNS" topic is created then an event is published to the bus and routed to the target "SNS" topic
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an "SNS" topic is created
    When an event is published to the bus and routed to the target "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an "SNS" topic is created then a subscriber consumes a message from the "SNS" topic
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an "SNS" topic is created
    When a subscriber consumes a message from the "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is created to route matching events to an "SNS" topic then an "SNS" topic is created
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When an "SNS" topic is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is created to route matching events to an "SNS" topic then an event is published to the bus and routed to the target "SNS" topic
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When an event is published to the bus and routed to the target "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is created to route matching events to an "SNS" topic then a subscriber consumes a message from the "SNS" topic
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When a subscriber consumes a message from the "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event is published to the bus and routed to the target "SNS" topic then an "SNS" topic is created
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an event is published to the bus and routed to the target "SNS" topic
    When an "SNS" topic is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event is published to the bus and routed to the target "SNS" topic then an EventBridge rule is created to route matching events to an "SNS" topic
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an event is published to the bus and routed to the target "SNS" topic
    When an EventBridge rule is created to route matching events to an "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event is published to the bus and routed to the target "SNS" topic then a subscriber consumes a message from the "SNS" topic
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an event is published to the bus and routed to the target "SNS" topic
    When a subscriber consumes a message from the "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a subscriber consumes a message from the "SNS" topic then an "SNS" topic is created
    Given bid not in bus_status
    When an EventBridge event bus is created
    When a subscriber consumes a message from the "SNS" topic
    When an "SNS" topic is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a subscriber consumes a message from the "SNS" topic then an EventBridge rule is created to route matching events to an "SNS" topic
    Given bid not in bus_status
    When an EventBridge event bus is created
    When a subscriber consumes a message from the "SNS" topic
    When an EventBridge rule is created to route matching events to an "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a subscriber consumes a message from the "SNS" topic then an event is published to the bus and routed to the target "SNS" topic
    Given bid not in bus_status
    When an EventBridge event bus is created
    When a subscriber consumes a message from the "SNS" topic
    When an event is published to the bus and routed to the target "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an EventBridge event bus is created then an EventBridge rule is created to route matching events to an "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When an EventBridge event bus is created
    When an EventBridge rule is created to route matching events to an "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an EventBridge event bus is created then an event is published to the bus and routed to the target "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When an EventBridge event bus is created
    When an event is published to the bus and routed to the target "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an EventBridge event bus is created then a subscriber consumes a message from the "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When an EventBridge event bus is created
    When a subscriber consumes a message from the "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an EventBridge rule is created to route matching events to an "SNS" topic then an EventBridge event bus is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an EventBridge rule is created to route matching events to an "SNS" topic then an event is published to the bus and routed to the target "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When an event is published to the bus and routed to the target "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an EventBridge rule is created to route matching events to an "SNS" topic then a subscriber consumes a message from the "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When a subscriber consumes a message from the "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an event is published to the bus and routed to the target "SNS" topic then an EventBridge event bus is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When an event is published to the bus and routed to the target "SNS" topic
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an event is published to the bus and routed to the target "SNS" topic then an EventBridge rule is created to route matching events to an "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When an event is published to the bus and routed to the target "SNS" topic
    When an EventBridge rule is created to route matching events to an "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an event is published to the bus and routed to the target "SNS" topic then a subscriber consumes a message from the "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When an event is published to the bus and routed to the target "SNS" topic
    When a subscriber consumes a message from the "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a subscriber consumes a message from the "SNS" topic then an EventBridge event bus is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When a subscriber consumes a message from the "SNS" topic
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a subscriber consumes a message from the "SNS" topic then an EventBridge rule is created to route matching events to an "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When a subscriber consumes a message from the "SNS" topic
    When an EventBridge rule is created to route matching events to an "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a subscriber consumes a message from the "SNS" topic then an event is published to the bus and routed to the target "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When a subscriber consumes a message from the "SNS" topic
    When an event is published to the bus and routed to the target "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then an EventBridge event bus is created then an "SNS" topic is created
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When an EventBridge event bus is created
    When an "SNS" topic is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then an EventBridge event bus is created then an event is published to the bus and routed to the target "SNS" topic
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When an EventBridge event bus is created
    When an event is published to the bus and routed to the target "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then an EventBridge event bus is created then a subscriber consumes a message from the "SNS" topic
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When an EventBridge event bus is created
    When a subscriber consumes a message from the "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then an "SNS" topic is created then an EventBridge event bus is created
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When an "SNS" topic is created
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then an "SNS" topic is created then an event is published to the bus and routed to the target "SNS" topic
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When an "SNS" topic is created
    When an event is published to the bus and routed to the target "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then an "SNS" topic is created then a subscriber consumes a message from the "SNS" topic
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When an "SNS" topic is created
    When a subscriber consumes a message from the "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then an event is published to the bus and routed to the target "SNS" topic then an EventBridge event bus is created
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When an event is published to the bus and routed to the target "SNS" topic
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then an event is published to the bus and routed to the target "SNS" topic then an "SNS" topic is created
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When an event is published to the bus and routed to the target "SNS" topic
    When an "SNS" topic is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then an event is published to the bus and routed to the target "SNS" topic then a subscriber consumes a message from the "SNS" topic
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When an event is published to the bus and routed to the target "SNS" topic
    When a subscriber consumes a message from the "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then a subscriber consumes a message from the "SNS" topic then an EventBridge event bus is created
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When a subscriber consumes a message from the "SNS" topic
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then a subscriber consumes a message from the "SNS" topic then an "SNS" topic is created
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When a subscriber consumes a message from the "SNS" topic
    When an "SNS" topic is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then a subscriber consumes a message from the "SNS" topic then an event is published to the bus and routed to the target "SNS" topic
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When a subscriber consumes a message from the "SNS" topic
    When an event is published to the bus and routed to the target "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then an EventBridge event bus is created then an "SNS" topic is created
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SNS" topic
    When an EventBridge event bus is created
    When an "SNS" topic is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then an EventBridge event bus is created then an EventBridge rule is created to route matching events to an "SNS" topic
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SNS" topic
    When an EventBridge event bus is created
    When an EventBridge rule is created to route matching events to an "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then an EventBridge event bus is created then a subscriber consumes a message from the "SNS" topic
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SNS" topic
    When an EventBridge event bus is created
    When a subscriber consumes a message from the "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then an "SNS" topic is created then an EventBridge event bus is created
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SNS" topic
    When an "SNS" topic is created
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then an "SNS" topic is created then an EventBridge rule is created to route matching events to an "SNS" topic
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SNS" topic
    When an "SNS" topic is created
    When an EventBridge rule is created to route matching events to an "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then an "SNS" topic is created then a subscriber consumes a message from the "SNS" topic
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SNS" topic
    When an "SNS" topic is created
    When a subscriber consumes a message from the "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then an EventBridge rule is created to route matching events to an "SNS" topic then an EventBridge event bus is created
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SNS" topic
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then an EventBridge rule is created to route matching events to an "SNS" topic then an "SNS" topic is created
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SNS" topic
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When an "SNS" topic is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then an EventBridge rule is created to route matching events to an "SNS" topic then a subscriber consumes a message from the "SNS" topic
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SNS" topic
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When a subscriber consumes a message from the "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then a subscriber consumes a message from the "SNS" topic then an EventBridge event bus is created
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SNS" topic
    When a subscriber consumes a message from the "SNS" topic
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then a subscriber consumes a message from the "SNS" topic then an "SNS" topic is created
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SNS" topic
    When a subscriber consumes a message from the "SNS" topic
    When an "SNS" topic is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then a subscriber consumes a message from the "SNS" topic then an EventBridge rule is created to route matching events to an "SNS" topic
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SNS" topic
    When a subscriber consumes a message from the "SNS" topic
    When an EventBridge rule is created to route matching events to an "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an EventBridge event bus is created then an "SNS" topic is created
    Given mid in msg_status
    When a subscriber consumes a message from the "SNS" topic
    When an EventBridge event bus is created
    When an "SNS" topic is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an EventBridge event bus is created then an EventBridge rule is created to route matching events to an "SNS" topic
    Given mid in msg_status
    When a subscriber consumes a message from the "SNS" topic
    When an EventBridge event bus is created
    When an EventBridge rule is created to route matching events to an "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an EventBridge event bus is created then an event is published to the bus and routed to the target "SNS" topic
    Given mid in msg_status
    When a subscriber consumes a message from the "SNS" topic
    When an EventBridge event bus is created
    When an event is published to the bus and routed to the target "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an "SNS" topic is created then an EventBridge event bus is created
    Given mid in msg_status
    When a subscriber consumes a message from the "SNS" topic
    When an "SNS" topic is created
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an "SNS" topic is created then an EventBridge rule is created to route matching events to an "SNS" topic
    Given mid in msg_status
    When a subscriber consumes a message from the "SNS" topic
    When an "SNS" topic is created
    When an EventBridge rule is created to route matching events to an "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an "SNS" topic is created then an event is published to the bus and routed to the target "SNS" topic
    Given mid in msg_status
    When a subscriber consumes a message from the "SNS" topic
    When an "SNS" topic is created
    When an event is published to the bus and routed to the target "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an EventBridge rule is created to route matching events to an "SNS" topic then an EventBridge event bus is created
    Given mid in msg_status
    When a subscriber consumes a message from the "SNS" topic
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an EventBridge rule is created to route matching events to an "SNS" topic then an "SNS" topic is created
    Given mid in msg_status
    When a subscriber consumes a message from the "SNS" topic
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When an "SNS" topic is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an EventBridge rule is created to route matching events to an "SNS" topic then an event is published to the bus and routed to the target "SNS" topic
    Given mid in msg_status
    When a subscriber consumes a message from the "SNS" topic
    When an EventBridge rule is created to route matching events to an "SNS" topic
    When an event is published to the bus and routed to the target "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an event is published to the bus and routed to the target "SNS" topic then an EventBridge event bus is created
    Given mid in msg_status
    When a subscriber consumes a message from the "SNS" topic
    When an event is published to the bus and routed to the target "SNS" topic
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an event is published to the bus and routed to the target "SNS" topic then an "SNS" topic is created
    Given mid in msg_status
    When a subscriber consumes a message from the "SNS" topic
    When an event is published to the bus and routed to the target "SNS" topic
    When an "SNS" topic is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an event is published to the bus and routed to the target "SNS" topic then an EventBridge rule is created to route matching events to an "SNS" topic
    Given mid in msg_status
    When a subscriber consumes a message from the "SNS" topic
    When an event is published to the bus and routed to the target "SNS" topic
    When an EventBridge rule is created to route matching events to an "SNS" topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic
