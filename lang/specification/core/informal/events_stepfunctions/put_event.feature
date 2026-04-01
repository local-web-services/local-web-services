@eventsstepfunctions @generated
Feature: EventsStepfunctions - An "Eventbridge" "Event" Is Published To The "Eventbridge" "Bus" And Triggers A New "Step Functions" "Execution"

  # Generated from FizzBee spec: events_stepfunctions.fizz
  # Safety invariants: RuleReferencesActiveBus, ExecutionRequiresActiveStateMachine, ExecutionRequiresEnabledRule

  Background:
    Given the system is initialized

  @minimal @happy @put_event
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And an "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "step functions" "state machine"
    And the target "step functions" "state machine" was "ACTIVE"
    And an "step functions" "execution" slot is available
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    Then the "step functions" "execution" will be "RUNNING"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @guard @negative @put_event
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution" fails when the "eventbridge" "bus" did not exist
    Given the "eventbridge" "bus" did not exist
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    Then the operation is rejected

  @guard @negative @put_event @lifecycle
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution" fails when the "eventbridge" "bus" was not "ACTIVE"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was not "ACTIVE"
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    Then the operation is rejected

  @guard @negative @put_event @lifecycle
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution" fails when no "ENABLED" rule existed on the bus targeting a state machine
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And no "ENABLED" rule existed on the bus targeting a state machine
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    Then the operation is rejected

  @guard @negative @put_event @lifecycle
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution" fails when the target "step functions" "state machine" was not "ACTIVE"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And an "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "step functions" "state machine"
    And the target "step functions" "state machine" was not "ACTIVE"
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    Then the operation is rejected

  @guard @negative @put_event @capacity
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution" fails when no "step functions" "execution" "slot" was "available"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And an "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "step functions" "state machine"
    And the target "step functions" "state machine" was "ACTIVE"
    And no "step functions" "execution" "slot" was "available"
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    Then the operation is rejected
