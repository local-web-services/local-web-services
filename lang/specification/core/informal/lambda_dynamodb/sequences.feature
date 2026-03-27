@lambdadynamodb @generated
Feature: LambdaDynamodb - Action Sequences

  # Generated from FizzBee spec: lambda_dynamodb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ItemRequiresActiveTable

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a DynamoDB table is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a DynamoDB table is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes an item to the DynamoDB table during invocation
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function writes an item to the DynamoDB table during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a Lambda function is deployed
    Given tid not in table_status
    Given a DynamoDB table has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda function is invoked
    Given tid not in table_status
    Given a DynamoDB table has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda function writes an item to the DynamoDB table during invocation
    Given tid not in table_status
    Given a DynamoDB table has been created
    When the Lambda function writes an item to the DynamoDB table during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda invocation completes successfully
    Given tid not in table_status
    Given a DynamoDB table has been created
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda invocation fails
    Given tid not in table_status
    Given a DynamoDB table has been created
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a DynamoDB table is created
    Given fid in func_status
    Given the Lambda function has been invoked
    When a DynamoDB table is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes an item to the DynamoDB table during invocation
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function writes an item to the DynamoDB table during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has written an item to the DynamoDB table during invocation
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then a DynamoDB table is created
    Given iid in inv_status
    Given the Lambda function has written an item to the DynamoDB table during invocation
    When a DynamoDB table is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has written an item to the DynamoDB table during invocation
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda function has written an item to the DynamoDB table during invocation
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda function has written an item to the DynamoDB table during invocation
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a DynamoDB table is created
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When a DynamoDB table is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function writes an item to the DynamoDB table during invocation
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When the Lambda function writes an item to the DynamoDB table during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has failed
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a DynamoDB table is created
    Given iid in inv_status
    Given the Lambda invocation has failed
    When a DynamoDB table is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda invocation has failed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function writes an item to the DynamoDB table during invocation
    Given iid in inv_status
    Given the Lambda invocation has failed
    When the Lambda function writes an item to the DynamoDB table during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda invocation has failed
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a DynamoDB table is created then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a DynamoDB table has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function writes an item to the DynamoDB table during invocation
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has been invoked
    When the Lambda function writes an item to the DynamoDB table during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has written an item to the DynamoDB table during invocation
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully then the Lambda invocation fails
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda invocation has completed successfully
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails then a DynamoDB table is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda invocation has failed
    When a DynamoDB table is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a Lambda function is deployed then the Lambda function writes an item to the DynamoDB table during invocation
    Given tid not in table_status
    Given a DynamoDB table has been created
    Given a Lambda function has been deployed
    When the Lambda function writes an item to the DynamoDB table during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda function is invoked then the Lambda invocation completes successfully
    Given tid not in table_status
    Given a DynamoDB table has been created
    Given the Lambda function has been invoked
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation fails
    Given tid not in table_status
    Given a DynamoDB table has been created
    Given the Lambda function has written an item to the DynamoDB table during invocation
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda invocation completes successfully then a Lambda function is deployed
    Given tid not in table_status
    Given a DynamoDB table has been created
    Given the Lambda invocation has completed successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then the Lambda invocation fails then the Lambda function is invoked
    Given tid not in table_status
    Given a DynamoDB table has been created
    Given the Lambda invocation has failed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Lambda function has been deployed
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a DynamoDB table is created then the Lambda invocation fails
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a DynamoDB table has been created
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes an item to the DynamoDB table during invocation then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has written an item to the DynamoDB table during invocation
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully then a DynamoDB table is created
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda invocation has completed successfully
    When a DynamoDB table is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails then the Lambda function writes an item to the DynamoDB table during invocation
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda invocation has failed
    When the Lambda function writes an item to the DynamoDB table during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then a Lambda function is deployed then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda function has written an item to the DynamoDB table during invocation
    Given a Lambda function has been deployed
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then a DynamoDB table is created then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has written an item to the DynamoDB table during invocation
    Given a DynamoDB table has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then the Lambda function is invoked then a DynamoDB table is created
    Given iid in inv_status
    Given the Lambda function has written an item to the DynamoDB table during invocation
    Given the Lambda function has been invoked
    When a DynamoDB table is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation completes successfully then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has written an item to the DynamoDB table during invocation
    Given the Lambda invocation has completed successfully
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda function has written an item to the DynamoDB table during invocation
    Given the Lambda invocation has failed
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed then a DynamoDB table is created
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given a Lambda function has been deployed
    When a DynamoDB table is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a DynamoDB table is created then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given a DynamoDB table has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked then the Lambda function writes an item to the DynamoDB table during invocation
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given the Lambda function has been invoked
    When the Lambda function writes an item to the DynamoDB table during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function writes an item to the DynamoDB table during invocation then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given the Lambda function has written an item to the DynamoDB table during invocation
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given the Lambda invocation has failed
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a DynamoDB table is created then the Lambda function writes an item to the DynamoDB table during invocation
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given a DynamoDB table has been created
    When the Lambda function writes an item to the DynamoDB table during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given the Lambda function has been invoked
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function writes an item to the DynamoDB table during invocation then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given the Lambda function has written an item to the DynamoDB table during invocation
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then a DynamoDB table is created
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given the Lambda invocation has completed successfully
    When a DynamoDB table is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table
