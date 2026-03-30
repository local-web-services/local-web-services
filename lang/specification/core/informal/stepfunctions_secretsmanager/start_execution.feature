@stepfunctionssecretsmanager @generated
Feature: StepfunctionsSecretsmanager - An Execution Of The State Machine Is Started

  # Generated from FizzBee spec: stepfunctions_secretsmanager.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadASecret

  Background:
    Given the system is initialized

  @minimal @happy @start_execution
  Scenario: an execution of the state machine is started
    Given the state machine exists
    And the state machine is "ACTIVE"
    And an execution slot is available
    When an execution of the state machine is started
    Then the execution is "RUNNING"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @guard @negative @start_execution
  Scenario: an execution of the state machine is started fails when the state machine does not exist
    Given the state machine does not exist
    When an execution of the state machine is started
    Then the operation is rejected

  @guard @negative @start_execution @lifecycle
  Scenario: an execution of the state machine is started fails when the state machine is not "ACTIVE"
    Given the state machine exists
    And the state machine is not "ACTIVE"
    When an execution of the state machine is started
    Then the operation is rejected

  @guard @negative @internal @start_execution @capacity
  Scenario: an execution of the state machine is started fails when no execution slot is available
    Given the state machine exists
    And the state machine is "ACTIVE"
    And no execution slot is available
    When an execution of the state machine is started
    Then the operation is rejected
