@stepfunctionsdynamodb @generated
Feature: StepfunctionsDynamodb - A Running Execution Attempts To Get An Item That Does Not Exist And The Execution Fails

  # Generated from FizzBee spec: stepfunctions_dynamodb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ItemRequiresActiveTable

  Background:
    Given the system is initialized

  @minimal @happy @get_item_not_found_task
  Scenario: a running execution attempts to get an item that does not exist and the execution fails
    Given an execution is "RUNNING"
    And no item "EXISTS" in the target table
    When a running execution attempts to get an item that does not exist and the execution fails
    Then the execution is "FAILED" because the item was not found
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @standard @negative @get_item_not_found_task
  Scenario: a running execution attempts to get an item that does not exist and the execution fails fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution attempts to get an item that does not exist and the execution fails
    Then the operation is rejected

  @standard @negative @get_item_not_found_task
  Scenario: a running execution attempts to get an item that does not exist and the execution fails fails when an item "EXISTS" in the target table
    Given an execution is "RUNNING"
    And an item "EXISTS" in the target table
    When a running execution attempts to get an item that does not exist and the execution fails
    Then the operation is rejected
