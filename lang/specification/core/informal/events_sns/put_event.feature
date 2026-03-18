@eventssns @generated
Feature: EventsSns - An Event Is Published To The Bus And Routed To The Target Sns Topic

  # Generated from FizzBee spec: events_sns.fizz
  # Safety invariants: RuleReferencesActiveBus, MessageRequiresActiveTopic

  Background:
    Given the system is initialized

  @minimal @happy @put_event
  Scenario: an event is published to the bus and routed to the target "SNS" topic
    Given the event bus exists
    And the event bus is "ACTIVE"
    And an "ENABLED" rule exists on the bus targeting a topic
    And the target topic is "ACTIVE"
    And a message slot is available
    When an event is published to the bus and routed to the target "SNS" topic
    Then the message is "AVAILABLE" on the topic
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @standard @negative @put_event
  Scenario: an event is published to the bus and routed to the target "SNS" topic fails when the event bus does not exist
    Given the event bus does not exist
    When an event is published to the bus and routed to the target "SNS" topic
    Then the operation is rejected

  @standard @negative @put_event @lifecycle
  Scenario: an event is published to the bus and routed to the target "SNS" topic fails when the event bus is not "ACTIVE"
    Given the event bus exists
    And the event bus is not "ACTIVE"
    When an event is published to the bus and routed to the target "SNS" topic
    Then the operation is rejected

  @standard @negative @put_event @lifecycle
  Scenario: an event is published to the bus and routed to the target "SNS" topic fails when no "ENABLED" rule exists on the bus targeting a topic
    Given the event bus exists
    And the event bus is "ACTIVE"
    And no "ENABLED" rule exists on the bus targeting a topic
    When an event is published to the bus and routed to the target "SNS" topic
    Then the operation is rejected

  @standard @negative @put_event @lifecycle
  Scenario: an event is published to the bus and routed to the target "SNS" topic fails when the target topic is not "ACTIVE"
    Given the event bus exists
    And the event bus is "ACTIVE"
    And an "ENABLED" rule exists on the bus targeting a topic
    And the target topic is not "ACTIVE"
    When an event is published to the bus and routed to the target "SNS" topic
    Then the operation is rejected

  @standard @negative @put_event @capacity
  Scenario: an event is published to the bus and routed to the target "SNS" topic fails when no message slot is available
    Given the event bus exists
    And the event bus is "ACTIVE"
    And an "ENABLED" rule exists on the bus targeting a topic
    And the target topic is "ACTIVE"
    And no message slot is available
    When an event is published to the bus and routed to the target "SNS" topic
    Then the operation is rejected
