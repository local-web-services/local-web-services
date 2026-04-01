@eventssns @generated
Feature: EventsSns - An "Eventbridge" "Event" Is Published To The "Eventbridge" "Bus" And Routed To The Target "Sns" "Topic"

  # Generated from FizzBee spec: events_sns.fizz
  # Safety invariants: RuleReferencesActiveBus, MessageRequiresActiveTopic

  Background:
    Given the system is initialized

  @minimal @happy @put_event
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And an "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "sns" "topic"
    And the target "sns" "topic" was "ACTIVE"
    And a "sns" "message" "slot" was "available"
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    Then the "sns" "message" will be "AVAILABLE" on the "sns" "topic"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"

  @guard @negative @put_event
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic" fails when the "eventbridge" "bus" did not exist
    Given the "eventbridge" "bus" did not exist
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    Then the operation is rejected

  @guard @negative @put_event @lifecycle
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic" fails when the "eventbridge" "bus" was not "ACTIVE"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was not "ACTIVE"
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    Then the operation is rejected

  @guard @negative @put_event @lifecycle
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic" fails when no "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "sns" "topic"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And no "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "sns" "topic"
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    Then the operation is rejected

  @guard @negative @put_event @lifecycle
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic" fails when the target "sns" "topic" was not "ACTIVE"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And an "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "sns" "topic"
    And the target "sns" "topic" was not "ACTIVE"
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    Then the operation is rejected

  @guard @negative @put_event @capacity
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic" fails when no "sns" "message" "slot" was "available"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And an "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "sns" "topic"
    And the target "sns" "topic" was "ACTIVE"
    And no "sns" "message" "slot" was "available"
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"
    Then the operation is rejected
