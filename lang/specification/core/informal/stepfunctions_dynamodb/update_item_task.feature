@stepfunctionsdynamodb @generated
Feature: StepfunctionsDynamodb - A Running "Step Functions" "Execution" Updates An Item In The "Dynamodb" "Table" And Succeeds

  # Safety invariants: ExecutionRequiresActiveStateMachine, ItemRequiresActiveTable

  Background:
    Given the system is initialized

  @minimal @happy @update_item_task
  Scenario: a running "step functions" "execution" updates an item in the "dynamodb" "table" and succeeds
    Given a "step functions" "execution" was "RUNNING"
    And the target "dynamodb" "table" was "ACTIVE"
    And an "item" "slot" was "available"
    When a running "step functions" "execution" updates an item in the "dynamodb" "table" and succeeds
    Then the item will be updated in the "dynamodb" "table" and the "step functions" "execution" will be "SUCCEEDED"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @guard @negative @update_item_task
  Scenario: a running "step functions" "execution" updates an item in the "dynamodb" "table" and succeeds fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" updates an item in the "dynamodb" "table" and succeeds
    Then the operation is rejected

  @guard @negative @update_item_task @lifecycle
  Scenario: a running "step functions" "execution" updates an item in the "dynamodb" "table" and succeeds fails when the target "dynamodb" "table" was not "ACTIVE"
    Given a "step functions" "execution" was "RUNNING"
    And the target "dynamodb" "table" was not "ACTIVE"
    When a running "step functions" "execution" updates an item in the "dynamodb" "table" and succeeds
    Then the operation is rejected

  @guard @negative @update_item_task @capacity
  Scenario: a running "step functions" "execution" updates an item in the "dynamodb" "table" and succeeds fails when no "dynamodb" "item" "slot" was "available"
    Given a "step functions" "execution" was "RUNNING"
    And the target "dynamodb" "table" was "ACTIVE"
    And no "dynamodb" "item" "slot" was "available"
    When a running "step functions" "execution" updates an item in the "dynamodb" "table" and succeeds
    Then the operation is rejected
