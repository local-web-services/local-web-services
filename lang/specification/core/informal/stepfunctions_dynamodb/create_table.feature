@stepfunctionsdynamodb @generated
Feature: StepfunctionsDynamodb - A "Dynamodb" "Table" Is Created

  # Generated from FizzBee spec: stepfunctions_dynamodb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ItemRequiresActiveTable

  Background:
    Given the system is initialized

  @minimal @happy @create_table
  Scenario: a "dynamodb" "table" is created
    Given the "dynamodb" "table" did not already exist
    When a "dynamodb" "table" is created
    Then the "dynamodb" "table" will be "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @guard @negative @create_table
  Scenario: a "dynamodb" "table" is created fails when the "dynamodb" "table" already existed
    Given the "dynamodb" "table" already existed
    When a "dynamodb" "table" is created
    Then the operation is rejected
