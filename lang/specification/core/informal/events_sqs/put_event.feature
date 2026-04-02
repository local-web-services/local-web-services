@eventssqs @generated
Feature: EventsSqs - An "Eventbridge" "Event" Is Published To The "Eventbridge" "Bus" And Routed To The Target "Sqs" "Queue"

  # Generated from FizzBee spec: events_sqs.fizz
  # Safety invariants: RuleReferencesActiveBus, MessagesReferenceActiveQueues

  Background:
    Given the system is initialized

  @minimal @happy @put_event
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sqs" "queue"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And an "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "sqs" "queue"
    And the target "sqs" "queue" was "ACTIVE"
    And a "sqs" "message" "slot" was "available"
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sqs" "queue"
    Then the "sqs" "message" will be "AVAILABLE" in the target "sqs" "queue"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @guard @negative @put_event
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sqs" "queue" fails when the "eventbridge" "bus" did not exist
    Given the "eventbridge" "bus" did not exist
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sqs" "queue"
    Then the operation is rejected

  @guard @negative @put_event @lifecycle
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sqs" "queue" fails when the "eventbridge" "bus" was not "ACTIVE"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was not "ACTIVE"
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sqs" "queue"
    Then the operation is rejected

  @guard @negative @put_event @lifecycle
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sqs" "queue" fails when no "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "sqs" "queue"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And no "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "sqs" "queue"
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sqs" "queue"
    Then the operation is rejected

  @guard @negative @put_event @lifecycle
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sqs" "queue" fails when the target "sqs" "queue" was not "ACTIVE"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And an "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "sqs" "queue"
    And the target "sqs" "queue" was not "ACTIVE"
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sqs" "queue"
    Then the operation is rejected

  @guard @negative @put_event @capacity
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sqs" "queue" fails when no "sqs" "message" "slot" was "available"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And an "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "sqs" "queue"
    And the target "sqs" "queue" was "ACTIVE"
    And no "sqs" "message" "slot" was "available"
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sqs" "queue"
    Then the operation is rejected
