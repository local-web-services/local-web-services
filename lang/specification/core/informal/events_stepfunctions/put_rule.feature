@eventsstepfunctions @generated
Feature: EventsStepfunctions - An "Eventbridge" "Rule" Is Created To Start A Step Functions Execution On Matching Events

  # Generated from FizzBee spec: events_stepfunctions.fizz
  # Safety invariants: RuleReferencesActiveBus, ExecutionRequiresActiveStateMachine, ExecutionRequiresEnabledRule

  Background:
    Given the system is initialized

  @minimal @happy @put_rule
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Given the event bus existed
    And the event bus was "ACTIVE"
    And the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the rule did not already exist
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Then the rule will be "ENABLED" and will trigger an execution when matching events are published
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @guard @negative @put_rule
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events fails when the event bus did not exist
    Given the event bus did not exist
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Then the operation is rejected

  @guard @negative @put_rule @lifecycle
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events fails when the event bus was not "ACTIVE"
    Given the event bus existed
    And the event bus was not "ACTIVE"
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Then the operation is rejected

  @guard @negative @put_rule
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events fails when the "step functions" "state machine" did not exist
    Given the event bus existed
    And the event bus was "ACTIVE"
    And the "step functions" "state machine" did not exist
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Then the operation is rejected

  @guard @negative @put_rule @lifecycle
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events fails when the "step functions" "state machine" was not "ACTIVE"
    Given the event bus existed
    And the event bus was "ACTIVE"
    And the "step functions" "state machine" existed
    And the "step functions" "state machine" was not "ACTIVE"
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Then the operation is rejected

  @guard @negative @put_rule
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events fails when the rule already existed
    Given the event bus existed
    And the event bus was "ACTIVE"
    And the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the rule already existed
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Then the operation is rejected
