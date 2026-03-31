@stepfunctionsevents @generated
Feature: StepfunctionsEvents - Action Sequences

  # Generated from FizzBee spec: stepfunctions_events.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, DeliveredEventReferencesExistingExecution

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "step functions" "state machine" is created then an EventBridge event bus is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an EventBridge event bus is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then the EventBridge event bus is deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the EventBridge event bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then the state machine is configured to publish execution events to the event bus
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the state machine is configured to publish execution events to the event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then a "step functions" "state machine" is created
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then the state machine is configured to publish execution events to the event bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the state machine is configured to publish execution events to the event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a "step functions" "state machine" is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the state machine is configured to publish execution events to the event bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the state machine is configured to publish execution events to the event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then a "step functions" "state machine" is created
    Given smid in sm_status
    When the state machine is configured to publish execution events to the event bus
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then an EventBridge event bus is created
    Given smid in sm_status
    When the state machine is configured to publish execution events to the event bus
    When an EventBridge event bus is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then the EventBridge event bus is deleted
    Given smid in sm_status
    When the state machine is configured to publish execution events to the event bus
    When the EventBridge event bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given smid in sm_status
    When the state machine is configured to publish execution events to the event bus
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given smid in sm_status
    When the state machine is configured to publish execution events to the event bus
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid in sm_status
    When the state machine is configured to publish execution events to the event bus
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid in sm_status
    When the state machine is configured to publish execution events to the event bus
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then a "step functions" "state machine" is created
    Given smid in sm_status
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then an EventBridge event bus is created
    Given smid in sm_status
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    When an EventBridge event bus is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then the EventBridge event bus is deleted
    Given smid in sm_status
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    When the EventBridge event bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then the state machine is configured to publish execution events to the event bus
    Given smid in sm_status
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    When the state machine is configured to publish execution events to the event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given smid in sm_status
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid in sm_status
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid in sm_status
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then a "step functions" "state machine" is created
    Given smid in sm_status
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given smid in sm_status
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given smid in sm_status
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then the state machine is configured to publish execution events to the event bus
    Given smid in sm_status
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    When the state machine is configured to publish execution events to the event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given smid in sm_status
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid in sm_status
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid in sm_status
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then an EventBridge event bus is created
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When an EventBridge event bus is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then the EventBridge event bus is deleted
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When the EventBridge event bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then the state machine is configured to publish execution events to the event bus
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When the state machine is configured to publish execution events to the event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then the state machine is configured to publish execution events to the event bus
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When the state machine is configured to publish execution events to the event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then the EventBridge event bus is deleted then the state machine is configured to publish execution events to the event bus
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the EventBridge event bus is deleted
    When the state machine is configured to publish execution events to the event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then the state machine is configured to publish execution events to the event bus then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the state machine is configured to publish execution events to the event bus
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then an execution starts but the "STARTED" event delivery fails because the bus is deleted then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then a "step functions" "state machine" is created then the state machine is configured to publish execution events to the event bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a "step functions" "state machine" is created
    When the state machine is configured to publish execution events to the event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then the EventBridge event bus is deleted then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then the state machine is configured to publish execution events to the event bus then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When the state machine is configured to publish execution events to the event bus
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then an execution starts but the "STARTED" event delivery fails because the bus is deleted then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then a "step functions" "state machine" is created
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an EventBridge event bus is created then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a "step functions" "state machine" is created then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a "step functions" "state machine" is created
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an EventBridge event bus is created then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then the state machine is configured to publish execution events to the event bus then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When the state machine is configured to publish execution events to the event bus
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then an execution starts but the "STARTED" event delivery fails because the bus is deleted then a "step functions" "state machine" is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then an EventBridge event bus is created
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When an EventBridge event bus is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the EventBridge event bus is deleted then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then the state machine is configured to publish execution events to the event bus
    Given busid in bus_status
    When the EventBridge event bus is deleted
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When the state machine is configured to publish execution events to the event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then a "step functions" "state machine" is created then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given smid in sm_status
    When the state machine is configured to publish execution events to the event bus
    When a "step functions" "state machine" is created
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then an EventBridge event bus is created then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid in sm_status
    When the state machine is configured to publish execution events to the event bus
    When an EventBridge event bus is created
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then the EventBridge event bus is deleted then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid in sm_status
    When the state machine is configured to publish execution events to the event bus
    When the EventBridge event bus is deleted
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then a "step functions" "state machine" is created
    Given smid in sm_status
    When the state machine is configured to publish execution events to the event bus
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then an execution starts but the "STARTED" event delivery fails because the bus is deleted then an EventBridge event bus is created
    Given smid in sm_status
    When the state machine is configured to publish execution events to the event bus
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then the EventBridge event bus is deleted
    Given smid in sm_status
    When the state machine is configured to publish execution events to the event bus
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When the EventBridge event bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: the state machine is configured to publish execution events to the event bus then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given smid in sm_status
    When the state machine is configured to publish execution events to the event bus
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then a "step functions" "state machine" is created then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid in sm_status
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then an EventBridge event bus is created then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid in sm_status
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    When an EventBridge event bus is created
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then the EventBridge event bus is deleted then a "step functions" "state machine" is created
    Given smid in sm_status
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    When the EventBridge event bus is deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then the state machine is configured to publish execution events to the event bus then an EventBridge event bus is created
    Given smid in sm_status
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    When the state machine is configured to publish execution events to the event bus
    When an EventBridge event bus is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then an execution starts but the "STARTED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted
    Given smid in sm_status
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then the state machine is configured to publish execution events to the event bus
    Given smid in sm_status
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When the state machine is configured to publish execution events to the event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given smid in sm_status
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then a "step functions" "state machine" is created then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid in sm_status
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then an EventBridge event bus is created then a "step functions" "state machine" is created
    Given smid in sm_status
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted then an EventBridge event bus is created
    Given smid in sm_status
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    When an EventBridge event bus is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then the state machine is configured to publish execution events to the event bus then the EventBridge event bus is deleted
    Given smid in sm_status
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    When the state machine is configured to publish execution events to the event bus
    When the EventBridge event bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then the state machine is configured to publish execution events to the event bus
    Given smid in sm_status
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    When the state machine is configured to publish execution events to the event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given smid in sm_status
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid in sm_status
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then a "step functions" "state machine" is created then an EventBridge event bus is created
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When a "step functions" "state machine" is created
    When an EventBridge event bus is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then an EventBridge event bus is created then the EventBridge event bus is deleted
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When an EventBridge event bus is created
    When the EventBridge event bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then the EventBridge event bus is deleted then the state machine is configured to publish execution events to the event bus
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When the EventBridge event bus is deleted
    When the state machine is configured to publish execution events to the event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then the state machine is configured to publish execution events to the event bus then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When the state machine is configured to publish execution events to the event bus
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then an execution starts but the "STARTED" event delivery fails because the bus is deleted then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a "step functions" "state machine" is created then the EventBridge event bus is deleted
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When a "step functions" "state machine" is created
    When the EventBridge event bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then an EventBridge event bus is created then the state machine is configured to publish execution events to the event bus
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When an EventBridge event bus is created
    When the state machine is configured to publish execution events to the event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then the EventBridge event bus is deleted then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When the EventBridge event bus is deleted
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then the state machine is configured to publish execution events to the event bus then an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When the state machine is configured to publish execution events to the event bus
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then an execution starts but the "STARTED" event delivery fails because the bus is deleted then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then an EventBridge event bus is created
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When an EventBridge event bus is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists
