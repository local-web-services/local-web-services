@eventsstepfunctions @generated
Feature: EventsStepfunctions - An Event Is Published To The Bus And Triggers A New Step Functions Execution

  # Generated from FizzBee spec: events_stepfunctions.fizz
  # Safety invariants: RuleReferencesActiveBus, ExecutionRequiresActiveStateMachine, ExecutionRequiresEnabledRule

  Background:
    Given the system is initialized

  @minimal @happy @put_event
  Scenario: an event is published to the bus and triggers a new Step Functions execution
    Given the event bus exists
    And the event bus is "ACTIVE"
    And an "ENABLED" rule exists on the bus targeting a state machine
    And the target state machine is "ACTIVE"
    And an execution slot is available
    When an event is published to the bus and triggers a new Step Functions execution
    Then the execution is "RUNNING"
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @standard @negative @put_event
  Scenario: an event is published to the bus and triggers a new Step Functions execution fails when the event bus does not exist
    Given the event bus does not exist
    When an event is published to the bus and triggers a new Step Functions execution
    Then the operation is rejected

  @standard @negative @put_event @lifecycle
  Scenario: an event is published to the bus and triggers a new Step Functions execution fails when the event bus is not "ACTIVE"
    Given the event bus exists
    And the event bus is not "ACTIVE"
    When an event is published to the bus and triggers a new Step Functions execution
    Then the operation is rejected

  @standard @negative @put_event @lifecycle
  Scenario: an event is published to the bus and triggers a new Step Functions execution fails when no "ENABLED" rule exists on the bus targeting a state machine
    Given the event bus exists
    And the event bus is "ACTIVE"
    And no "ENABLED" rule exists on the bus targeting a state machine
    When an event is published to the bus and triggers a new Step Functions execution
    Then the operation is rejected

  @standard @negative @put_event @lifecycle
  Scenario: an event is published to the bus and triggers a new Step Functions execution fails when the target state machine is not "ACTIVE"
    Given the event bus exists
    And the event bus is "ACTIVE"
    And an "ENABLED" rule exists on the bus targeting a state machine
    And the target state machine is not "ACTIVE"
    When an event is published to the bus and triggers a new Step Functions execution
    Then the operation is rejected

  @standard @negative @internal @put_event @capacity
  Scenario: an event is published to the bus and triggers a new Step Functions execution fails when no execution slot is available
    Given the event bus exists
    And the event bus is "ACTIVE"
    And an "ENABLED" rule exists on the bus targeting a state machine
    And the target state machine is "ACTIVE"
    And no execution slot is available
    When an event is published to the bus and triggers a new Step Functions execution
    Then the operation is rejected
