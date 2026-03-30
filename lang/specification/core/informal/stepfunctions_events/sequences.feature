@stepfunctionsevents @generated
Feature: StepfunctionsEvents - Action Sequences

  # Generated from FizzBee spec: stepfunctions_events.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, DeliveredEventReferencesExistingExecution

  Background:
    Given the system is initialized

  @sequence
  Scenario: a Step Functions state machine is created then an EventBridge event bus is created
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an EventBridge event bus is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a Step Functions state machine is created then the EventBridge event bus is deleted
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When the EventBridge event bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a Step Functions state machine is created then the state machine is configured to publish execution events to the event bus
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When the state machine is configured to publish execution events to the event bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a Step Functions state machine is created then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a Step Functions state machine is created then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a Step Functions state machine is created then a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a Step Functions state machine is created then a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then a Step Functions state machine is created
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When the EventBridge event bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then the state machine is configured to publish execution events to the event bus
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When the state machine is configured to publish execution events to the event bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    When a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a Step Functions state machine is created
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When an EventBridge event bus is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the state machine is configured to publish execution events to the event bus
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When the state machine is configured to publish execution events to the event bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    When a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then a Step Functions state machine is created
    Given smid in sm_status
    Given the state machine has been configured to publish execution events to the event bus
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then an EventBridge event bus is created
    Given smid in sm_status
    Given the state machine has been configured to publish execution events to the event bus
    When an EventBridge event bus is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then the EventBridge event bus is deleted
    Given smid in sm_status
    Given the state machine has been configured to publish execution events to the event bus
    When the EventBridge event bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given smid in sm_status
    Given the state machine has been configured to publish execution events to the event bus
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given smid in sm_status
    Given the state machine has been configured to publish execution events to the event bus
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid in sm_status
    Given the state machine has been configured to publish execution events to the event bus
    When a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid in sm_status
    Given the state machine has been configured to publish execution events to the event bus
    When a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution has started and Step Functions has delivered a "STARTED" event to the EventBridge bus
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then an EventBridge event bus is created
    Given smid in sm_status
    Given an execution has started and Step Functions has delivered a "STARTED" event to the EventBridge bus
    When an EventBridge event bus is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then the EventBridge event bus is deleted
    Given smid in sm_status
    Given an execution has started and Step Functions has delivered a "STARTED" event to the EventBridge bus
    When the EventBridge event bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then the state machine is configured to publish execution events to the event bus
    Given smid in sm_status
    Given an execution has started and Step Functions has delivered a "STARTED" event to the EventBridge bus
    When the state machine is configured to publish execution events to the event bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given smid in sm_status
    Given an execution has started and Step Functions has delivered a "STARTED" event to the EventBridge bus
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid in sm_status
    Given an execution has started and Step Functions has delivered a "STARTED" event to the EventBridge bus
    When a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid in sm_status
    Given an execution has started and Step Functions has delivered a "STARTED" event to the EventBridge bus
    When a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution has started but the "STARTED" event delivery has failed because the bus is deleted
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given smid in sm_status
    Given an execution has started but the "STARTED" event delivery has failed because the bus is deleted
    When an EventBridge event bus is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given smid in sm_status
    Given an execution has started but the "STARTED" event delivery has failed because the bus is deleted
    When the EventBridge event bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then the state machine is configured to publish execution events to the event bus
    Given smid in sm_status
    Given an execution has started but the "STARTED" event delivery has failed because the bus is deleted
    When the state machine is configured to publish execution events to the event bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given smid in sm_status
    Given an execution has started but the "STARTED" event delivery has failed because the bus is deleted
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid in sm_status
    Given an execution has started but the "STARTED" event delivery has failed because the bus is deleted
    When a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid in sm_status
    Given an execution has started but the "STARTED" event delivery has failed because the bus is deleted
    When a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to the bus
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then an EventBridge event bus is created
    Given eid in exec_status
    Given a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to the bus
    When an EventBridge event bus is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then the EventBridge event bus is deleted
    Given eid in exec_status
    Given a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to the bus
    When the EventBridge event bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then the state machine is configured to publish execution events to the event bus
    Given eid in exec_status
    Given a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to the bus
    When the state machine is configured to publish execution events to the event bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given eid in exec_status
    Given a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to the bus
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given eid in exec_status
    Given a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to the bus
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given eid in exec_status
    Given a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to the bus
    When a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has succeeded but the "SUCCEEDED" event delivery has failed because the bus is deleted
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given eid in exec_status
    Given a running execution has succeeded but the "SUCCEEDED" event delivery has failed because the bus is deleted
    When an EventBridge event bus is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given eid in exec_status
    Given a running execution has succeeded but the "SUCCEEDED" event delivery has failed because the bus is deleted
    When the EventBridge event bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then the state machine is configured to publish execution events to the event bus
    Given eid in exec_status
    Given a running execution has succeeded but the "SUCCEEDED" event delivery has failed because the bus is deleted
    When the state machine is configured to publish execution events to the event bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given eid in exec_status
    Given a running execution has succeeded but the "SUCCEEDED" event delivery has failed because the bus is deleted
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given eid in exec_status
    Given a running execution has succeeded but the "SUCCEEDED" event delivery has failed because the bus is deleted
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given eid in exec_status
    Given a running execution has succeeded but the "SUCCEEDED" event delivery has failed because the bus is deleted
    When a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a Step Functions state machine is created then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an EventBridge event bus has been created
    When the EventBridge event bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a Step Functions state machine is created then the EventBridge event bus is deleted then the state machine is configured to publish execution events to the event bus
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given the EventBridge event bus has been deleted
    When the state machine is configured to publish execution events to the event bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a Step Functions state machine is created then the state machine is configured to publish execution events to the event bus then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given the state machine has been configured to publish execution events to the event bus
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a Step Functions state machine is created then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an execution has started and Step Functions has delivered a "STARTED" event to the EventBridge bus
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a Step Functions state machine is created then an execution starts but the "STARTED" event delivery fails because the bus is deleted then a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an execution has started but the "STARTED" event delivery has failed because the bus is deleted
    When a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a Step Functions state machine is created then a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to the bus
    When a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a Step Functions state machine is created then a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has succeeded but the "SUCCEEDED" event delivery has failed because the bus is deleted
    When an EventBridge event bus is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then a Step Functions state machine is created then the state machine is configured to publish execution events to the event bus
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given a Step Functions state machine has been created
    When the state machine is configured to publish execution events to the event bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given the EventBridge event bus has been deleted
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then the state machine is configured to publish execution events to the event bus then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given the state machine has been configured to publish execution events to the event bus
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given an execution has started and Step Functions has delivered a "STARTED" event to the EventBridge bus
    When a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then an execution starts but the "STARTED" event delivery fails because the bus is deleted then a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given an execution has started but the "STARTED" event delivery has failed because the bus is deleted
    When a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then a Step Functions state machine is created
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to the bus
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given busid not in bus_status
    Given an EventBridge event bus has been created
    Given a running execution has succeeded but the "SUCCEEDED" event delivery has failed because the bus is deleted
    When the EventBridge event bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a Step Functions state machine is created then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given a Step Functions state machine has been created
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given an EventBridge event bus has been created
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the state machine is configured to publish execution events to the event bus then a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given the state machine has been configured to publish execution events to the event bus
    When a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given an execution has started and Step Functions has delivered a "STARTED" event to the EventBridge bus
    When a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an execution starts but the "STARTED" event delivery fails because the bus is deleted then a Step Functions state machine is created
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given an execution has started but the "STARTED" event delivery has failed because the bus is deleted
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then an EventBridge event bus is created
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to the bus
    When an EventBridge event bus is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then the state machine is configured to publish execution events to the event bus
    Given busid in bus_status
    Given the EventBridge event bus has been deleted
    Given a running execution has succeeded but the "SUCCEEDED" event delivery has failed because the bus is deleted
    When the state machine is configured to publish execution events to the event bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then a Step Functions state machine is created then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given smid in sm_status
    Given the state machine has been configured to publish execution events to the event bus
    Given a Step Functions state machine has been created
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then an EventBridge event bus is created then a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid in sm_status
    Given the state machine has been configured to publish execution events to the event bus
    Given an EventBridge event bus has been created
    When a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then the EventBridge event bus is deleted then a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid in sm_status
    Given the state machine has been configured to publish execution events to the event bus
    Given the EventBridge event bus has been deleted
    When a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then a Step Functions state machine is created
    Given smid in sm_status
    Given the state machine has been configured to publish execution events to the event bus
    Given an execution has started and Step Functions has delivered a "STARTED" event to the EventBridge bus
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then an execution starts but the "STARTED" event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given smid in sm_status
    Given the state machine has been configured to publish execution events to the event bus
    Given an execution has started but the "STARTED" event delivery has failed because the bus is deleted
    When an EventBridge event bus is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then the EventBridge event bus is deleted
    Given smid in sm_status
    Given the state machine has been configured to publish execution events to the event bus
    Given a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to the bus
    When the EventBridge event bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given smid in sm_status
    Given the state machine has been configured to publish execution events to the event bus
    Given a running execution has succeeded but the "SUCCEEDED" event delivery has failed because the bus is deleted
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then a Step Functions state machine is created then a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid in sm_status
    Given an execution has started and Step Functions has delivered a "STARTED" event to the EventBridge bus
    Given a Step Functions state machine has been created
    When a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then an EventBridge event bus is created then a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid in sm_status
    Given an execution has started and Step Functions has delivered a "STARTED" event to the EventBridge bus
    Given an EventBridge event bus has been created
    When a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then the EventBridge event bus is deleted then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution has started and Step Functions has delivered a "STARTED" event to the EventBridge bus
    Given the EventBridge event bus has been deleted
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then the state machine is configured to publish execution events to the event bus then an EventBridge event bus is created
    Given smid in sm_status
    Given an execution has started and Step Functions has delivered a "STARTED" event to the EventBridge bus
    Given the state machine has been configured to publish execution events to the event bus
    When an EventBridge event bus is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then an execution starts but the "STARTED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given smid in sm_status
    Given an execution has started and Step Functions has delivered a "STARTED" event to the EventBridge bus
    Given an execution has started but the "STARTED" event delivery has failed because the bus is deleted
    When the EventBridge event bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then the state machine is configured to publish execution events to the event bus
    Given smid in sm_status
    Given an execution has started and Step Functions has delivered a "STARTED" event to the EventBridge bus
    Given a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to the bus
    When the state machine is configured to publish execution events to the event bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given smid in sm_status
    Given an execution has started and Step Functions has delivered a "STARTED" event to the EventBridge bus
    Given a running execution has succeeded but the "SUCCEEDED" event delivery has failed because the bus is deleted
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then a Step Functions state machine is created then a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid in sm_status
    Given an execution has started but the "STARTED" event delivery has failed because the bus is deleted
    Given a Step Functions state machine has been created
    When a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then an EventBridge event bus is created then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution has started but the "STARTED" event delivery has failed because the bus is deleted
    Given an EventBridge event bus has been created
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given smid in sm_status
    Given an execution has started but the "STARTED" event delivery has failed because the bus is deleted
    Given the EventBridge event bus has been deleted
    When an EventBridge event bus is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then the state machine is configured to publish execution events to the event bus then the EventBridge event bus is deleted
    Given smid in sm_status
    Given an execution has started but the "STARTED" event delivery has failed because the bus is deleted
    Given the state machine has been configured to publish execution events to the event bus
    When the EventBridge event bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then the state machine is configured to publish execution events to the event bus
    Given smid in sm_status
    Given an execution has started but the "STARTED" event delivery has failed because the bus is deleted
    Given an execution has started and Step Functions has delivered a "STARTED" event to the EventBridge bus
    When the state machine is configured to publish execution events to the event bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given smid in sm_status
    Given an execution has started but the "STARTED" event delivery has failed because the bus is deleted
    Given a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to the bus
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid in sm_status
    Given an execution has started but the "STARTED" event delivery has failed because the bus is deleted
    Given a running execution has succeeded but the "SUCCEEDED" event delivery has failed because the bus is deleted
    When a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then a Step Functions state machine is created then an EventBridge event bus is created
    Given eid in exec_status
    Given a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to the bus
    Given a Step Functions state machine has been created
    When an EventBridge event bus is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given eid in exec_status
    Given a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to the bus
    Given an EventBridge event bus has been created
    When the EventBridge event bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then the EventBridge event bus is deleted then the state machine is configured to publish execution events to the event bus
    Given eid in exec_status
    Given a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to the bus
    Given the EventBridge event bus has been deleted
    When the state machine is configured to publish execution events to the event bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then the state machine is configured to publish execution events to the event bus then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given eid in exec_status
    Given a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to the bus
    Given the state machine has been configured to publish execution events to the event bus
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given eid in exec_status
    Given a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to the bus
    Given an execution has started and Step Functions has delivered a "STARTED" event to the EventBridge bus
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then an execution starts but the "STARTED" event delivery fails because the bus is deleted then a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given eid in exec_status
    Given a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to the bus
    Given an execution has started but the "STARTED" event delivery has failed because the bus is deleted
    When a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to the bus
    Given a running execution has succeeded but the "SUCCEEDED" event delivery has failed because the bus is deleted
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a Step Functions state machine is created then the EventBridge event bus is deleted
    Given eid in exec_status
    Given a running execution has succeeded but the "SUCCEEDED" event delivery has failed because the bus is deleted
    Given a Step Functions state machine has been created
    When the EventBridge event bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then an EventBridge event bus is created then the state machine is configured to publish execution events to the event bus
    Given eid in exec_status
    Given a running execution has succeeded but the "SUCCEEDED" event delivery has failed because the bus is deleted
    Given an EventBridge event bus has been created
    When the state machine is configured to publish execution events to the event bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given eid in exec_status
    Given a running execution has succeeded but the "SUCCEEDED" event delivery has failed because the bus is deleted
    Given the EventBridge event bus has been deleted
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then the state machine is configured to publish execution events to the event bus then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given eid in exec_status
    Given a running execution has succeeded but the "SUCCEEDED" event delivery has failed because the bus is deleted
    Given the state machine has been configured to publish execution events to the event bus
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given eid in exec_status
    Given a running execution has succeeded but the "SUCCEEDED" event delivery has failed because the bus is deleted
    Given an execution has started and Step Functions has delivered a "STARTED" event to the EventBridge bus
    When a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then an execution starts but the "STARTED" event delivery fails because the bus is deleted then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has succeeded but the "SUCCEEDED" event delivery has failed because the bus is deleted
    Given an execution has started but the "STARTED" event delivery has failed because the bus is deleted
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then an EventBridge event bus is created
    Given eid in exec_status
    Given a running execution has succeeded but the "SUCCEEDED" event delivery has failed because the bus is deleted
    Given a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to the bus
    When an EventBridge event bus is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists
