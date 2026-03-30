@stepfunctionsdynamodb @generated
Feature: StepfunctionsDynamodb - A Dynamodb Table Is Created

  # Generated from FizzBee spec: stepfunctions_dynamodb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ItemRequiresActiveTable

  Background:
    Given the system is initialized

  @minimal @happy @create_table
  Scenario: a DynamoDB table is created
    Given the table does not already exist
    When a DynamoDB table is created
    Then the table is "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @guard @negative @create_table
  Scenario: a DynamoDB table is created fails when the table already exists
    Given the table already exists
    When a DynamoDB table is created
    Then the operation is rejected
