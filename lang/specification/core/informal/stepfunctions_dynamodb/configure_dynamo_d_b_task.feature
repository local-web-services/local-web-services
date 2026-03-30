@stepfunctionsdynamodb @generated
Feature: StepfunctionsDynamodb - A Dynamodb Putitem Task Is Configured On The State Machine

  # Generated from FizzBee spec: stepfunctions_dynamodb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ItemRequiresActiveTable

  Background:
    Given the system is initialized

  @minimal @happy @configure_dynamo_d_b_task
  Scenario: a DynamoDB PutItem task is configured on the state machine
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine has no DynamoDB task configured
    And the table exists
    And the table is "ACTIVE"
    When a DynamoDB PutItem task is configured on the state machine
    Then the state machine will write an item to the table when it reaches the task state
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @guard @negative @configure_dynamo_d_b_task
  Scenario: a DynamoDB PutItem task is configured on the state machine fails when the state machine does not exist
    Given the state machine does not exist
    When a DynamoDB PutItem task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_dynamo_d_b_task @lifecycle
  Scenario: a DynamoDB PutItem task is configured on the state machine fails when the state machine is not "ACTIVE"
    Given the state machine exists
    And the state machine is not "ACTIVE"
    When a DynamoDB PutItem task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_dynamo_d_b_task
  Scenario: a DynamoDB PutItem task is configured on the state machine fails when the state machine already has a DynamoDB task configured
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine already has a DynamoDB task configured
    When a DynamoDB PutItem task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_dynamo_d_b_task
  Scenario: a DynamoDB PutItem task is configured on the state machine fails when the table does not exist
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine has no DynamoDB task configured
    And the table does not exist
    When a DynamoDB PutItem task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_dynamo_d_b_task @lifecycle
  Scenario: a DynamoDB PutItem task is configured on the state machine fails when the table is not "ACTIVE"
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine has no DynamoDB task configured
    And the table exists
    And the table is not "ACTIVE"
    When a DynamoDB PutItem task is configured on the state machine
    Then the operation is rejected
