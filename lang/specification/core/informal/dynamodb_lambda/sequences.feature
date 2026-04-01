@dynamodblambda @generated
Feature: DynamodbLambda - Action Sequences

  # Generated from FizzBee spec: dynamodb_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, ESMReferencesActiveStream

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "dynamodb" "table" is created with streaming enabled then a "lambda" "function" is deployed
    Given tid not in table_status
    When a "dynamodb" "table" is created with streaming enabled
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "dynamodb" "table" is created with streaming enabled then a "lambda" "event source mapping" is created to process the DynamoDB Stream
    Given tid not in table_status
    When a "dynamodb" "table" is created with streaming enabled
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "dynamodb" "table" is created with streaming enabled then a change to the "dynamodb" "table" produces a stream record
    Given tid not in table_status
    When a "dynamodb" "table" is created with streaming enabled
    When a change to the "dynamodb" "table" produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "dynamodb" "table" is created with streaming enabled then the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Given tid not in table_status
    When a "dynamodb" "table" is created with streaming enabled
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "dynamodb" "table" is created with streaming enabled then the Lambda invocation processes the stream record successfully
    Given tid not in table_status
    When a "dynamodb" "table" is created with streaming enabled
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "dynamodb" "table" is created with streaming enabled then the Lambda invocation fails and the stream record is retried
    Given tid not in table_status
    When a "dynamodb" "table" is created with streaming enabled
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "function" is deployed then a "dynamodb" "table" is created with streaming enabled
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "dynamodb" "table" is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "function" is deployed then a "lambda" "event source mapping" is created to process the DynamoDB Stream
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "function" is deployed then a change to the "dynamodb" "table" produces a stream record
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a change to the "dynamodb" "table" produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "function" is deployed then the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda invocation processes the stream record successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda invocation fails and the stream record is retried
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "event source mapping" is created to process the DynamoDB Stream then a "dynamodb" "table" is created with streaming enabled
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    When a "dynamodb" "table" is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "event source mapping" is created to process the DynamoDB Stream then a "lambda" "function" is deployed
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "event source mapping" is created to process the DynamoDB Stream then a change to the "dynamodb" "table" produces a stream record
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    When a change to the "dynamodb" "table" produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "event source mapping" is created to process the DynamoDB Stream then the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "event source mapping" is created to process the DynamoDB Stream then the Lambda invocation processes the stream record successfully
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "event source mapping" is created to process the DynamoDB Stream then the Lambda invocation fails and the stream record is retried
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the "dynamodb" "table" produces a stream record then a "dynamodb" "table" is created with streaming enabled
    Given tid in table_status
    When a change to the "dynamodb" "table" produces a stream record
    When a "dynamodb" "table" is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the "dynamodb" "table" produces a stream record then a "lambda" "function" is deployed
    Given tid in table_status
    When a change to the "dynamodb" "table" produces a stream record
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the "dynamodb" "table" produces a stream record then a "lambda" "event source mapping" is created to process the DynamoDB Stream
    Given tid in table_status
    When a change to the "dynamodb" "table" produces a stream record
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the "dynamodb" "table" produces a stream record then the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Given tid in table_status
    When a change to the "dynamodb" "table" produces a stream record
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the "dynamodb" "table" produces a stream record then the Lambda invocation processes the stream record successfully
    Given tid in table_status
    When a change to the "dynamodb" "table" produces a stream record
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the "dynamodb" "table" produces a stream record then the Lambda invocation fails and the stream record is retried
    Given tid in table_status
    When a change to the "dynamodb" "table" produces a stream record
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record then a "dynamodb" "table" is created with streaming enabled
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    When a "dynamodb" "table" is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record then a "lambda" "function" is deployed
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record then a "lambda" "event source mapping" is created to process the DynamoDB Stream
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record then a change to the "dynamodb" "table" produces a stream record
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    When a change to the "dynamodb" "table" produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record then the Lambda invocation processes the stream record successfully
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record then the Lambda invocation fails and the stream record is retried
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a "dynamodb" "table" is created with streaming enabled
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a "dynamodb" "table" is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a "lambda" "event source mapping" is created to process the DynamoDB Stream
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a change to the "dynamodb" "table" produces a stream record
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a change to the "dynamodb" "table" produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then the Lambda invocation fails and the stream record is retried
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a "dynamodb" "table" is created with streaming enabled
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a "dynamodb" "table" is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a "lambda" "event source mapping" is created to process the DynamoDB Stream
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a change to the "dynamodb" "table" produces a stream record
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a change to the "dynamodb" "table" produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then the Lambda invocation processes the stream record successfully
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "dynamodb" "table" is created with streaming enabled then a "lambda" "function" is deployed then a "lambda" "event source mapping" is created to process the DynamoDB Stream
    Given tid not in table_status
    When a "dynamodb" "table" is created with streaming enabled
    When a "lambda" "function" is deployed
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "dynamodb" "table" is created with streaming enabled then a "lambda" "event source mapping" is created to process the DynamoDB Stream then a change to the "dynamodb" "table" produces a stream record
    Given tid not in table_status
    When a "dynamodb" "table" is created with streaming enabled
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    When a change to the "dynamodb" "table" produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "dynamodb" "table" is created with streaming enabled then a change to the "dynamodb" "table" produces a stream record then the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Given tid not in table_status
    When a "dynamodb" "table" is created with streaming enabled
    When a change to the "dynamodb" "table" produces a stream record
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "dynamodb" "table" is created with streaming enabled then the event source mapping polls the stream and invokes the "lambda" "function" with the record then the Lambda invocation processes the stream record successfully
    Given tid not in table_status
    When a "dynamodb" "table" is created with streaming enabled
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "dynamodb" "table" is created with streaming enabled then the Lambda invocation processes the stream record successfully then the Lambda invocation fails and the stream record is retried
    Given tid not in table_status
    When a "dynamodb" "table" is created with streaming enabled
    When the Lambda invocation processes the stream record successfully
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "dynamodb" "table" is created with streaming enabled then the Lambda invocation fails and the stream record is retried then a "lambda" "function" is deployed
    Given tid not in table_status
    When a "dynamodb" "table" is created with streaming enabled
    When the Lambda invocation fails and the stream record is retried
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "function" is deployed then a "dynamodb" "table" is created with streaming enabled then a change to the "dynamodb" "table" produces a stream record
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "dynamodb" "table" is created with streaming enabled
    When a change to the "dynamodb" "table" produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "function" is deployed then a "lambda" "event source mapping" is created to process the DynamoDB Stream then the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "function" is deployed then a change to the "dynamodb" "table" produces a stream record then the Lambda invocation processes the stream record successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a change to the "dynamodb" "table" produces a stream record
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "function" is deployed then the event source mapping polls the stream and invokes the "lambda" "function" with the record then the Lambda invocation fails and the stream record is retried
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda invocation processes the stream record successfully then a "dynamodb" "table" is created with streaming enabled
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda invocation processes the stream record successfully
    When a "dynamodb" "table" is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda invocation fails and the stream record is retried then a "lambda" "event source mapping" is created to process the DynamoDB Stream
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda invocation fails and the stream record is retried
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "event source mapping" is created to process the DynamoDB Stream then a "dynamodb" "table" is created with streaming enabled then the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    When a "dynamodb" "table" is created with streaming enabled
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "event source mapping" is created to process the DynamoDB Stream then a "lambda" "function" is deployed then the Lambda invocation processes the stream record successfully
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    When a "lambda" "function" is deployed
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "event source mapping" is created to process the DynamoDB Stream then a change to the "dynamodb" "table" produces a stream record then the Lambda invocation fails and the stream record is retried
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    When a change to the "dynamodb" "table" produces a stream record
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "event source mapping" is created to process the DynamoDB Stream then the event source mapping polls the stream and invokes the "lambda" "function" with the record then a "dynamodb" "table" is created with streaming enabled
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    When a "dynamodb" "table" is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "event source mapping" is created to process the DynamoDB Stream then the Lambda invocation processes the stream record successfully then a "lambda" "function" is deployed
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    When the Lambda invocation processes the stream record successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a "lambda" "event source mapping" is created to process the DynamoDB Stream then the Lambda invocation fails and the stream record is retried then a change to the "dynamodb" "table" produces a stream record
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    When the Lambda invocation fails and the stream record is retried
    When a change to the "dynamodb" "table" produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the "dynamodb" "table" produces a stream record then a "dynamodb" "table" is created with streaming enabled then the Lambda invocation processes the stream record successfully
    Given tid in table_status
    When a change to the "dynamodb" "table" produces a stream record
    When a "dynamodb" "table" is created with streaming enabled
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the "dynamodb" "table" produces a stream record then a "lambda" "function" is deployed then the Lambda invocation fails and the stream record is retried
    Given tid in table_status
    When a change to the "dynamodb" "table" produces a stream record
    When a "lambda" "function" is deployed
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the "dynamodb" "table" produces a stream record then a "lambda" "event source mapping" is created to process the DynamoDB Stream then a "dynamodb" "table" is created with streaming enabled
    Given tid in table_status
    When a change to the "dynamodb" "table" produces a stream record
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    When a "dynamodb" "table" is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the "dynamodb" "table" produces a stream record then the event source mapping polls the stream and invokes the "lambda" "function" with the record then a "lambda" "function" is deployed
    Given tid in table_status
    When a change to the "dynamodb" "table" produces a stream record
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the "dynamodb" "table" produces a stream record then the Lambda invocation processes the stream record successfully then a "lambda" "event source mapping" is created to process the DynamoDB Stream
    Given tid in table_status
    When a change to the "dynamodb" "table" produces a stream record
    When the Lambda invocation processes the stream record successfully
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the "dynamodb" "table" produces a stream record then the Lambda invocation fails and the stream record is retried then the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Given tid in table_status
    When a change to the "dynamodb" "table" produces a stream record
    When the Lambda invocation fails and the stream record is retried
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record then a "dynamodb" "table" is created with streaming enabled then the Lambda invocation fails and the stream record is retried
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    When a "dynamodb" "table" is created with streaming enabled
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record then a "lambda" "function" is deployed then a "dynamodb" "table" is created with streaming enabled
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    When a "lambda" "function" is deployed
    When a "dynamodb" "table" is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record then a "lambda" "event source mapping" is created to process the DynamoDB Stream then a "lambda" "function" is deployed
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record then a change to the "dynamodb" "table" produces a stream record then a "lambda" "event source mapping" is created to process the DynamoDB Stream
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    When a change to the "dynamodb" "table" produces a stream record
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record then the Lambda invocation processes the stream record successfully then a change to the "dynamodb" "table" produces a stream record
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    When the Lambda invocation processes the stream record successfully
    When a change to the "dynamodb" "table" produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record then the Lambda invocation fails and the stream record is retried then the Lambda invocation processes the stream record successfully
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    When the Lambda invocation fails and the stream record is retried
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a "dynamodb" "table" is created with streaming enabled then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a "dynamodb" "table" is created with streaming enabled
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a "lambda" "function" is deployed then a "lambda" "event source mapping" is created to process the DynamoDB Stream
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a "lambda" "function" is deployed
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a "lambda" "event source mapping" is created to process the DynamoDB Stream then a change to the "dynamodb" "table" produces a stream record
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    When a change to the "dynamodb" "table" produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a change to the "dynamodb" "table" produces a stream record then the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a change to the "dynamodb" "table" produces a stream record
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then the event source mapping polls the stream and invokes the "lambda" "function" with the record then the Lambda invocation fails and the stream record is retried
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then the Lambda invocation fails and the stream record is retried then a "dynamodb" "table" is created with streaming enabled
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When the Lambda invocation fails and the stream record is retried
    When a "dynamodb" "table" is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a "dynamodb" "table" is created with streaming enabled then a "lambda" "event source mapping" is created to process the DynamoDB Stream
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a "dynamodb" "table" is created with streaming enabled
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a "lambda" "function" is deployed then a change to the "dynamodb" "table" produces a stream record
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a "lambda" "function" is deployed
    When a change to the "dynamodb" "table" produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a "lambda" "event source mapping" is created to process the DynamoDB Stream then the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a change to the "dynamodb" "table" produces a stream record then the Lambda invocation processes the stream record successfully
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a change to the "dynamodb" "table" produces a stream record
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then the event source mapping polls the stream and invokes the "lambda" "function" with the record then a "dynamodb" "table" is created with streaming enabled
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    When a "dynamodb" "table" is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then the Lambda invocation processes the stream record successfully then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When the Lambda invocation processes the stream record successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled
