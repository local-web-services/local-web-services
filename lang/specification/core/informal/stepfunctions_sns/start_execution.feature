@stepfunctionssns @generated
Feature: StepfunctionsSns - An "Step Functions" "Execution" Of The "Step Functions" "State Machine" Is Started

  # Generated from FizzBee spec: stepfunctions_sns.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ExecutionRequiresActiveTopic

  Background:
    Given the system is initialized

  @minimal @happy @start_execution
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the state machine has a "SNS" task configured
    And an "step functions" "execution" slot is available
    When an "step functions" "execution" of the "step functions" "state machine" is started
    Then the "step functions" "execution" will be "RUNNING"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

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
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started fails when the state machine has no "SNS" task configured
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the state machine has no "SNS" task configured
    When an "step functions" "execution" of the "step functions" "state machine" is started
    Then the operation is rejected

  @guard @negative @start_execution @capacity
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started fails when no execution slot is available
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the state machine has a "SNS" task configured
    And no execution slot is available
    When an "step functions" "execution" of the "step functions" "state machine" is started
    Then the operation is rejected
