@eventsstepfunctions @generated
Feature: EventsStepfunctions - Action Sequences

  # Generated from FizzBee spec: events_stepfunctions.fizz
  # Safety invariants: RuleReferencesActiveBus, ExecutionRequiresActiveStateMachine, ExecutionRequiresEnabledRule

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a Step Functions state machine is created
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    When a Step Functions state machine is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is created to start a Step Functions execution on matching events
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    When an EventBridge rule is created to start a Step Functions execution on matching events
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event is published to the bus and triggers a new Step Functions execution
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    When an event is published to the bus and triggers a new Step Functions execution
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a running execution completes successfully
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    When a running execution completes successfully
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a running execution fails
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    When a running execution fails
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an EventBridge event bus is created
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an EventBridge event bus is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an EventBridge rule is created to start a Step Functions execution on matching events
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an EventBridge rule is created to start a Step Functions execution on matching events
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an event is published to the bus and triggers a new Step Functions execution
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an event is published to the bus and triggers a new Step Functions execution
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution completes successfully
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution completes successfully
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution fails
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to start a Step Functions execution on matching events then an EventBridge event bus is created
    Given rid not in rule_status
    Given an EventBridge rule has been created to start a Step Functions execution on matching events
    When an EventBridge event bus is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to start a Step Functions execution on matching events then a Step Functions state machine is created
    Given rid not in rule_status
    Given an EventBridge rule has been created to start a Step Functions execution on matching events
    When a Step Functions state machine is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to start a Step Functions execution on matching events then an event is published to the bus and triggers a new Step Functions execution
    Given rid not in rule_status
    Given an EventBridge rule has been created to start a Step Functions execution on matching events
    When an event is published to the bus and triggers a new Step Functions execution
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to start a Step Functions execution on matching events then a running execution completes successfully
    Given rid not in rule_status
    Given an EventBridge rule has been created to start a Step Functions execution on matching events
    When a running execution completes successfully
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to start a Step Functions execution on matching events then a running execution fails
    Given rid not in rule_status
    Given an EventBridge rule has been created to start a Step Functions execution on matching events
    When a running execution fails
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an event is published to the bus and triggers a new Step Functions execution then an EventBridge event bus is created
    Given bid in bus_status
    Given an event has been published to the bus and has triggered a new Step Functions execution
    When an EventBridge event bus is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an event is published to the bus and triggers a new Step Functions execution then a Step Functions state machine is created
    Given bid in bus_status
    Given an event has been published to the bus and has triggered a new Step Functions execution
    When a Step Functions state machine is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an event is published to the bus and triggers a new Step Functions execution then an EventBridge rule is created to start a Step Functions execution on matching events
    Given bid in bus_status
    Given an event has been published to the bus and has triggered a new Step Functions execution
    When an EventBridge rule is created to start a Step Functions execution on matching events
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an event is published to the bus and triggers a new Step Functions execution then a running execution completes successfully
    Given bid in bus_status
    Given an event has been published to the bus and has triggered a new Step Functions execution
    When a running execution completes successfully
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an event is published to the bus and triggers a new Step Functions execution then a running execution fails
    Given bid in bus_status
    Given an event has been published to the bus and has triggered a new Step Functions execution
    When a running execution fails
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a running execution completes successfully then an EventBridge event bus is created
    Given eid in exec_status
    Given a running execution has completed successfully
    When an EventBridge event bus is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a running execution completes successfully then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has completed successfully
    When a Step Functions state machine is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a running execution completes successfully then an EventBridge rule is created to start a Step Functions execution on matching events
    Given eid in exec_status
    Given a running execution has completed successfully
    When an EventBridge rule is created to start a Step Functions execution on matching events
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a running execution completes successfully then an event is published to the bus and triggers a new Step Functions execution
    Given eid in exec_status
    Given a running execution has completed successfully
    When an event is published to the bus and triggers a new Step Functions execution
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a running execution completes successfully then a running execution fails
    Given eid in exec_status
    Given a running execution has completed successfully
    When a running execution fails
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a running execution fails then an EventBridge event bus is created
    Given eid in exec_status
    Given a running execution has failed
    When an EventBridge event bus is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a running execution fails then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has failed
    When a Step Functions state machine is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a running execution fails then an EventBridge rule is created to start a Step Functions execution on matching events
    Given eid in exec_status
    Given a running execution has failed
    When an EventBridge rule is created to start a Step Functions execution on matching events
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a running execution fails then an event is published to the bus and triggers a new Step Functions execution
    Given eid in exec_status
    Given a running execution has failed
    When an event is published to the bus and triggers a new Step Functions execution
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a running execution fails then a running execution completes successfully
    Given eid in exec_status
    Given a running execution has failed
    When a running execution completes successfully
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a Step Functions state machine is created then an EventBridge rule is created to start a Step Functions execution on matching events
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    Given a Step Functions state machine has been created
    When an EventBridge rule is created to start a Step Functions execution on matching events
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is created to start a Step Functions execution on matching events then an event is published to the bus and triggers a new Step Functions execution
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    Given an EventBridge rule has been created to start a Step Functions execution on matching events
    When an event is published to the bus and triggers a new Step Functions execution
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event is published to the bus and triggers a new Step Functions execution then a running execution completes successfully
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    Given an event has been published to the bus and has triggered a new Step Functions execution
    When a running execution completes successfully
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a running execution completes successfully then a running execution fails
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    Given a running execution has completed successfully
    When a running execution fails
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a running execution fails then a Step Functions state machine is created
    Given bid not in bus_status
    Given an EventBridge event bus has been created
    Given a running execution has failed
    When a Step Functions state machine is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an EventBridge event bus is created then an event is published to the bus and triggers a new Step Functions execution
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an EventBridge event bus has been created
    When an event is published to the bus and triggers a new Step Functions execution
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an EventBridge rule is created to start a Step Functions execution on matching events then a running execution completes successfully
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an EventBridge rule has been created to start a Step Functions execution on matching events
    When a running execution completes successfully
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an event is published to the bus and triggers a new Step Functions execution then a running execution fails
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an event has been published to the bus and has triggered a new Step Functions execution
    When a running execution fails
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution completes successfully then an EventBridge event bus is created
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has completed successfully
    When an EventBridge event bus is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails then an EventBridge rule is created to start a Step Functions execution on matching events
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has failed
    When an EventBridge rule is created to start a Step Functions execution on matching events
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to start a Step Functions execution on matching events then an EventBridge event bus is created then a running execution completes successfully
    Given rid not in rule_status
    Given an EventBridge rule has been created to start a Step Functions execution on matching events
    Given an EventBridge event bus has been created
    When a running execution completes successfully
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to start a Step Functions execution on matching events then a Step Functions state machine is created then a running execution fails
    Given rid not in rule_status
    Given an EventBridge rule has been created to start a Step Functions execution on matching events
    Given a Step Functions state machine has been created
    When a running execution fails
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to start a Step Functions execution on matching events then an event is published to the bus and triggers a new Step Functions execution then an EventBridge event bus is created
    Given rid not in rule_status
    Given an EventBridge rule has been created to start a Step Functions execution on matching events
    Given an event has been published to the bus and has triggered a new Step Functions execution
    When an EventBridge event bus is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to start a Step Functions execution on matching events then a running execution completes successfully then a Step Functions state machine is created
    Given rid not in rule_status
    Given an EventBridge rule has been created to start a Step Functions execution on matching events
    Given a running execution has completed successfully
    When a Step Functions state machine is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an EventBridge rule is created to start a Step Functions execution on matching events then a running execution fails then an event is published to the bus and triggers a new Step Functions execution
    Given rid not in rule_status
    Given an EventBridge rule has been created to start a Step Functions execution on matching events
    Given a running execution has failed
    When an event is published to the bus and triggers a new Step Functions execution
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an event is published to the bus and triggers a new Step Functions execution then an EventBridge event bus is created then a running execution fails
    Given bid in bus_status
    Given an event has been published to the bus and has triggered a new Step Functions execution
    Given an EventBridge event bus has been created
    When a running execution fails
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an event is published to the bus and triggers a new Step Functions execution then a Step Functions state machine is created then an EventBridge event bus is created
    Given bid in bus_status
    Given an event has been published to the bus and has triggered a new Step Functions execution
    Given a Step Functions state machine has been created
    When an EventBridge event bus is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an event is published to the bus and triggers a new Step Functions execution then an EventBridge rule is created to start a Step Functions execution on matching events then a Step Functions state machine is created
    Given bid in bus_status
    Given an event has been published to the bus and has triggered a new Step Functions execution
    Given an EventBridge rule has been created to start a Step Functions execution on matching events
    When a Step Functions state machine is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an event is published to the bus and triggers a new Step Functions execution then a running execution completes successfully then an EventBridge rule is created to start a Step Functions execution on matching events
    Given bid in bus_status
    Given an event has been published to the bus and has triggered a new Step Functions execution
    Given a running execution has completed successfully
    When an EventBridge rule is created to start a Step Functions execution on matching events
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: an event is published to the bus and triggers a new Step Functions execution then a running execution fails then a running execution completes successfully
    Given bid in bus_status
    Given an event has been published to the bus and has triggered a new Step Functions execution
    Given a running execution has failed
    When a running execution completes successfully
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a running execution completes successfully then an EventBridge event bus is created then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has completed successfully
    Given an EventBridge event bus has been created
    When a Step Functions state machine is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a running execution completes successfully then a Step Functions state machine is created then an EventBridge rule is created to start a Step Functions execution on matching events
    Given eid in exec_status
    Given a running execution has completed successfully
    Given a Step Functions state machine has been created
    When an EventBridge rule is created to start a Step Functions execution on matching events
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a running execution completes successfully then an EventBridge rule is created to start a Step Functions execution on matching events then an event is published to the bus and triggers a new Step Functions execution
    Given eid in exec_status
    Given a running execution has completed successfully
    Given an EventBridge rule has been created to start a Step Functions execution on matching events
    When an event is published to the bus and triggers a new Step Functions execution
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a running execution completes successfully then an event is published to the bus and triggers a new Step Functions execution then a running execution fails
    Given eid in exec_status
    Given a running execution has completed successfully
    Given an event has been published to the bus and has triggered a new Step Functions execution
    When a running execution fails
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a running execution completes successfully then a running execution fails then an EventBridge event bus is created
    Given eid in exec_status
    Given a running execution has completed successfully
    Given a running execution has failed
    When an EventBridge event bus is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a running execution fails then an EventBridge event bus is created then an EventBridge rule is created to start a Step Functions execution on matching events
    Given eid in exec_status
    Given a running execution has failed
    Given an EventBridge event bus has been created
    When an EventBridge rule is created to start a Step Functions execution on matching events
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a running execution fails then a Step Functions state machine is created then an event is published to the bus and triggers a new Step Functions execution
    Given eid in exec_status
    Given a running execution has failed
    Given a Step Functions state machine has been created
    When an event is published to the bus and triggers a new Step Functions execution
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a running execution fails then an EventBridge rule is created to start a Step Functions execution on matching events then a running execution completes successfully
    Given eid in exec_status
    Given a running execution has failed
    Given an EventBridge rule has been created to start a Step Functions execution on matching events
    When a running execution completes successfully
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a running execution fails then an event is published to the bus and triggers a new Step Functions execution then an EventBridge event bus is created
    Given eid in exec_status
    Given a running execution has failed
    Given an event has been published to the bus and has triggered a new Step Functions execution
    When an EventBridge event bus is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @exhaustive @sequence
  Scenario: a running execution fails then a running execution completes successfully then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has failed
    Given a running execution has completed successfully
    When a Step Functions state machine is created
    Then every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule
