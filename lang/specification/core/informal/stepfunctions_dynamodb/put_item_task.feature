@stepfunctionsdynamodb @generated
Feature: StepfunctionsDynamodb - A Running Execution Writes An Item To The Dynamodb Table And Succeeds

  # Generated from FizzBee spec: stepfunctions_dynamodb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ItemRequiresActiveTable

  Background:
    Given the system is initialized

  @minimal @happy @put_item_task
  Scenario: a running execution writes an item to the DynamoDB table and succeeds
    Given an execution is "RUNNING"
    And the target table is "ACTIVE"
    And an item slot is available
    When a running execution writes an item to the DynamoDB table and succeeds
    Then the item "EXISTS" in the table and the execution is "SUCCEEDED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @standard @negative @put_item_task
  Scenario: a running execution writes an item to the DynamoDB table and succeeds fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution writes an item to the DynamoDB table and succeeds
    Then the operation is rejected

  @standard @negative @put_item_task @lifecycle
  Scenario: a running execution writes an item to the DynamoDB table and succeeds fails when the target table is not "ACTIVE"
    Given an execution is "RUNNING"
    And the target table is not "ACTIVE"
    When a running execution writes an item to the DynamoDB table and succeeds
    Then the operation is rejected

  @standard @negative @internal @put_item_task @capacity
  Scenario: a running execution writes an item to the DynamoDB table and succeeds fails when no item slot is available
    Given an execution is "RUNNING"
    And the target table is "ACTIVE"
    And no item slot is available
    When a running execution writes an item to the DynamoDB table and succeeds
    Then the operation is rejected
