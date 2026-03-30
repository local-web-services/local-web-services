@eventsstepfunctions @generated
Feature: EventsStepfunctions - An Eventbridge Rule Is Created To Start A Step Functions Execution On Matching Events

  # Generated from FizzBee spec: events_stepfunctions.fizz
  # Safety invariants: RuleReferencesActiveBus, ExecutionRequiresActiveStateMachine, ExecutionRequiresEnabledRule

  Background:
    Given the system is initialized

  @minimal @happy @put_rule
  Scenario: an EventBridge rule is created to start a Step Functions execution on matching events
    Given the event bus exists
    And the event bus is "ACTIVE"
    And the state machine exists
    And the state machine is "ACTIVE"
    And the rule does not already exist
    When an EventBridge rule is created to start a Step Functions execution on matching events
    Then the rule is "ENABLED" and will trigger an execution when matching events are published
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @guard @negative @put_rule
  Scenario: an EventBridge rule is created to start a Step Functions execution on matching events fails when the event bus does not exist
    Given the event bus does not exist
    When an EventBridge rule is created to start a Step Functions execution on matching events
    Then the operation is rejected

  @guard @negative @put_rule @lifecycle
  Scenario: an EventBridge rule is created to start a Step Functions execution on matching events fails when the event bus is not "ACTIVE"
    Given the event bus exists
    And the event bus is not "ACTIVE"
    When an EventBridge rule is created to start a Step Functions execution on matching events
    Then the operation is rejected

  @guard @negative @put_rule
  Scenario: an EventBridge rule is created to start a Step Functions execution on matching events fails when the state machine does not exist
    Given the event bus exists
    And the event bus is "ACTIVE"
    And the state machine does not exist
    When an EventBridge rule is created to start a Step Functions execution on matching events
    Then the operation is rejected

  @guard @negative @put_rule @lifecycle
  Scenario: an EventBridge rule is created to start a Step Functions execution on matching events fails when the state machine is not "ACTIVE"
    Given the event bus exists
    And the event bus is "ACTIVE"
    And the state machine exists
    And the state machine is not "ACTIVE"
    When an EventBridge rule is created to start a Step Functions execution on matching events
    Then the operation is rejected

  @guard @negative @put_rule
  Scenario: an EventBridge rule is created to start a Step Functions execution on matching events fails when the rule already exists
    Given the event bus exists
    And the event bus is "ACTIVE"
    And the state machine exists
    And the state machine is "ACTIVE"
    And the rule already exists
    When an EventBridge rule is created to start a Step Functions execution on matching events
    Then the operation is rejected
