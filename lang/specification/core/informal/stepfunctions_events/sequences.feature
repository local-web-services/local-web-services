@stepfunctionsevents @generated
Feature: StepfunctionsEvents - Action Sequences

  # Generated from FizzBee spec: stepfunctions_events.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, DeliveredEventReferencesExistingExecution

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "step functions" "state machine" is created then an "eventbridge" "bus" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "eventbridge" "bus" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then the "eventbridge" "bus" is deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "step functions" "state machine" is created
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "eventbridge" "bus" is deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "step functions" "state machine" is created
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" then a "step functions" "state machine" is created
    Given smid in sm_status
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" then an "eventbridge" "bus" is created
    Given smid in sm_status
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    When an "eventbridge" "bus" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" then the "eventbridge" "bus" is deleted
    Given smid in sm_status
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    When the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" then a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    Given smid in sm_status
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" then a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given smid in sm_status
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid in sm_status
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid in sm_status
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" then a "step functions" "state machine" is created
    Given smid in sm_status
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" then an "eventbridge" "bus" is created
    Given smid in sm_status
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    When an "eventbridge" "bus" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" then the "eventbridge" "bus" is deleted
    Given smid in sm_status
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    When the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" then the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    Given smid in sm_status
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" then a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given smid in sm_status
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid in sm_status
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid in sm_status
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then a "step functions" "state machine" is created
    Given smid in sm_status
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created
    Given smid in sm_status
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then the "eventbridge" "bus" is deleted
    Given smid in sm_status
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    Given smid in sm_status
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    Given smid in sm_status
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid in sm_status
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid in sm_status
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then an "eventbridge" "bus" is created
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When an "eventbridge" "bus" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then the "eventbridge" "bus" is deleted
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then an "eventbridge" "bus" is created
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When an "eventbridge" "bus" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then the "eventbridge" "bus" is deleted
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then an "eventbridge" "bus" is created then the "eventbridge" "bus" is deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "eventbridge" "bus" is created
    When the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then the "eventbridge" "bus" is deleted then the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "eventbridge" "bus" is deleted
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" then a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" then a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then an "eventbridge" "bus" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When an "eventbridge" "bus" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "step functions" "state machine" is created then the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "step functions" "state machine" is created
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "eventbridge" "bus" is deleted then a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "eventbridge" "bus" is deleted
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" then a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then a "step functions" "state machine" is created
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then the "eventbridge" "bus" is deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "step functions" "state machine" is created then a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "step functions" "state machine" is created
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created then a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then a "step functions" "state machine" is created
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then an "eventbridge" "bus" is created
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When an "eventbridge" "bus" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" then a "step functions" "state machine" is created then a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given smid in sm_status
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    When a "step functions" "state machine" is created
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" then an "eventbridge" "bus" is created then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid in sm_status
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    When an "eventbridge" "bus" is created
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" then the "eventbridge" "bus" is deleted then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid in sm_status
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    When the "eventbridge" "bus" is deleted
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" then a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" then a "step functions" "state machine" is created
    Given smid in sm_status
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" then a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created
    Given smid in sm_status
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then the "eventbridge" "bus" is deleted
    Given smid in sm_status
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    Given smid in sm_status
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" then a "step functions" "state machine" is created then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid in sm_status
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" then an "eventbridge" "bus" is created then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid in sm_status
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    When an "eventbridge" "bus" is created
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" then the "eventbridge" "bus" is deleted then a "step functions" "state machine" is created
    Given smid in sm_status
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    When the "eventbridge" "bus" is deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" then the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" then an "eventbridge" "bus" is created
    Given smid in sm_status
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    When an "eventbridge" "bus" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" then a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then the "eventbridge" "bus" is deleted
    Given smid in sm_status
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    Given smid in sm_status
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given smid in sm_status
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then a "step functions" "state machine" is created then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given smid in sm_status
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created then a "step functions" "state machine" is created
    Given smid in sm_status
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then the "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created
    Given smid in sm_status
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When the "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" then the "eventbridge" "bus" is deleted
    Given smid in sm_status
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    When the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" then the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    Given smid in sm_status
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    Given smid in sm_status
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given smid in sm_status
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then a "step functions" "state machine" is created then an "eventbridge" "bus" is created
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When a "step functions" "state machine" is created
    When an "eventbridge" "bus" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then an "eventbridge" "bus" is created then the "eventbridge" "bus" is deleted
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When an "eventbridge" "bus" is created
    When the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then the "eventbridge" "bus" is deleted then the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When the "eventbridge" "bus" is deleted
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" then a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" then a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a "step functions" "state machine" is created then the "eventbridge" "bus" is deleted
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When a "step functions" "state machine" is created
    When the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then an "eventbridge" "bus" is created then the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When an "eventbridge" "bus" is created
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then the "eventbridge" "bus" is deleted then a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When the "eventbridge" "bus" is deleted
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" then a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @sequence
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted then a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus then an "eventbridge" "bus" is created
    Given eid in exec_status
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    When an "eventbridge" "bus" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists
