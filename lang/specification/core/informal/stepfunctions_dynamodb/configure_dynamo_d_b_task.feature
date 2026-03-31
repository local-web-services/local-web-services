@stepfunctionsdynamodb @generated
Feature: StepfunctionsDynamodb - A Dynamodb Putitem Task Is Configured On The State Machine

  # Generated from FizzBee spec: stepfunctions_dynamodb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ItemRequiresActiveTable

  Background:
    Given the system is initialized

  @minimal @happy @configure_dynamo_d_b_task
  Scenario: a DynamoDB PutItem task is configured on the state machine
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the state machine had no DynamoDB task configured
    And the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    When a DynamoDB PutItem task is configured on the state machine
    Then the state machine will write an item to the "dynamodb" "table" when it reaches the task state
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @guard @negative @configure_dynamo_d_b_task
  Scenario: a DynamoDB PutItem task is configured on the state machine fails when the "step functions" "state machine" did not exist
    Given the "step functions" "state machine" did not exist
    When a DynamoDB PutItem task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_dynamo_d_b_task @lifecycle
  Scenario: a DynamoDB PutItem task is configured on the state machine fails when the "step functions" "state machine" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was not "ACTIVE"
    When a DynamoDB PutItem task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_dynamo_d_b_task
  Scenario: a DynamoDB PutItem task is configured on the state machine fails when the state machine already has a DynamoDB task configured
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the state machine already has a DynamoDB task configured
    When a DynamoDB PutItem task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_dynamo_d_b_task
  Scenario: a DynamoDB PutItem task is configured on the state machine fails when the "dynamodb" "table" did not exist
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the state machine had no DynamoDB task configured
    And the "dynamodb" "table" did not exist
    When a DynamoDB PutItem task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_dynamo_d_b_task @lifecycle
  Scenario: a DynamoDB PutItem task is configured on the state machine fails when the "dynamodb" "table" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the state machine had no DynamoDB task configured
    And the "dynamodb" "table" existed
    And the "dynamodb" "table" was not "ACTIVE"
    When a DynamoDB PutItem task is configured on the state machine
    Then the operation is rejected
