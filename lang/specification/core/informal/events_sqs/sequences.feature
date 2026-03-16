@eventssqs @generated
Feature: EventsSqs - Action Sequences

  # Generated from FizzBee spec: events_sqs.fizz
  # Safety invariants: RuleReferencesActiveBus, MessagesReferenceActiveQueues

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an "SQS" queue is created
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an "SQS" queue is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is created to route matching events to the "SQS" queue
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is created to route matching events to the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event is published to the bus and routed to the target "SQS" queue
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an event is published to the bus and routed to the target "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a message is consumed from the "SQS" queue
    Given bid not in bus_status
    When an EventBridge event bus is created
    When a message is consumed from the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an EventBridge event bus is created
    Given qid not in queue_status
    When an "SQS" queue is created
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an EventBridge rule is created to route matching events to the "SQS" queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When an EventBridge rule is created to route matching events to the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an event is published to the bus and routed to the target "SQS" queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When an event is published to the bus and routed to the target "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a message is consumed from the "SQS" queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When a message is consumed from the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to the "SQS" queue then an EventBridge event bus is created
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to the "SQS" queue then an "SQS" queue is created
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When an "SQS" queue is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to the "SQS" queue then an event is published to the bus and routed to the target "SQS" queue
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When an event is published to the bus and routed to the target "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to the "SQS" queue then a message is consumed from the "SQS" queue
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When a message is consumed from the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SQS" queue then an EventBridge event bus is created
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SQS" queue
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SQS" queue then an "SQS" queue is created
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SQS" queue
    When an "SQS" queue is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SQS" queue then an EventBridge rule is created to route matching events to the "SQS" queue
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SQS" queue
    When an EventBridge rule is created to route matching events to the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SQS" queue then a message is consumed from the "SQS" queue
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SQS" queue
    When a message is consumed from the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then an EventBridge event bus is created
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then an "SQS" queue is created
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When an "SQS" queue is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then an EventBridge rule is created to route matching events to the "SQS" queue
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When an EventBridge rule is created to route matching events to the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then an event is published to the bus and routed to the target "SQS" queue
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When an event is published to the bus and routed to the target "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an "SQS" queue is created then an EventBridge rule is created to route matching events to the "SQS" queue
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an "SQS" queue is created
    When an EventBridge rule is created to route matching events to the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an "SQS" queue is created then an event is published to the bus and routed to the target "SQS" queue
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an "SQS" queue is created
    When an event is published to the bus and routed to the target "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an "SQS" queue is created then a message is consumed from the "SQS" queue
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an "SQS" queue is created
    When a message is consumed from the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is created to route matching events to the "SQS" queue then an "SQS" queue is created
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When an "SQS" queue is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is created to route matching events to the "SQS" queue then an event is published to the bus and routed to the target "SQS" queue
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When an event is published to the bus and routed to the target "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is created to route matching events to the "SQS" queue then a message is consumed from the "SQS" queue
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When a message is consumed from the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event is published to the bus and routed to the target "SQS" queue then an "SQS" queue is created
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an event is published to the bus and routed to the target "SQS" queue
    When an "SQS" queue is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event is published to the bus and routed to the target "SQS" queue then an EventBridge rule is created to route matching events to the "SQS" queue
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an event is published to the bus and routed to the target "SQS" queue
    When an EventBridge rule is created to route matching events to the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event is published to the bus and routed to the target "SQS" queue then a message is consumed from the "SQS" queue
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an event is published to the bus and routed to the target "SQS" queue
    When a message is consumed from the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a message is consumed from the "SQS" queue then an "SQS" queue is created
    Given bid not in bus_status
    When an EventBridge event bus is created
    When a message is consumed from the "SQS" queue
    When an "SQS" queue is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a message is consumed from the "SQS" queue then an EventBridge rule is created to route matching events to the "SQS" queue
    Given bid not in bus_status
    When an EventBridge event bus is created
    When a message is consumed from the "SQS" queue
    When an EventBridge rule is created to route matching events to the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a message is consumed from the "SQS" queue then an event is published to the bus and routed to the target "SQS" queue
    Given bid not in bus_status
    When an EventBridge event bus is created
    When a message is consumed from the "SQS" queue
    When an event is published to the bus and routed to the target "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an EventBridge event bus is created then an EventBridge rule is created to route matching events to the "SQS" queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When an EventBridge event bus is created
    When an EventBridge rule is created to route matching events to the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an EventBridge event bus is created then an event is published to the bus and routed to the target "SQS" queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When an EventBridge event bus is created
    When an event is published to the bus and routed to the target "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an EventBridge event bus is created then a message is consumed from the "SQS" queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When an EventBridge event bus is created
    When a message is consumed from the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an EventBridge rule is created to route matching events to the "SQS" queue then an EventBridge event bus is created
    Given qid not in queue_status
    When an "SQS" queue is created
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an EventBridge rule is created to route matching events to the "SQS" queue then an event is published to the bus and routed to the target "SQS" queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When an event is published to the bus and routed to the target "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an EventBridge rule is created to route matching events to the "SQS" queue then a message is consumed from the "SQS" queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When a message is consumed from the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an event is published to the bus and routed to the target "SQS" queue then an EventBridge event bus is created
    Given qid not in queue_status
    When an "SQS" queue is created
    When an event is published to the bus and routed to the target "SQS" queue
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an event is published to the bus and routed to the target "SQS" queue then an EventBridge rule is created to route matching events to the "SQS" queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When an event is published to the bus and routed to the target "SQS" queue
    When an EventBridge rule is created to route matching events to the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an event is published to the bus and routed to the target "SQS" queue then a message is consumed from the "SQS" queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When an event is published to the bus and routed to the target "SQS" queue
    When a message is consumed from the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a message is consumed from the "SQS" queue then an EventBridge event bus is created
    Given qid not in queue_status
    When an "SQS" queue is created
    When a message is consumed from the "SQS" queue
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a message is consumed from the "SQS" queue then an EventBridge rule is created to route matching events to the "SQS" queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When a message is consumed from the "SQS" queue
    When an EventBridge rule is created to route matching events to the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a message is consumed from the "SQS" queue then an event is published to the bus and routed to the target "SQS" queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When a message is consumed from the "SQS" queue
    When an event is published to the bus and routed to the target "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to the "SQS" queue then an EventBridge event bus is created then an "SQS" queue is created
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When an EventBridge event bus is created
    When an "SQS" queue is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to the "SQS" queue then an EventBridge event bus is created then an event is published to the bus and routed to the target "SQS" queue
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When an EventBridge event bus is created
    When an event is published to the bus and routed to the target "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to the "SQS" queue then an EventBridge event bus is created then a message is consumed from the "SQS" queue
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When an EventBridge event bus is created
    When a message is consumed from the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to the "SQS" queue then an "SQS" queue is created then an EventBridge event bus is created
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When an "SQS" queue is created
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to the "SQS" queue then an "SQS" queue is created then an event is published to the bus and routed to the target "SQS" queue
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When an "SQS" queue is created
    When an event is published to the bus and routed to the target "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to the "SQS" queue then an "SQS" queue is created then a message is consumed from the "SQS" queue
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When an "SQS" queue is created
    When a message is consumed from the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to the "SQS" queue then an event is published to the bus and routed to the target "SQS" queue then an EventBridge event bus is created
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When an event is published to the bus and routed to the target "SQS" queue
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to the "SQS" queue then an event is published to the bus and routed to the target "SQS" queue then an "SQS" queue is created
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When an event is published to the bus and routed to the target "SQS" queue
    When an "SQS" queue is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to the "SQS" queue then an event is published to the bus and routed to the target "SQS" queue then a message is consumed from the "SQS" queue
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When an event is published to the bus and routed to the target "SQS" queue
    When a message is consumed from the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to the "SQS" queue then a message is consumed from the "SQS" queue then an EventBridge event bus is created
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When a message is consumed from the "SQS" queue
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to the "SQS" queue then a message is consumed from the "SQS" queue then an "SQS" queue is created
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When a message is consumed from the "SQS" queue
    When an "SQS" queue is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to route matching events to the "SQS" queue then a message is consumed from the "SQS" queue then an event is published to the bus and routed to the target "SQS" queue
    Given rid not in rule_status
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When a message is consumed from the "SQS" queue
    When an event is published to the bus and routed to the target "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SQS" queue then an EventBridge event bus is created then an "SQS" queue is created
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SQS" queue
    When an EventBridge event bus is created
    When an "SQS" queue is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SQS" queue then an EventBridge event bus is created then an EventBridge rule is created to route matching events to the "SQS" queue
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SQS" queue
    When an EventBridge event bus is created
    When an EventBridge rule is created to route matching events to the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SQS" queue then an EventBridge event bus is created then a message is consumed from the "SQS" queue
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SQS" queue
    When an EventBridge event bus is created
    When a message is consumed from the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SQS" queue then an "SQS" queue is created then an EventBridge event bus is created
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SQS" queue
    When an "SQS" queue is created
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SQS" queue then an "SQS" queue is created then an EventBridge rule is created to route matching events to the "SQS" queue
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SQS" queue
    When an "SQS" queue is created
    When an EventBridge rule is created to route matching events to the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SQS" queue then an "SQS" queue is created then a message is consumed from the "SQS" queue
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SQS" queue
    When an "SQS" queue is created
    When a message is consumed from the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SQS" queue then an EventBridge rule is created to route matching events to the "SQS" queue then an EventBridge event bus is created
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SQS" queue
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SQS" queue then an EventBridge rule is created to route matching events to the "SQS" queue then an "SQS" queue is created
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SQS" queue
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When an "SQS" queue is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SQS" queue then an EventBridge rule is created to route matching events to the "SQS" queue then a message is consumed from the "SQS" queue
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SQS" queue
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When a message is consumed from the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SQS" queue then a message is consumed from the "SQS" queue then an EventBridge event bus is created
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SQS" queue
    When a message is consumed from the "SQS" queue
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SQS" queue then a message is consumed from the "SQS" queue then an "SQS" queue is created
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SQS" queue
    When a message is consumed from the "SQS" queue
    When an "SQS" queue is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an event is published to the bus and routed to the target "SQS" queue then a message is consumed from the "SQS" queue then an EventBridge rule is created to route matching events to the "SQS" queue
    Given bid in bus_status
    When an event is published to the bus and routed to the target "SQS" queue
    When a message is consumed from the "SQS" queue
    When an EventBridge rule is created to route matching events to the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then an EventBridge event bus is created then an "SQS" queue is created
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When an EventBridge event bus is created
    When an "SQS" queue is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then an EventBridge event bus is created then an EventBridge rule is created to route matching events to the "SQS" queue
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When an EventBridge event bus is created
    When an EventBridge rule is created to route matching events to the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then an EventBridge event bus is created then an event is published to the bus and routed to the target "SQS" queue
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When an EventBridge event bus is created
    When an event is published to the bus and routed to the target "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then an "SQS" queue is created then an EventBridge event bus is created
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When an "SQS" queue is created
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then an "SQS" queue is created then an EventBridge rule is created to route matching events to the "SQS" queue
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When an "SQS" queue is created
    When an EventBridge rule is created to route matching events to the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then an "SQS" queue is created then an event is published to the bus and routed to the target "SQS" queue
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When an "SQS" queue is created
    When an event is published to the bus and routed to the target "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then an EventBridge rule is created to route matching events to the "SQS" queue then an EventBridge event bus is created
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then an EventBridge rule is created to route matching events to the "SQS" queue then an "SQS" queue is created
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When an "SQS" queue is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then an EventBridge rule is created to route matching events to the "SQS" queue then an event is published to the bus and routed to the target "SQS" queue
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When an EventBridge rule is created to route matching events to the "SQS" queue
    When an event is published to the bus and routed to the target "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then an event is published to the bus and routed to the target "SQS" queue then an EventBridge event bus is created
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When an event is published to the bus and routed to the target "SQS" queue
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then an event is published to the bus and routed to the target "SQS" queue then an "SQS" queue is created
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When an event is published to the bus and routed to the target "SQS" queue
    When an "SQS" queue is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then an event is published to the bus and routed to the target "SQS" queue then an EventBridge rule is created to route matching events to the "SQS" queue
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When an event is published to the bus and routed to the target "SQS" queue
    When an EventBridge rule is created to route matching events to the "SQS" queue
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
