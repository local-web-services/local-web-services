@eventssns @generated
Feature: EventsSns - A Subscriber Consumes A Message From The Sns Topic

  # Generated from FizzBee spec: events_sns.fizz
  # Safety invariants: RuleReferencesActiveBus, MessageRequiresActiveTopic

  Background:
    Given the system is initialized

  @minimal @happy @consume_message
  Scenario: a subscriber consumes a message from the "SNS" topic
    Given an "AVAILABLE" message exists on the topic
    When a subscriber consumes a message from the "SNS" topic
    Then the message is "DELETED"
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @standard @negative @consume_message @lifecycle @internal
  Scenario: a subscriber consumes a message from the "SNS" topic fails when no "AVAILABLE" message exists on the topic
    Given no "AVAILABLE" message exists on the topic
    When a subscriber consumes a message from the "SNS" topic
    Then the operation is rejected
