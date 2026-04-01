@lambdadynamodb @generated
Feature: LambdaDynamodb - Action Sequences

  # Generated from FizzBee spec: lambda_dynamodb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ItemRequiresActiveTable

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "lambda" "function" is deployed then a "dynamodb" "table" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "dynamodb" "table" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "table" is created then a "lambda" "function" is deployed
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "table" is created then the "lambda" "function" is invoked
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "table" is created then the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "table" is created then the "lambda" "function" invocation completes successfully
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "table" is created then the "lambda" "function" invocation fails
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" is invoked then a "dynamodb" "table" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "dynamodb" "table" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" invocation completes successfully
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" invocation fails
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" writes an item to the "dynamodb" "table" during invocation then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" writes an item to the "dynamodb" "table" during invocation then a "dynamodb" "table" is created
    Given iid in inv_status
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    When a "dynamodb" "table" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" writes an item to the "dynamodb" "table" during invocation then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" writes an item to the "dynamodb" "table" during invocation then the "lambda" "function" invocation completes successfully
    Given iid in inv_status
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" writes an item to the "dynamodb" "table" during invocation then the "lambda" "function" invocation fails
    Given iid in inv_status
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "dynamodb" "table" is created
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "dynamodb" "table" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" invocation fails
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "dynamodb" "table" is created
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "dynamodb" "table" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" invocation completes successfully
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "lambda" "function" is deployed then a "dynamodb" "table" is created then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "dynamodb" "table" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked then the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" writes an item to the "dynamodb" "table" during invocation then the "lambda" "function" invocation completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation completes successfully then the "lambda" "function" invocation fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation fails then a "dynamodb" "table" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails
    When a "dynamodb" "table" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "table" is created then a "lambda" "function" is deployed then the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When a "lambda" "function" is deployed
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "table" is created then the "lambda" "function" is invoked then the "lambda" "function" invocation completes successfully
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When the "lambda" "function" is invoked
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "table" is created then the "lambda" "function" writes an item to the "dynamodb" "table" during invocation then the "lambda" "function" invocation fails
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "table" is created then the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "table" is created then the "lambda" "function" invocation fails then the "lambda" "function" is invoked
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When the "lambda" "function" invocation fails
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed then the "lambda" "function" invocation completes successfully
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" is invoked then a "dynamodb" "table" is created then the "lambda" "function" invocation fails
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "dynamodb" "table" is created
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" writes an item to the "dynamodb" "table" during invocation then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" invocation completes successfully then a "dynamodb" "table" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" invocation completes successfully
    When a "dynamodb" "table" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" invocation fails then the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" invocation fails
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" writes an item to the "dynamodb" "table" during invocation then a "lambda" "function" is deployed then the "lambda" "function" invocation fails
    Given iid in inv_status
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" writes an item to the "dynamodb" "table" during invocation then a "dynamodb" "table" is created then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    When a "dynamodb" "table" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" writes an item to the "dynamodb" "table" during invocation then the "lambda" "function" is invoked then a "dynamodb" "table" is created
    Given iid in inv_status
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    When the "lambda" "function" is invoked
    When a "dynamodb" "table" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" writes an item to the "dynamodb" "table" during invocation then the "lambda" "function" invocation completes successfully then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" writes an item to the "dynamodb" "table" during invocation then the "lambda" "function" invocation fails then the "lambda" "function" invocation completes successfully
    Given iid in inv_status
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    When the "lambda" "function" invocation fails
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed then a "dynamodb" "table" is created
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    When a "dynamodb" "table" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "dynamodb" "table" is created then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "dynamodb" "table" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" is invoked then the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" writes an item to the "dynamodb" "table" during invocation then the "lambda" "function" invocation fails
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" invocation fails then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" invocation fails
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "dynamodb" "table" is created then the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "dynamodb" "table" is created
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" is invoked then the "lambda" "function" invocation completes successfully
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" is invoked
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" writes an item to the "dynamodb" "table" during invocation then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" invocation completes successfully then a "dynamodb" "table" is created
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" invocation completes successfully
    When a "dynamodb" "table" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"
