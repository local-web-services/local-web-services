@eventssns @generated
Feature: EventsSns - A Subscriber Consumes A Message From The "Sns" "Topic"

  # Generated from FizzBee spec: events_sns.fizz
  # Safety invariants: RuleReferencesActiveBus, MessageRequiresActiveTopic

  Background:
    Given the system is initialized

  @minimal @happy @consume_message
  Scenario: a subscriber consumes a message from the "sns" "topic"
    Given an "AVAILABLE" "sns" "message" existed on the "sns" "topic"
    When a subscriber consumes a message from the "sns" "topic"
    Then the "sns" "message" will be "DELETED"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @guard @negative @consume_message @lifecycle
  Scenario: a subscriber consumes a message from the "sns" "topic" fails when no "AVAILABLE" "sns" "message" existed on the "sns" "topic"
    Given no "AVAILABLE" "sns" "message" existed on the "sns" "topic"
    When a subscriber consumes a message from the "sns" "topic"
    Then the operation is rejected
