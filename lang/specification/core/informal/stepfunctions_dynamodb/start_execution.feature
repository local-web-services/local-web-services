@stepfunctionsdynamodb @generated
Feature: StepfunctionsDynamodb - An "Step Functions" "Execution" Of The "Step Functions" "State Machine" Is Started

  # Generated from FizzBee spec: stepfunctions_dynamodb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ItemRequiresActiveTable

  Background:
    Given the system is initialized

  @minimal @happy @start_execution
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" had a "dynamodb" task configured
    And an "step functions" "execution" slot is available
    When an "step functions" "execution" of the "step functions" "state machine" is started
    Then the "step functions" "execution" will be "RUNNING"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @guard @negative @start_execution
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started fails when the "step functions" "state machine" did not exist
    Given the "step functions" "state machine" did not exist
    When an "step functions" "execution" of the "step functions" "state machine" is started
    Then the operation is rejected

  @guard @negative @start_execution @lifecycle
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started fails when the "step functions" "state machine" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was not "ACTIVE"
    When an "step functions" "execution" of the "step functions" "state machine" is started
    Then the operation is rejected

  @guard @negative @start_execution
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started fails when the "step functions" "state machine" had no "dynamodb" task configured
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" had no "dynamodb" task configured
    When an "step functions" "execution" of the "step functions" "state machine" is started
    Then the operation is rejected

  @guard @negative @start_execution @capacity
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started fails when no "step functions" "execution" "slot" was "available"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" had a "dynamodb" task configured
    And no "step functions" "execution" "slot" was "available"
    When an "step functions" "execution" of the "step functions" "state machine" is started
    Then the operation is rejected
