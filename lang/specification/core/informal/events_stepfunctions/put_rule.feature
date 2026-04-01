@eventsstepfunctions @generated
Feature: EventsStepfunctions - An "Eventbridge" "Rule" Is Created To Start A Step Functions Execution On Matching Events

  # Generated from FizzBee spec: events_stepfunctions.fizz
  # Safety invariants: RuleReferencesActiveBus, ExecutionRequiresActiveStateMachine, ExecutionRequiresEnabledRule

  Background:
    Given the system is initialized

  @minimal @happy @put_rule
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "eventbridge" "rule" did not already exist
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Then the "eventbridge" "rule" will be "ENABLED" and will trigger an "step functions" "execution" when matching events are published
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @guard @negative @put_rule
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events fails when the "eventbridge" "bus" did not exist
    Given the "eventbridge" "bus" did not exist
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Then the operation is rejected

  @guard @negative @put_rule @lifecycle
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events fails when the "eventbridge" "bus" was not "ACTIVE"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was not "ACTIVE"
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Then the operation is rejected

  @guard @negative @put_rule
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events fails when the "step functions" "state machine" did not exist
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And the "step functions" "state machine" did not exist
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Then the operation is rejected

  @guard @negative @put_rule @lifecycle
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events fails when the "step functions" "state machine" was not "ACTIVE"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And the "step functions" "state machine" existed
    And the "step functions" "state machine" was not "ACTIVE"
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Then the operation is rejected

  @guard @negative @put_rule
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events fails when the "eventbridge" "rule" already existed
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "eventbridge" "rule" already existed
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Then the operation is rejected
