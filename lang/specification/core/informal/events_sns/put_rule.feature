@eventssns @generated
Feature: EventsSns - An "Eventbridge" "Rule" Is Created To Route Matching Events To A "Sns" "Topic"

  # Generated from FizzBee spec: events_sns.fizz
  # Safety invariants: RuleReferencesActiveBus, MessageRequiresActiveTopic

  Background:
    Given the system is initialized

  @minimal @happy @put_rule
  Scenario: an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And the "eventbridge" "rule" did not already exist
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    Then the "eventbridge" "rule" will be "ENABLED" and will publish to the "sns" "topic" when matching events are received
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @guard @negative @put_rule
  Scenario: an "eventbridge" "rule" is created to route matching events to a "sns" "topic" fails when the "eventbridge" "bus" did not exist
    Given the "eventbridge" "bus" did not exist
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    Then the operation is rejected

  @guard @negative @put_rule @lifecycle
  Scenario: an "eventbridge" "rule" is created to route matching events to a "sns" "topic" fails when the "eventbridge" "bus" was not "ACTIVE"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was not "ACTIVE"
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    Then the operation is rejected

  @guard @negative @put_rule
  Scenario: an "eventbridge" "rule" is created to route matching events to a "sns" "topic" fails when the "sns" "topic" did not exist
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And the "sns" "topic" did not exist
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    Then the operation is rejected

  @guard @negative @put_rule @lifecycle
  Scenario: an "eventbridge" "rule" is created to route matching events to a "sns" "topic" fails when the "sns" "topic" was not "ACTIVE"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And the "sns" "topic" existed
    And the "sns" "topic" was not "ACTIVE"
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    Then the operation is rejected

  @guard @negative @put_rule
  Scenario: an "eventbridge" "rule" is created to route matching events to a "sns" "topic" fails when the "eventbridge" "rule" already existed
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    And the "eventbridge" "rule" already existed
    When an "eventbridge" "rule" is created to route matching events to a "sns" "topic"
    Then the operation is rejected
