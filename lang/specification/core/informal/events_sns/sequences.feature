@eventssns @generated
Feature: EventsSns - Action Sequences

  # Generated from FizzBee spec: events_sns.fizz
  # Safety invariants: RuleReferencesActiveBus, MessageRequiresActiveTopic

  Background:
    Given the system is initialized

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "sns" "topic" is created
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When a "sns" "topic" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: an "eventbridge" "bus" is created then a subscriber consumes a message from the "sns" "topic"
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When a subscriber consumes a message from the "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: a "sns" "topic" is created then an "eventbridge" "bus" is created
    Given tid not in topic_status
    When a "sns" "topic" is created
    When an "eventbridge" "bus" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: a "sns" "topic" is created then an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: a "sns" "topic" is created then an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: a "sns" "topic" is created then a subscriber consumes a message from the "sns" "topic"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a subscriber consumes a message from the "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: an "eventbridge" "rule" is created to route matching events to a "sns" "topic" then an "eventbridge" "bus" is created
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    When an "eventbridge" "bus" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: an "eventbridge" "rule" is created to route matching events to a "sns" "topic" then a "sns" "topic" is created
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    When a "sns" "topic" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: an "eventbridge" "rule" is created to route matching events to a "sns" "topic" then an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: an "eventbridge" "rule" is created to route matching events to a "sns" "topic" then a subscriber consumes a message from the "sns" "topic"
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    When a subscriber consumes a message from the "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic" then an "eventbridge" "bus" is created
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    When an "eventbridge" "bus" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic" then a "sns" "topic" is created
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    When a "sns" "topic" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic" then an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic" then a subscriber consumes a message from the "sns" "topic"
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    When a subscriber consumes a message from the "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: a subscriber consumes a message from the "sns" "topic" then an "eventbridge" "bus" is created
    Given mid in msg_status
    When a subscriber consumes a message from the "sns" "topic"
    When an "eventbridge" "bus" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: a subscriber consumes a message from the "sns" "topic" then a "sns" "topic" is created
    Given mid in msg_status
    When a subscriber consumes a message from the "sns" "topic"
    When a "sns" "topic" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: a subscriber consumes a message from the "sns" "topic" then an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    Given mid in msg_status
    When a subscriber consumes a message from the "sns" "topic"
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: a subscriber consumes a message from the "sns" "topic" then an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    Given mid in msg_status
    When a subscriber consumes a message from the "sns" "topic"
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "sns" "topic" is created then an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When a "sns" "topic" is created
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "rule" is created to route matching events to a "sns" "topic" then an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic" then a subscriber consumes a message from the "sns" "topic"
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    When a subscriber consumes a message from the "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: an "eventbridge" "bus" is created then a subscriber consumes a message from the "sns" "topic" then a "sns" "topic" is created
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When a subscriber consumes a message from the "sns" "topic"
    When a "sns" "topic" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: a "sns" "topic" is created then an "eventbridge" "bus" is created then an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When an "eventbridge" "bus" is created
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: a "sns" "topic" is created then an "eventbridge" "rule" is created to route matching events to a "sns" "topic" then a subscriber consumes a message from the "sns" "topic"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    When a subscriber consumes a message from the "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: a "sns" "topic" is created then an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic" then an "eventbridge" "bus" is created
    Given tid not in topic_status
    When a "sns" "topic" is created
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    When an "eventbridge" "bus" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: a "sns" "topic" is created then a subscriber consumes a message from the "sns" "topic" then an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a subscriber consumes a message from the "sns" "topic"
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: an "eventbridge" "rule" is created to route matching events to a "sns" "topic" then an "eventbridge" "bus" is created then a subscriber consumes a message from the "sns" "topic"
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    When an "eventbridge" "bus" is created
    When a subscriber consumes a message from the "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: an "eventbridge" "rule" is created to route matching events to a "sns" "topic" then a "sns" "topic" is created then an "eventbridge" "bus" is created
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    When a "sns" "topic" is created
    When an "eventbridge" "bus" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: an "eventbridge" "rule" is created to route matching events to a "sns" "topic" then an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic" then a "sns" "topic" is created
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    When a "sns" "topic" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: an "eventbridge" "rule" is created to route matching events to a "sns" "topic" then a subscriber consumes a message from the "sns" "topic" then an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    When a subscriber consumes a message from the "sns" "topic"
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic" then an "eventbridge" "bus" is created then a "sns" "topic" is created
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    When an "eventbridge" "bus" is created
    When a "sns" "topic" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic" then a "sns" "topic" is created then an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    When a "sns" "topic" is created
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic" then an "eventbridge" "rule" is created to route matching events to a "sns" "topic" then a subscriber consumes a message from the "sns" "topic"
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    When a subscriber consumes a message from the "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic" then a subscriber consumes a message from the "sns" "topic" then an "eventbridge" "bus" is created
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    When a subscriber consumes a message from the "sns" "topic"
    When an "eventbridge" "bus" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: a subscriber consumes a message from the "sns" "topic" then an "eventbridge" "bus" is created then an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    Given mid in msg_status
    When a subscriber consumes a message from the "sns" "topic"
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: a subscriber consumes a message from the "sns" "topic" then a "sns" "topic" is created then an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    Given mid in msg_status
    When a subscriber consumes a message from the "sns" "topic"
    When a "sns" "topic" is created
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: a subscriber consumes a message from the "sns" "topic" then an "eventbridge" "rule" is created to route matching events to a "sns" "topic" then an "eventbridge" "bus" is created
    Given mid in msg_status
    When a subscriber consumes a message from the "sns" "topic"
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    When an "eventbridge" "bus" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @sequence
  Scenario: a subscriber consumes a message from the "sns" "topic" then an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic" then a "sns" "topic" is created
    Given mid in msg_status
    When a subscriber consumes a message from the "sns" "topic"
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    When a "sns" "topic" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"
