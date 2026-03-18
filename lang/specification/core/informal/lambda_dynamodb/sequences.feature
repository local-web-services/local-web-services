@lambdadynamodb @generated
Feature: LambdaDynamodb - Action Sequences

  # Generated from FizzBee spec: lambda_dynamodb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ItemRequiresActiveTable

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a DynamoDB table is created
    Given fid not in func_status
    When a Lambda function is deployed
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes an item to the DynamoDB table during invocation
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a Lambda function is deployed
    Given tid not in table_status
    When a DynamoDB table is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda function is invoked
    Given tid not in table_status
    When a DynamoDB table is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda function writes an item to the DynamoDB table during invocation
    Given tid not in table_status
    When a DynamoDB table is created
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda invocation completes successfully
    Given tid not in table_status
    When a DynamoDB table is created
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda invocation fails
    Given tid not in table_status
    When a DynamoDB table is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a DynamoDB table is created
    Given fid in func_status
    When the Lambda function is invoked
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes an item to the DynamoDB table during invocation
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then a DynamoDB table is created
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a DynamoDB table is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function writes an item to the DynamoDB table during invocation
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a DynamoDB table is created
    Given iid in inv_status
    When the Lambda invocation fails
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function writes an item to the DynamoDB table during invocation
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a DynamoDB table is created then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When a DynamoDB table is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a DynamoDB table is created then the Lambda function writes an item to the DynamoDB table during invocation
    Given fid not in func_status
    When a Lambda function is deployed
    When a DynamoDB table is created
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a DynamoDB table is created then the Lambda invocation completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When a DynamoDB table is created
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a DynamoDB table is created then the Lambda invocation fails
    Given fid not in func_status
    When a Lambda function is deployed
    When a DynamoDB table is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then a DynamoDB table is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function writes an item to the DynamoDB table during invocation
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda invocation completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda invocation fails
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes an item to the DynamoDB table during invocation then a DynamoDB table is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function writes an item to the DynamoDB table during invocation
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes an item to the DynamoDB table during invocation then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation fails
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully then a DynamoDB table is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully then the Lambda function writes an item to the DynamoDB table during invocation
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully then the Lambda invocation fails
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails then a DynamoDB table is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails then the Lambda function writes an item to the DynamoDB table during invocation
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails then the Lambda invocation completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a Lambda function is deployed then the Lambda function is invoked
    Given tid not in table_status
    When a DynamoDB table is created
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a Lambda function is deployed then the Lambda function writes an item to the DynamoDB table during invocation
    Given tid not in table_status
    When a DynamoDB table is created
    When a Lambda function is deployed
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a Lambda function is deployed then the Lambda invocation completes successfully
    Given tid not in table_status
    When a DynamoDB table is created
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a Lambda function is deployed then the Lambda invocation fails
    Given tid not in table_status
    When a DynamoDB table is created
    When a Lambda function is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda function is invoked then a Lambda function is deployed
    Given tid not in table_status
    When a DynamoDB table is created
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda function is invoked then the Lambda function writes an item to the DynamoDB table during invocation
    Given tid not in table_status
    When a DynamoDB table is created
    When the Lambda function is invoked
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda function is invoked then the Lambda invocation completes successfully
    Given tid not in table_status
    When a DynamoDB table is created
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda function is invoked then the Lambda invocation fails
    Given tid not in table_status
    When a DynamoDB table is created
    When the Lambda function is invoked
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda function writes an item to the DynamoDB table during invocation then a Lambda function is deployed
    Given tid not in table_status
    When a DynamoDB table is created
    When the Lambda function writes an item to the DynamoDB table during invocation
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda function writes an item to the DynamoDB table during invocation then the Lambda function is invoked
    Given tid not in table_status
    When a DynamoDB table is created
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation completes successfully
    Given tid not in table_status
    When a DynamoDB table is created
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation fails
    Given tid not in table_status
    When a DynamoDB table is created
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda invocation completes successfully then a Lambda function is deployed
    Given tid not in table_status
    When a DynamoDB table is created
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda invocation completes successfully then the Lambda function is invoked
    Given tid not in table_status
    When a DynamoDB table is created
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda invocation completes successfully then the Lambda function writes an item to the DynamoDB table during invocation
    Given tid not in table_status
    When a DynamoDB table is created
    When the Lambda invocation completes successfully
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda invocation completes successfully then the Lambda invocation fails
    Given tid not in table_status
    When a DynamoDB table is created
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda invocation fails then a Lambda function is deployed
    Given tid not in table_status
    When a DynamoDB table is created
    When the Lambda invocation fails
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda invocation fails then the Lambda function is invoked
    Given tid not in table_status
    When a DynamoDB table is created
    When the Lambda invocation fails
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda invocation fails then the Lambda function writes an item to the DynamoDB table during invocation
    Given tid not in table_status
    When a DynamoDB table is created
    When the Lambda invocation fails
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda invocation fails then the Lambda invocation completes successfully
    Given tid not in table_status
    When a DynamoDB table is created
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then a DynamoDB table is created
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function writes an item to the DynamoDB table during invocation
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda invocation fails
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a DynamoDB table is created then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a DynamoDB table is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a DynamoDB table is created then the Lambda function writes an item to the DynamoDB table during invocation
    Given fid in func_status
    When the Lambda function is invoked
    When a DynamoDB table is created
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a DynamoDB table is created then the Lambda invocation completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When a DynamoDB table is created
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a DynamoDB table is created then the Lambda invocation fails
    Given fid in func_status
    When the Lambda function is invoked
    When a DynamoDB table is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes an item to the DynamoDB table during invocation then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function writes an item to the DynamoDB table during invocation
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes an item to the DynamoDB table during invocation then a DynamoDB table is created
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function writes an item to the DynamoDB table during invocation
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation fails
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully then a DynamoDB table is created
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully then the Lambda function writes an item to the DynamoDB table during invocation
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully then the Lambda invocation fails
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation fails
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails then a DynamoDB table is created
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation fails
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails then the Lambda function writes an item to the DynamoDB table during invocation
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation fails
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails then the Lambda invocation completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then a Lambda function is deployed then a DynamoDB table is created
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When a Lambda function is deployed
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then a Lambda function is deployed then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then a Lambda function is deployed then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When a Lambda function is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then a DynamoDB table is created then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When a DynamoDB table is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then a DynamoDB table is created then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When a DynamoDB table is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then a DynamoDB table is created then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When a DynamoDB table is created
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then a DynamoDB table is created then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When a DynamoDB table is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then the Lambda function is invoked then a DynamoDB table is created
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda function is invoked
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then the Lambda function is invoked then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then the Lambda function is invoked then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda function is invoked
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation completes successfully then a DynamoDB table is created
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda invocation completes successfully
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation completes successfully then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation completes successfully then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda invocation fails
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation fails then a DynamoDB table is created
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda invocation fails
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation fails then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda invocation fails
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed then a DynamoDB table is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed then the Lambda function writes an item to the DynamoDB table during invocation
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a DynamoDB table is created then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a DynamoDB table is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a DynamoDB table is created then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a DynamoDB table is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a DynamoDB table is created then the Lambda function writes an item to the DynamoDB table during invocation
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a DynamoDB table is created
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a DynamoDB table is created then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a DynamoDB table is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked then a DynamoDB table is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked then the Lambda function writes an item to the DynamoDB table during invocation
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function writes an item to the DynamoDB table during invocation then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function writes an item to the DynamoDB table during invocation
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function writes an item to the DynamoDB table during invocation then a DynamoDB table is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function writes an item to the DynamoDB table during invocation
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function writes an item to the DynamoDB table during invocation then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then a DynamoDB table is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then the Lambda function writes an item to the DynamoDB table during invocation
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed then a DynamoDB table is created
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function is deployed
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed then the Lambda function writes an item to the DynamoDB table during invocation
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function is deployed
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a DynamoDB table is created then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When a DynamoDB table is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a DynamoDB table is created then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation fails
    When a DynamoDB table is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a DynamoDB table is created then the Lambda function writes an item to the DynamoDB table during invocation
    Given iid in inv_status
    When the Lambda invocation fails
    When a DynamoDB table is created
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a DynamoDB table is created then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When a DynamoDB table is created
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked then a DynamoDB table is created
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function is invoked
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked then the Lambda function writes an item to the DynamoDB table during invocation
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function is invoked
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function writes an item to the DynamoDB table during invocation then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function writes an item to the DynamoDB table during invocation
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function writes an item to the DynamoDB table during invocation then a DynamoDB table is created
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function writes an item to the DynamoDB table during invocation
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function writes an item to the DynamoDB table during invocation then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function writes an item to the DynamoDB table during invocation
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then a DynamoDB table is created
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    When a DynamoDB table is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then the Lambda function writes an item to the DynamoDB table during invocation
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    When the Lambda function writes an item to the DynamoDB table during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table
