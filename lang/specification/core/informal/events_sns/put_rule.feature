@eventssns @generated
Feature: EventsSns - An Eventbridge Rule Is Created To Route Matching Events To An Sns Topic

  # Generated from FizzBee spec: events_sns.fizz
  # Safety invariants: RuleReferencesActiveBus, MessageRequiresActiveTopic

  Background:
    Given the system is initialized

  @minimal @happy @put_rule
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic
    Given the event bus exists
    And the event bus is "ACTIVE"
    And the topic exists
    And the topic is "ACTIVE"
    And the rule does not already exist
    When an EventBridge rule is created to route matching events to an "SNS" topic
    Then the rule is "ENABLED" and will publish to the topic when matching events are received
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @standard @negative @put_rule
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic fails when the event bus does not exist
    Given the event bus does not exist
    When an EventBridge rule is created to route matching events to an "SNS" topic
    Then the operation is rejected

  @standard @negative @put_rule @lifecycle @internal
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic fails when the event bus is not "ACTIVE"
    Given the event bus exists
    And the event bus is not "ACTIVE"
    When an EventBridge rule is created to route matching events to an "SNS" topic
    Then the operation is rejected

  @standard @negative @put_rule
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic fails when the topic does not exist
    Given the event bus exists
    And the event bus is "ACTIVE"
    And the topic does not exist
    When an EventBridge rule is created to route matching events to an "SNS" topic
    Then the operation is rejected

  @standard @negative @put_rule @lifecycle @internal
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic fails when the topic is not "ACTIVE"
    Given the event bus exists
    And the event bus is "ACTIVE"
    And the topic exists
    And the topic is not "ACTIVE"
    When an EventBridge rule is created to route matching events to an "SNS" topic
    Then the operation is rejected

  @standard @negative @put_rule
  Scenario: an EventBridge rule is created to route matching events to an "SNS" topic fails when the rule already exists
    Given the event bus exists
    And the event bus is "ACTIVE"
    And the topic exists
    And the topic is "ACTIVE"
    And the rule already exists
    When an EventBridge rule is created to route matching events to an "SNS" topic
    Then the operation is rejected
