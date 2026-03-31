@eventssns @generated
Feature: EventsSns - A Subscriber Consumes A Message From The "Sns" "Topic"

  # Generated from FizzBee spec: events_sns.fizz
  # Safety invariants: RuleReferencesActiveBus, MessageRequiresActiveTopic

  Background:
    Given the system is initialized

  @minimal @happy @consume_message
  Scenario: a subscriber consumes a message from the "sns" "topic"
    Given an "AVAILABLE" message existed on the topic
    When a subscriber consumes a message from the "sns" "topic"
    Then the message will be deleted
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @guard @negative @consume_message @lifecycle
  Scenario: a subscriber consumes a message from the "sns" "topic" fails when no "AVAILABLE" message existed on the topic
    Given no "AVAILABLE" message existed on the topic
    When a subscriber consumes a message from the "sns" "topic"
    Then the operation is rejected
