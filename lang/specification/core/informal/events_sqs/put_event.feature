@eventssqs @generated
Feature: EventsSqs - An Event Is Published To The Bus And Routed To The Target Sqs Queue

  # Generated from FizzBee spec: events_sqs.fizz
  # Safety invariants: RuleReferencesActiveBus, MessagesReferenceActiveQueues

  Background:
    Given the system is initialized

  @minimal @happy @put_event
  Scenario: an event is published to the bus and routed to the target "SQS" queue
    Given the event bus existed
    And the event bus was "ACTIVE"
    And an "ENABLED" rule existed on the bus targeting a queue
    And the target queue was "ACTIVE"
    And a message slot is available
    When an event is published to the bus and routed to the target "SQS" queue
    Then the message will be "AVAILABLE" in the target queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @guard @negative @put_event
  Scenario: an event is published to the bus and routed to the target "SQS" queue fails when the event bus did not exist
    Given the event bus did not exist
    When an event is published to the bus and routed to the target "SQS" queue
    Then the operation is rejected

  @guard @negative @put_event @lifecycle
  Scenario: an event is published to the bus and routed to the target "SQS" queue fails when the event bus was not "ACTIVE"
    Given the event bus existed
    And the event bus was not "ACTIVE"
    When an event is published to the bus and routed to the target "SQS" queue
    Then the operation is rejected

  @guard @negative @put_event @lifecycle
  Scenario: an event is published to the bus and routed to the target "SQS" queue fails when no "ENABLED" rule existed on the bus targeting a queue
    Given the event bus existed
    And the event bus was "ACTIVE"
    And no "ENABLED" rule existed on the bus targeting a queue
    When an event is published to the bus and routed to the target "SQS" queue
    Then the operation is rejected

  @guard @negative @put_event @lifecycle
  Scenario: an event is published to the bus and routed to the target "SQS" queue fails when the target queue was not "ACTIVE"
    Given the event bus existed
    And the event bus was "ACTIVE"
    And an "ENABLED" rule existed on the bus targeting a queue
    And the target queue was not "ACTIVE"
    When an event is published to the bus and routed to the target "SQS" queue
    Then the operation is rejected

  @guard @negative @put_event @capacity
  Scenario: an event is published to the bus and routed to the target "SQS" queue fails when no message slot is available
    Given the event bus existed
    And the event bus was "ACTIVE"
    And an "ENABLED" rule existed on the bus targeting a queue
    And the target queue was "ACTIVE"
    And no message slot is available
    When an event is published to the bus and routed to the target "SQS" queue
    Then the operation is rejected
