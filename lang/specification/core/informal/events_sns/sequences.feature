@eventssns @generated
Feature: EventsSns - Action Sequences

  # Generated from FizzBee spec: events_sns.fizz
  # Safety invariants: RuleReferencesActiveBus, MessageRequiresActiveTopic

  Background:
    Given the system is initialized

  @sequence
  Scenario: an EventBridge event bus is created then an "SNS" topic is created
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    When an "SNS" topic is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is created to route matching events to an "SNS" topic
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    When an EventBridge rule is created to route matching events to an "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an EventBridge event bus is created then an event is published to the bus and routed to the target "SNS" topic
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    When an event is published to the bus and routed to the target "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an EventBridge event bus is created then a subscriber consumes a message from the "SNS" topic
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    When a subscriber consumes a message from the "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" topic is created then an EventBridge event bus is created
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When an EventBridge event bus is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" topic is created then an EventBridge rule is created to route matching events to an "SNS" topic
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When an EventBridge rule is created to route matching events to an "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" topic is created then an event is published to the bus and routed to the target "SNS" topic
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When an event is published to the bus and routed to the target "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" topic is created then a subscriber consumes a message from the "SNS" topic
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When a subscriber consumes a message from the "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then an EventBridge event bus is created
    Given rid not in rule_status
    Given an EventBridge rule has been created to route matching events to an "SNS" topic
    When an EventBridge event bus is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then an "SNS" topic is created
    Given rid not in rule_status
    Given an EventBridge rule has been created to route matching events to an "SNS" topic
    When an "SNS" topic is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then an event is published to the bus and routed to the target "SNS" topic
    Given rid not in rule_status
    Given an EventBridge rule has been created to route matching events to an "SNS" topic
    When an event is published to the bus and routed to the target "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then a subscriber consumes a message from the "SNS" topic
    Given rid not in rule_status
    Given an EventBridge rule has been created to route matching events to an "SNS" topic
    When a subscriber consumes a message from the "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then an EventBridge event bus is created
    Given bid in bus_status
    Given an event has been published to the bus and routed to the target "SNS" topic
    When an EventBridge event bus is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then an "SNS" topic is created
    Given bid in bus_status
    Given an event has been published to the bus and routed to the target "SNS" topic
    When an "SNS" topic is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then an EventBridge rule is created to route matching events to an "SNS" topic
    Given bid in bus_status
    Given an event has been published to the bus and routed to the target "SNS" topic
    When an EventBridge rule is created to route matching events to an "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then a subscriber consumes a message from the "SNS" topic
    Given bid in bus_status
    Given an event has been published to the bus and routed to the target "SNS" topic
    When a subscriber consumes a message from the "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an EventBridge event bus is created
    Given mid in msg_status
    Given a subscriber has consumed a message from the "SNS" topic
    When an EventBridge event bus is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an "SNS" topic is created
    Given mid in msg_status
    Given a subscriber has consumed a message from the "SNS" topic
    When an "SNS" topic is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an EventBridge rule is created to route matching events to an "SNS" topic
    Given mid in msg_status
    Given a subscriber has consumed a message from the "SNS" topic
    When an EventBridge rule is created to route matching events to an "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an event is published to the bus and routed to the target "SNS" topic
    Given mid in msg_status
    Given a subscriber has consumed a message from the "SNS" topic
    When an event is published to the bus and routed to the target "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an EventBridge event bus is created then an "SNS" topic is created then an EventBridge rule is created to route matching events to an "SNS" topic
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    Given an "SNS" topic has been created
    When an EventBridge rule is created to route matching events to an "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is created to route matching events to an "SNS" topic then an event is published to the bus and routed to the target "SNS" topic
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    Given an EventBridge rule has been created to route matching events to an "SNS" topic
    When an event is published to the bus and routed to the target "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an EventBridge event bus is created then an event is published to the bus and routed to the target "SNS" topic then a subscriber consumes a message from the "SNS" topic
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    Given an event has been published to the bus and routed to the target "SNS" topic
    When a subscriber consumes a message from the "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an EventBridge event bus is created then a subscriber consumes a message from the "SNS" topic then an "SNS" topic is created
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    Given a subscriber has consumed a message from the "SNS" topic
    When an "SNS" topic is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" topic is created then an EventBridge event bus is created then an event is published to the bus and routed to the target "SNS" topic
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given an EventBridge event bus has been created
    When an event is published to the bus and routed to the target "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" topic is created then an EventBridge rule is created to route matching events to an "SNS" topic then a subscriber consumes a message from the "SNS" topic
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given an EventBridge rule has been created to route matching events to an "SNS" topic
    When a subscriber consumes a message from the "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" topic is created then an event is published to the bus and routed to the target "SNS" topic then an EventBridge event bus is created
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given an event has been published to the bus and routed to the target "SNS" topic
    When an EventBridge event bus is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" topic is created then a subscriber consumes a message from the "SNS" topic then an EventBridge rule is created to route matching events to an "SNS" topic
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given a subscriber has consumed a message from the "SNS" topic
    When an EventBridge rule is created to route matching events to an "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then an EventBridge event bus is created then a subscriber consumes a message from the "SNS" topic
    Given rid not in rule_status
    Given an EventBridge rule has been created to route matching events to an "SNS" topic
    Given an EventBridge event bus has been created
    When a subscriber consumes a message from the "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then an "SNS" topic is created then an EventBridge event bus is created
    Given rid not in rule_status
    Given an EventBridge rule has been created to route matching events to an "SNS" topic
    Given an "SNS" topic has been created
    When an EventBridge event bus is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then an event is published to the bus and routed to the target "SNS" topic then an "SNS" topic is created
    Given rid not in rule_status
    Given an EventBridge rule has been created to route matching events to an "SNS" topic
    Given an event has been published to the bus and routed to the target "SNS" topic
    When an "SNS" topic is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic then a subscriber consumes a message from the "SNS" topic then an event is published to the bus and routed to the target "SNS" topic
    Given rid not in rule_status
    Given an EventBridge rule has been created to route matching events to an "SNS" topic
    Given a subscriber has consumed a message from the "SNS" topic
    When an event is published to the bus and routed to the target "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then an EventBridge event bus is created then an "SNS" topic is created
    Given bid in bus_status
    Given an event has been published to the bus and routed to the target "SNS" topic
    Given an EventBridge event bus has been created
    When an "SNS" topic is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then an "SNS" topic is created then an EventBridge rule is created to route matching events to an "SNS" topic
    Given bid in bus_status
    Given an event has been published to the bus and routed to the target "SNS" topic
    Given an "SNS" topic has been created
    When an EventBridge rule is created to route matching events to an "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then an EventBridge rule is created to route matching events to an "SNS" topic then a subscriber consumes a message from the "SNS" topic
    Given bid in bus_status
    Given an event has been published to the bus and routed to the target "SNS" topic
    Given an EventBridge rule has been created to route matching events to an "SNS" topic
    When a subscriber consumes a message from the "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: an event is published to the bus and routed to the target "SNS" topic then a subscriber consumes a message from the "SNS" topic then an EventBridge event bus is created
    Given bid in bus_status
    Given an event has been published to the bus and routed to the target "SNS" topic
    Given a subscriber has consumed a message from the "SNS" topic
    When an EventBridge event bus is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an EventBridge event bus is created then an EventBridge rule is created to route matching events to an "SNS" topic
    Given mid in msg_status
    Given a subscriber has consumed a message from the "SNS" topic
    Given an EventBridge event bus has been created
    When an EventBridge rule is created to route matching events to an "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an "SNS" topic is created then an event is published to the bus and routed to the target "SNS" topic
    Given mid in msg_status
    Given a subscriber has consumed a message from the "SNS" topic
    Given an "SNS" topic has been created
    When an event is published to the bus and routed to the target "SNS" topic
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an EventBridge rule is created to route matching events to an "SNS" topic then an EventBridge event bus is created
    Given mid in msg_status
    Given a subscriber has consumed a message from the "SNS" topic
    Given an EventBridge rule has been created to route matching events to an "SNS" topic
    When an EventBridge event bus is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @sequence
  Scenario: a subscriber consumes a message from the "SNS" topic then an event is published to the bus and routed to the target "SNS" topic then an "SNS" topic is created
    Given mid in msg_status
    Given a subscriber has consumed a message from the "SNS" topic
    Given an event has been published to the bus and routed to the target "SNS" topic
    When an "SNS" topic is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic
