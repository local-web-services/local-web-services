@eventsstepfunctions @generated
Feature: EventsStepfunctions - Action Sequences

  # Generated from FizzBee spec: events_stepfunctions.fizz
  # Safety invariants: RuleReferencesActiveBus, ExecutionRequiresActiveStateMachine, ExecutionRequiresEnabledRule

  Background:
    Given the system is initialized

  @sequence
  Scenario: an EventBridge event bus is created then a "step functions" "state machine" is created
    Given bid not in bus_status
    When an EventBridge event bus is created
    When a "step functions" "state machine" is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an EventBridge event bus is created then an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an EventBridge event bus is created then an event is published to the bus and triggers a new Step Functions execution
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an event is published to the bus and triggers a new Step Functions execution
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an EventBridge event bus is created then a running "step functions" "execution" completes successfully
    Given bid not in bus_status
    When an EventBridge event bus is created
    When a running "step functions" "execution" completes successfully
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an EventBridge event bus is created then a running "step functions" "execution" fails
    Given bid not in bus_status
    When an EventBridge event bus is created
    When a running "step functions" "execution" fails
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a "step functions" "state machine" is created then an EventBridge event bus is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a "step functions" "state machine" is created then an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a "step functions" "state machine" is created then an event is published to the bus and triggers a new Step Functions execution
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an event is published to the bus and triggers a new Step Functions execution
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" completes successfully
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" completes successfully
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events then an EventBridge event bus is created
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events then a "step functions" "state machine" is created
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When a "step functions" "state machine" is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events then an event is published to the bus and triggers a new Step Functions execution
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When an event is published to the bus and triggers a new Step Functions execution
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events then a running "step functions" "execution" completes successfully
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When a running "step functions" "execution" completes successfully
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events then a running "step functions" "execution" fails
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When a running "step functions" "execution" fails
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an event is published to the bus and triggers a new Step Functions execution then an EventBridge event bus is created
    Given bid in bus_status
    When an event is published to the bus and triggers a new Step Functions execution
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an event is published to the bus and triggers a new Step Functions execution then a "step functions" "state machine" is created
    Given bid in bus_status
    When an event is published to the bus and triggers a new Step Functions execution
    When a "step functions" "state machine" is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an event is published to the bus and triggers a new Step Functions execution then an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Given bid in bus_status
    When an event is published to the bus and triggers a new Step Functions execution
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an event is published to the bus and triggers a new Step Functions execution then a running "step functions" "execution" completes successfully
    Given bid in bus_status
    When an event is published to the bus and triggers a new Step Functions execution
    When a running "step functions" "execution" completes successfully
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an event is published to the bus and triggers a new Step Functions execution then a running "step functions" "execution" fails
    Given bid in bus_status
    When an event is published to the bus and triggers a new Step Functions execution
    When a running "step functions" "execution" fails
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then an EventBridge event bus is created
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When a "step functions" "state machine" is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then an event is published to the bus and triggers a new Step Functions execution
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When an event is published to the bus and triggers a new Step Functions execution
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then a running "step functions" "execution" fails
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When a running "step functions" "execution" fails
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a running "step functions" "execution" fails then an EventBridge event bus is created
    Given eid in exec_status
    When a running "step functions" "execution" fails
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a running "step functions" "execution" fails then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails
    When a "step functions" "state machine" is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a running "step functions" "execution" fails then an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Given eid in exec_status
    When a running "step functions" "execution" fails
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a running "step functions" "execution" fails then an event is published to the bus and triggers a new Step Functions execution
    Given eid in exec_status
    When a running "step functions" "execution" fails
    When an event is published to the bus and triggers a new Step Functions execution
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a running "step functions" "execution" fails then a running "step functions" "execution" completes successfully
    Given eid in exec_status
    When a running "step functions" "execution" fails
    When a running "step functions" "execution" completes successfully
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an EventBridge event bus is created then a "step functions" "state machine" is created then an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Given bid not in bus_status
    When an EventBridge event bus is created
    When a "step functions" "state machine" is created
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an EventBridge event bus is created then an "eventbridge" "rule" is created to start a Step Functions execution on matching events then an event is published to the bus and triggers a new Step Functions execution
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When an event is published to the bus and triggers a new Step Functions execution
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an EventBridge event bus is created then an event is published to the bus and triggers a new Step Functions execution then a running "step functions" "execution" completes successfully
    Given bid not in bus_status
    When an EventBridge event bus is created
    When an event is published to the bus and triggers a new Step Functions execution
    When a running "step functions" "execution" completes successfully
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an EventBridge event bus is created then a running "step functions" "execution" completes successfully then a running "step functions" "execution" fails
    Given bid not in bus_status
    When an EventBridge event bus is created
    When a running "step functions" "execution" completes successfully
    When a running "step functions" "execution" fails
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an EventBridge event bus is created then a running "step functions" "execution" fails then a "step functions" "state machine" is created
    Given bid not in bus_status
    When an EventBridge event bus is created
    When a running "step functions" "execution" fails
    When a "step functions" "state machine" is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a "step functions" "state machine" is created then an EventBridge event bus is created then an event is published to the bus and triggers a new Step Functions execution
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an EventBridge event bus is created
    When an event is published to the bus and triggers a new Step Functions execution
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a "step functions" "state machine" is created then an "eventbridge" "rule" is created to start a Step Functions execution on matching events then a running "step functions" "execution" completes successfully
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When a running "step functions" "execution" completes successfully
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a "step functions" "state machine" is created then an event is published to the bus and triggers a new Step Functions execution then a running "step functions" "execution" fails
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an event is published to the bus and triggers a new Step Functions execution
    When a running "step functions" "execution" fails
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" completes successfully then an EventBridge event bus is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" completes successfully
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails then an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events then an EventBridge event bus is created then a running "step functions" "execution" completes successfully
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When an EventBridge event bus is created
    When a running "step functions" "execution" completes successfully
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events then a "step functions" "state machine" is created then a running "step functions" "execution" fails
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events then an event is published to the bus and triggers a new Step Functions execution then an EventBridge event bus is created
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When an event is published to the bus and triggers a new Step Functions execution
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events then a running "step functions" "execution" completes successfully then a "step functions" "state machine" is created
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When a running "step functions" "execution" completes successfully
    When a "step functions" "state machine" is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events then a running "step functions" "execution" fails then an event is published to the bus and triggers a new Step Functions execution
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When a running "step functions" "execution" fails
    When an event is published to the bus and triggers a new Step Functions execution
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an event is published to the bus and triggers a new Step Functions execution then an EventBridge event bus is created then a running "step functions" "execution" fails
    Given bid in bus_status
    When an event is published to the bus and triggers a new Step Functions execution
    When an EventBridge event bus is created
    When a running "step functions" "execution" fails
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an event is published to the bus and triggers a new Step Functions execution then a "step functions" "state machine" is created then an EventBridge event bus is created
    Given bid in bus_status
    When an event is published to the bus and triggers a new Step Functions execution
    When a "step functions" "state machine" is created
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an event is published to the bus and triggers a new Step Functions execution then an "eventbridge" "rule" is created to start a Step Functions execution on matching events then a "step functions" "state machine" is created
    Given bid in bus_status
    When an event is published to the bus and triggers a new Step Functions execution
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When a "step functions" "state machine" is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an event is published to the bus and triggers a new Step Functions execution then a running "step functions" "execution" completes successfully then an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Given bid in bus_status
    When an event is published to the bus and triggers a new Step Functions execution
    When a running "step functions" "execution" completes successfully
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: an event is published to the bus and triggers a new Step Functions execution then a running "step functions" "execution" fails then a running "step functions" "execution" completes successfully
    Given bid in bus_status
    When an event is published to the bus and triggers a new Step Functions execution
    When a running "step functions" "execution" fails
    When a running "step functions" "execution" completes successfully
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then an EventBridge event bus is created then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When an EventBridge event bus is created
    When a "step functions" "state machine" is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then a "step functions" "state machine" is created then an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When a "step functions" "state machine" is created
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then an "eventbridge" "rule" is created to start a Step Functions execution on matching events then an event is published to the bus and triggers a new Step Functions execution
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When an event is published to the bus and triggers a new Step Functions execution
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then an event is published to the bus and triggers a new Step Functions execution then a running "step functions" "execution" fails
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When an event is published to the bus and triggers a new Step Functions execution
    When a running "step functions" "execution" fails
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then a running "step functions" "execution" fails then an EventBridge event bus is created
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When a running "step functions" "execution" fails
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a running "step functions" "execution" fails then an EventBridge event bus is created then an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Given eid in exec_status
    When a running "step functions" "execution" fails
    When an EventBridge event bus is created
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a running "step functions" "execution" fails then a "step functions" "state machine" is created then an event is published to the bus and triggers a new Step Functions execution
    Given eid in exec_status
    When a running "step functions" "execution" fails
    When a "step functions" "state machine" is created
    When an event is published to the bus and triggers a new Step Functions execution
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a running "step functions" "execution" fails then an "eventbridge" "rule" is created to start a Step Functions execution on matching events then a running "step functions" "execution" completes successfully
    Given eid in exec_status
    When a running "step functions" "execution" fails
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When a running "step functions" "execution" completes successfully
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a running "step functions" "execution" fails then an event is published to the bus and triggers a new Step Functions execution then an EventBridge event bus is created
    Given eid in exec_status
    When a running "step functions" "execution" fails
    When an event is published to the bus and triggers a new Step Functions execution
    When an EventBridge event bus is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @sequence
  Scenario: a running "step functions" "execution" fails then a running "step functions" "execution" completes successfully then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails
    When a running "step functions" "execution" completes successfully
    When a "step functions" "state machine" is created
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule
