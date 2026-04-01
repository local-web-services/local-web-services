@stepfunctionsdynamodb @generated
Feature: StepfunctionsDynamodb - A Running "Step Functions" "Execution" Attempts To Get An Item That Does Not Exist And The Execution Fails

  # Generated from FizzBee spec: stepfunctions_dynamodb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ItemRequiresActiveTable

  Background:
    Given the system is initialized

  @minimal @happy @get_item_not_found_task
  Scenario: a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    Given a "step functions" "execution" was "RUNNING"
    And no "dynamodb" "item" existed in the target "dynamodb" "table"
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    Then the "step functions" "execution" will be "FAILED" because the item was not found
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @guard @negative @get_item_not_found_task
  Scenario: a running "step functions" "execution" attempts to get an item that does not exist and the execution fails fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    Then the operation is rejected

  @guard @negative @get_item_not_found_task
  Scenario: a running "step functions" "execution" attempts to get an item that does not exist and the execution fails fails when a "dynamodb" "item" existed in the target "dynamodb" "table"
    Given a "step functions" "execution" was "RUNNING"
    And a "dynamodb" "item" existed in the target "dynamodb" "table"
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    Then the operation is rejected
