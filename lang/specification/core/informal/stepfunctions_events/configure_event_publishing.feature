@stepfunctionsevents @generated
Feature: StepfunctionsEvents - The "Step Functions" "State Machine" Is Configured To Publish Execution Events To The "Eventbridge" "Bus"

  # Generated from FizzBee spec: stepfunctions_events.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, DeliveredEventReferencesExistingExecution

  Background:
    Given the system is initialized

  @minimal @happy @configure_event_publishing
  Scenario: the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the "step functions" "state machine" has no "eventbridge" "bus" configured
    And the "eventbridge" "bus" existed and was "ACTIVE"
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    Then the "step functions" "state machine" will send execution state change "eventbridge" "events" to the "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @guard @negative @configure_event_publishing @lifecycle
  Scenario: the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" fails when the "step functions" "state machine" did not exist or was "ACTIVE"
    Given the "step functions" "state machine" did not exist or was "ACTIVE"
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    Then the operation is rejected

  @guard @negative @configure_event_publishing
  Scenario: the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" fails when the "step functions" "state machine" already has an "eventbridge" "bus" configured
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the "step functions" "state machine" already has an "eventbridge" "bus" configured
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    Then the operation is rejected

  @guard @negative @configure_event_publishing @lifecycle
  Scenario: the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" fails when the "eventbridge" "bus" did not exist or was "ACTIVE"
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the "step functions" "state machine" has no "eventbridge" "bus" configured
    And the "eventbridge" "bus" did not exist or was "ACTIVE"
    When the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"
    Then the operation is rejected
