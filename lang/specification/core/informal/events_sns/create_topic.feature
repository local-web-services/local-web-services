@eventssns @generated
Feature: EventsSns - A "Sns" "Topic" Is Created

  # Generated from FizzBee spec: events_sns.fizz
  # Safety invariants: RuleReferencesActiveBus, MessageRequiresActiveTopic

  Background:
    Given the system is initialized

  @minimal @happy @create_topic
  Scenario: a "sns" "topic" is created
    Given the topic did not already exist
    When a "sns" "topic" is created
    Then the "sns" "topic" will be "ACTIVE"
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @guard @negative @create_topic
  Scenario: a "sns" "topic" is created fails when the topic already existed
    Given the topic already existed
    When a "sns" "topic" is created
    Then the operation is rejected
