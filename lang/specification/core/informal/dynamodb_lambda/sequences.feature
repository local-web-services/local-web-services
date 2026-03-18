@dynamodblambda @generated
Feature: DynamodbLambda - Action Sequences

  # Generated from FizzBee spec: dynamodb_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, ESMReferencesActiveStream

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a Lambda function is deployed
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a Lambda event source mapping is created to process the DynamoDB Stream
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a change to the DynamoDB table produces a stream record
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the event source mapping polls the stream and invokes the Lambda function with the record
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the Lambda invocation processes the stream record successfully
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the Lambda invocation fails and the stream record is retried
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a DynamoDB table is created with streaming enabled
    Given fid not in func_status
    When a Lambda function is deployed
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Lambda event source mapping is created to process the DynamoDB Stream
    Given fid not in func_status
    When a Lambda function is deployed
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a change to the DynamoDB table produces a stream record
    Given fid not in func_status
    When a Lambda function is deployed
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the event source mapping polls the stream and invokes the Lambda function with the record
    Given fid not in func_status
    When a Lambda function is deployed
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation processes the stream record successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails and the stream record is retried
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a DynamoDB table is created with streaming enabled
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a Lambda function is deployed
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a change to the DynamoDB table produces a stream record
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the event source mapping polls the stream and invokes the Lambda function with the record
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation processes the stream record successfully
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation fails and the stream record is retried
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a DynamoDB table is created with streaming enabled
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a Lambda function is deployed
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a Lambda event source mapping is created to process the DynamoDB Stream
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the event source mapping polls the stream and invokes the Lambda function with the record
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the Lambda invocation processes the stream record successfully
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the Lambda invocation fails and the stream record is retried
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a DynamoDB table is created with streaming enabled
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda function is deployed
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda event source mapping is created to process the DynamoDB Stream
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a change to the DynamoDB table produces a stream record
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation processes the stream record successfully
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation fails and the stream record is retried
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a DynamoDB table is created with streaming enabled
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a Lambda event source mapping is created to process the DynamoDB Stream
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a change to the DynamoDB table produces a stream record
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then the event source mapping polls the stream and invokes the Lambda function with the record
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then the Lambda invocation fails and the stream record is retried
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a DynamoDB table is created with streaming enabled
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a Lambda event source mapping is created to process the DynamoDB Stream
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a change to the DynamoDB table produces a stream record
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then the event source mapping polls the stream and invokes the Lambda function with the record
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then the Lambda invocation processes the stream record successfully
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a Lambda function is deployed then a Lambda event source mapping is created to process the DynamoDB Stream
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When a Lambda function is deployed
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a Lambda function is deployed then a change to the DynamoDB table produces a stream record
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When a Lambda function is deployed
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a Lambda function is deployed then the event source mapping polls the stream and invokes the Lambda function with the record
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When a Lambda function is deployed
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a Lambda function is deployed then the Lambda invocation processes the stream record successfully
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When a Lambda function is deployed
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a Lambda function is deployed then the Lambda invocation fails and the stream record is retried
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When a Lambda function is deployed
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a Lambda event source mapping is created to process the DynamoDB Stream then a Lambda function is deployed
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a Lambda event source mapping is created to process the DynamoDB Stream then a change to the DynamoDB table produces a stream record
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a Lambda event source mapping is created to process the DynamoDB Stream then the event source mapping polls the stream and invokes the Lambda function with the record
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation processes the stream record successfully
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation fails and the stream record is retried
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a change to the DynamoDB table produces a stream record then a Lambda function is deployed
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When a change to the DynamoDB table produces a stream record
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a change to the DynamoDB table produces a stream record then a Lambda event source mapping is created to process the DynamoDB Stream
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When a change to the DynamoDB table produces a stream record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a change to the DynamoDB table produces a stream record then the event source mapping polls the stream and invokes the Lambda function with the record
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When a change to the DynamoDB table produces a stream record
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a change to the DynamoDB table produces a stream record then the Lambda invocation processes the stream record successfully
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When a change to the DynamoDB table produces a stream record
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a change to the DynamoDB table produces a stream record then the Lambda invocation fails and the stream record is retried
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When a change to the DynamoDB table produces a stream record
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda function is deployed
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda event source mapping is created to process the DynamoDB Stream
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the event source mapping polls the stream and invokes the Lambda function with the record then a change to the DynamoDB table produces a stream record
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation processes the stream record successfully
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation fails and the stream record is retried
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the Lambda invocation processes the stream record successfully then a Lambda function is deployed
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When the Lambda invocation processes the stream record successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the Lambda invocation processes the stream record successfully then a Lambda event source mapping is created to process the DynamoDB Stream
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When the Lambda invocation processes the stream record successfully
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the Lambda invocation processes the stream record successfully then a change to the DynamoDB table produces a stream record
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When the Lambda invocation processes the stream record successfully
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the Lambda invocation processes the stream record successfully then the event source mapping polls the stream and invokes the Lambda function with the record
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When the Lambda invocation processes the stream record successfully
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the Lambda invocation processes the stream record successfully then the Lambda invocation fails and the stream record is retried
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When the Lambda invocation processes the stream record successfully
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the Lambda invocation fails and the stream record is retried then a Lambda function is deployed
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When the Lambda invocation fails and the stream record is retried
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the Lambda invocation fails and the stream record is retried then a Lambda event source mapping is created to process the DynamoDB Stream
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When the Lambda invocation fails and the stream record is retried
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the Lambda invocation fails and the stream record is retried then a change to the DynamoDB table produces a stream record
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When the Lambda invocation fails and the stream record is retried
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the Lambda invocation fails and the stream record is retried then the event source mapping polls the stream and invokes the Lambda function with the record
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When the Lambda invocation fails and the stream record is retried
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the Lambda invocation fails and the stream record is retried then the Lambda invocation processes the stream record successfully
    Given tid not in table_status
    When a DynamoDB table is created with streaming enabled
    When the Lambda invocation fails and the stream record is retried
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a DynamoDB table is created with streaming enabled then a Lambda event source mapping is created to process the DynamoDB Stream
    Given fid not in func_status
    When a Lambda function is deployed
    When a DynamoDB table is created with streaming enabled
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a DynamoDB table is created with streaming enabled then a change to the DynamoDB table produces a stream record
    Given fid not in func_status
    When a Lambda function is deployed
    When a DynamoDB table is created with streaming enabled
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a DynamoDB table is created with streaming enabled then the event source mapping polls the stream and invokes the Lambda function with the record
    Given fid not in func_status
    When a Lambda function is deployed
    When a DynamoDB table is created with streaming enabled
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a DynamoDB table is created with streaming enabled then the Lambda invocation processes the stream record successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When a DynamoDB table is created with streaming enabled
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a DynamoDB table is created with streaming enabled then the Lambda invocation fails and the stream record is retried
    Given fid not in func_status
    When a Lambda function is deployed
    When a DynamoDB table is created with streaming enabled
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Lambda event source mapping is created to process the DynamoDB Stream then a DynamoDB table is created with streaming enabled
    Given fid not in func_status
    When a Lambda function is deployed
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Lambda event source mapping is created to process the DynamoDB Stream then a change to the DynamoDB table produces a stream record
    Given fid not in func_status
    When a Lambda function is deployed
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Lambda event source mapping is created to process the DynamoDB Stream then the event source mapping polls the stream and invokes the Lambda function with the record
    Given fid not in func_status
    When a Lambda function is deployed
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation processes the stream record successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation fails and the stream record is retried
    Given fid not in func_status
    When a Lambda function is deployed
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a change to the DynamoDB table produces a stream record then a DynamoDB table is created with streaming enabled
    Given fid not in func_status
    When a Lambda function is deployed
    When a change to the DynamoDB table produces a stream record
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a change to the DynamoDB table produces a stream record then a Lambda event source mapping is created to process the DynamoDB Stream
    Given fid not in func_status
    When a Lambda function is deployed
    When a change to the DynamoDB table produces a stream record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a change to the DynamoDB table produces a stream record then the event source mapping polls the stream and invokes the Lambda function with the record
    Given fid not in func_status
    When a Lambda function is deployed
    When a change to the DynamoDB table produces a stream record
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a change to the DynamoDB table produces a stream record then the Lambda invocation processes the stream record successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When a change to the DynamoDB table produces a stream record
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a change to the DynamoDB table produces a stream record then the Lambda invocation fails and the stream record is retried
    Given fid not in func_status
    When a Lambda function is deployed
    When a change to the DynamoDB table produces a stream record
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the event source mapping polls the stream and invokes the Lambda function with the record then a DynamoDB table is created with streaming enabled
    Given fid not in func_status
    When a Lambda function is deployed
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda event source mapping is created to process the DynamoDB Stream
    Given fid not in func_status
    When a Lambda function is deployed
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the event source mapping polls the stream and invokes the Lambda function with the record then a change to the DynamoDB table produces a stream record
    Given fid not in func_status
    When a Lambda function is deployed
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation processes the stream record successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation fails and the stream record is retried
    Given fid not in func_status
    When a Lambda function is deployed
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation processes the stream record successfully then a DynamoDB table is created with streaming enabled
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation processes the stream record successfully
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation processes the stream record successfully then a Lambda event source mapping is created to process the DynamoDB Stream
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation processes the stream record successfully
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation processes the stream record successfully then a change to the DynamoDB table produces a stream record
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation processes the stream record successfully
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation processes the stream record successfully then the event source mapping polls the stream and invokes the Lambda function with the record
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation processes the stream record successfully
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation processes the stream record successfully then the Lambda invocation fails and the stream record is retried
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation processes the stream record successfully
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails and the stream record is retried then a DynamoDB table is created with streaming enabled
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails and the stream record is retried
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails and the stream record is retried then a Lambda event source mapping is created to process the DynamoDB Stream
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails and the stream record is retried
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails and the stream record is retried then a change to the DynamoDB table produces a stream record
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails and the stream record is retried
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails and the stream record is retried then the event source mapping polls the stream and invokes the Lambda function with the record
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails and the stream record is retried
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails and the stream record is retried then the Lambda invocation processes the stream record successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails and the stream record is retried
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a DynamoDB table is created with streaming enabled then a Lambda function is deployed
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a DynamoDB table is created with streaming enabled
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a DynamoDB table is created with streaming enabled then a change to the DynamoDB table produces a stream record
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a DynamoDB table is created with streaming enabled
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a DynamoDB table is created with streaming enabled then the event source mapping polls the stream and invokes the Lambda function with the record
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a DynamoDB table is created with streaming enabled
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a DynamoDB table is created with streaming enabled then the Lambda invocation processes the stream record successfully
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a DynamoDB table is created with streaming enabled
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a DynamoDB table is created with streaming enabled then the Lambda invocation fails and the stream record is retried
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a DynamoDB table is created with streaming enabled
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a Lambda function is deployed then a DynamoDB table is created with streaming enabled
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a Lambda function is deployed
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a Lambda function is deployed then a change to the DynamoDB table produces a stream record
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a Lambda function is deployed
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a Lambda function is deployed then the event source mapping polls the stream and invokes the Lambda function with the record
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a Lambda function is deployed
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a Lambda function is deployed then the Lambda invocation processes the stream record successfully
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a Lambda function is deployed
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a Lambda function is deployed then the Lambda invocation fails and the stream record is retried
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a Lambda function is deployed
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a change to the DynamoDB table produces a stream record then a DynamoDB table is created with streaming enabled
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a change to the DynamoDB table produces a stream record
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a change to the DynamoDB table produces a stream record then a Lambda function is deployed
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a change to the DynamoDB table produces a stream record
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a change to the DynamoDB table produces a stream record then the event source mapping polls the stream and invokes the Lambda function with the record
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a change to the DynamoDB table produces a stream record
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a change to the DynamoDB table produces a stream record then the Lambda invocation processes the stream record successfully
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a change to the DynamoDB table produces a stream record
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a change to the DynamoDB table produces a stream record then the Lambda invocation fails and the stream record is retried
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a change to the DynamoDB table produces a stream record
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the event source mapping polls the stream and invokes the Lambda function with the record then a DynamoDB table is created with streaming enabled
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda function is deployed
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the event source mapping polls the stream and invokes the Lambda function with the record then a change to the DynamoDB table produces a stream record
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation processes the stream record successfully
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation fails and the stream record is retried
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation processes the stream record successfully then a DynamoDB table is created with streaming enabled
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the Lambda invocation processes the stream record successfully
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation processes the stream record successfully then a Lambda function is deployed
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the Lambda invocation processes the stream record successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation processes the stream record successfully then a change to the DynamoDB table produces a stream record
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the Lambda invocation processes the stream record successfully
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation processes the stream record successfully then the event source mapping polls the stream and invokes the Lambda function with the record
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the Lambda invocation processes the stream record successfully
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation processes the stream record successfully then the Lambda invocation fails and the stream record is retried
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the Lambda invocation processes the stream record successfully
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation fails and the stream record is retried then a DynamoDB table is created with streaming enabled
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the Lambda invocation fails and the stream record is retried
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation fails and the stream record is retried then a Lambda function is deployed
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the Lambda invocation fails and the stream record is retried
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation fails and the stream record is retried then a change to the DynamoDB table produces a stream record
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the Lambda invocation fails and the stream record is retried
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation fails and the stream record is retried then the event source mapping polls the stream and invokes the Lambda function with the record
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the Lambda invocation fails and the stream record is retried
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation fails and the stream record is retried then the Lambda invocation processes the stream record successfully
    Given eid not in esm_status
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the Lambda invocation fails and the stream record is retried
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a DynamoDB table is created with streaming enabled then a Lambda function is deployed
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When a DynamoDB table is created with streaming enabled
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a DynamoDB table is created with streaming enabled then a Lambda event source mapping is created to process the DynamoDB Stream
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When a DynamoDB table is created with streaming enabled
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a DynamoDB table is created with streaming enabled then the event source mapping polls the stream and invokes the Lambda function with the record
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When a DynamoDB table is created with streaming enabled
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a DynamoDB table is created with streaming enabled then the Lambda invocation processes the stream record successfully
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When a DynamoDB table is created with streaming enabled
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a DynamoDB table is created with streaming enabled then the Lambda invocation fails and the stream record is retried
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When a DynamoDB table is created with streaming enabled
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a Lambda function is deployed then a DynamoDB table is created with streaming enabled
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When a Lambda function is deployed
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a Lambda function is deployed then a Lambda event source mapping is created to process the DynamoDB Stream
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When a Lambda function is deployed
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a Lambda function is deployed then the event source mapping polls the stream and invokes the Lambda function with the record
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When a Lambda function is deployed
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a Lambda function is deployed then the Lambda invocation processes the stream record successfully
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When a Lambda function is deployed
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a Lambda function is deployed then the Lambda invocation fails and the stream record is retried
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When a Lambda function is deployed
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a Lambda event source mapping is created to process the DynamoDB Stream then a DynamoDB table is created with streaming enabled
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a Lambda event source mapping is created to process the DynamoDB Stream then a Lambda function is deployed
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a Lambda event source mapping is created to process the DynamoDB Stream then the event source mapping polls the stream and invokes the Lambda function with the record
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation processes the stream record successfully
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation fails and the stream record is retried
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the event source mapping polls the stream and invokes the Lambda function with the record then a DynamoDB table is created with streaming enabled
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda function is deployed
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda event source mapping is created to process the DynamoDB Stream
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation processes the stream record successfully
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation fails and the stream record is retried
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the Lambda invocation processes the stream record successfully then a DynamoDB table is created with streaming enabled
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When the Lambda invocation processes the stream record successfully
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the Lambda invocation processes the stream record successfully then a Lambda function is deployed
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When the Lambda invocation processes the stream record successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the Lambda invocation processes the stream record successfully then a Lambda event source mapping is created to process the DynamoDB Stream
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When the Lambda invocation processes the stream record successfully
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the Lambda invocation processes the stream record successfully then the event source mapping polls the stream and invokes the Lambda function with the record
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When the Lambda invocation processes the stream record successfully
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the Lambda invocation processes the stream record successfully then the Lambda invocation fails and the stream record is retried
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When the Lambda invocation processes the stream record successfully
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the Lambda invocation fails and the stream record is retried then a DynamoDB table is created with streaming enabled
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When the Lambda invocation fails and the stream record is retried
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the Lambda invocation fails and the stream record is retried then a Lambda function is deployed
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When the Lambda invocation fails and the stream record is retried
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the Lambda invocation fails and the stream record is retried then a Lambda event source mapping is created to process the DynamoDB Stream
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When the Lambda invocation fails and the stream record is retried
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the Lambda invocation fails and the stream record is retried then the event source mapping polls the stream and invokes the Lambda function with the record
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When the Lambda invocation fails and the stream record is retried
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the Lambda invocation fails and the stream record is retried then the Lambda invocation processes the stream record successfully
    Given tid in table_status
    When a change to the DynamoDB table produces a stream record
    When the Lambda invocation fails and the stream record is retried
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a DynamoDB table is created with streaming enabled then a Lambda function is deployed
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a DynamoDB table is created with streaming enabled
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a DynamoDB table is created with streaming enabled then a Lambda event source mapping is created to process the DynamoDB Stream
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a DynamoDB table is created with streaming enabled
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a DynamoDB table is created with streaming enabled then a change to the DynamoDB table produces a stream record
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a DynamoDB table is created with streaming enabled
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a DynamoDB table is created with streaming enabled then the Lambda invocation processes the stream record successfully
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a DynamoDB table is created with streaming enabled
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a DynamoDB table is created with streaming enabled then the Lambda invocation fails and the stream record is retried
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a DynamoDB table is created with streaming enabled
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda function is deployed then a DynamoDB table is created with streaming enabled
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a Lambda function is deployed
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda function is deployed then a Lambda event source mapping is created to process the DynamoDB Stream
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a Lambda function is deployed
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda function is deployed then a change to the DynamoDB table produces a stream record
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a Lambda function is deployed
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda function is deployed then the Lambda invocation processes the stream record successfully
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a Lambda function is deployed
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda function is deployed then the Lambda invocation fails and the stream record is retried
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a Lambda function is deployed
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda event source mapping is created to process the DynamoDB Stream then a DynamoDB table is created with streaming enabled
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda event source mapping is created to process the DynamoDB Stream then a Lambda function is deployed
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda event source mapping is created to process the DynamoDB Stream then a change to the DynamoDB table produces a stream record
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation processes the stream record successfully
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation fails and the stream record is retried
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a change to the DynamoDB table produces a stream record then a DynamoDB table is created with streaming enabled
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a change to the DynamoDB table produces a stream record
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a change to the DynamoDB table produces a stream record then a Lambda function is deployed
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a change to the DynamoDB table produces a stream record
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a change to the DynamoDB table produces a stream record then a Lambda event source mapping is created to process the DynamoDB Stream
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a change to the DynamoDB table produces a stream record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a change to the DynamoDB table produces a stream record then the Lambda invocation processes the stream record successfully
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a change to the DynamoDB table produces a stream record
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a change to the DynamoDB table produces a stream record then the Lambda invocation fails and the stream record is retried
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a change to the DynamoDB table produces a stream record
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation processes the stream record successfully then a DynamoDB table is created with streaming enabled
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When the Lambda invocation processes the stream record successfully
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation processes the stream record successfully then a Lambda function is deployed
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When the Lambda invocation processes the stream record successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation processes the stream record successfully then a Lambda event source mapping is created to process the DynamoDB Stream
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When the Lambda invocation processes the stream record successfully
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation processes the stream record successfully then a change to the DynamoDB table produces a stream record
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When the Lambda invocation processes the stream record successfully
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation processes the stream record successfully then the Lambda invocation fails and the stream record is retried
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When the Lambda invocation processes the stream record successfully
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation fails and the stream record is retried then a DynamoDB table is created with streaming enabled
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When the Lambda invocation fails and the stream record is retried
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation fails and the stream record is retried then a Lambda function is deployed
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When the Lambda invocation fails and the stream record is retried
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation fails and the stream record is retried then a Lambda event source mapping is created to process the DynamoDB Stream
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When the Lambda invocation fails and the stream record is retried
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation fails and the stream record is retried then a change to the DynamoDB table produces a stream record
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When the Lambda invocation fails and the stream record is retried
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation fails and the stream record is retried then the Lambda invocation processes the stream record successfully
    Given eid in esm_status
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When the Lambda invocation fails and the stream record is retried
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a DynamoDB table is created with streaming enabled then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a DynamoDB table is created with streaming enabled
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a DynamoDB table is created with streaming enabled then a Lambda event source mapping is created to process the DynamoDB Stream
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a DynamoDB table is created with streaming enabled
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a DynamoDB table is created with streaming enabled then a change to the DynamoDB table produces a stream record
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a DynamoDB table is created with streaming enabled
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a DynamoDB table is created with streaming enabled then the event source mapping polls the stream and invokes the Lambda function with the record
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a DynamoDB table is created with streaming enabled
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a DynamoDB table is created with streaming enabled then the Lambda invocation fails and the stream record is retried
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a DynamoDB table is created with streaming enabled
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a Lambda function is deployed then a DynamoDB table is created with streaming enabled
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a Lambda function is deployed
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a Lambda function is deployed then a Lambda event source mapping is created to process the DynamoDB Stream
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a Lambda function is deployed
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a Lambda function is deployed then a change to the DynamoDB table produces a stream record
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a Lambda function is deployed
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a Lambda function is deployed then the event source mapping polls the stream and invokes the Lambda function with the record
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a Lambda function is deployed
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a Lambda function is deployed then the Lambda invocation fails and the stream record is retried
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a Lambda function is deployed
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a Lambda event source mapping is created to process the DynamoDB Stream then a DynamoDB table is created with streaming enabled
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a Lambda event source mapping is created to process the DynamoDB Stream then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a Lambda event source mapping is created to process the DynamoDB Stream then a change to the DynamoDB table produces a stream record
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a Lambda event source mapping is created to process the DynamoDB Stream then the event source mapping polls the stream and invokes the Lambda function with the record
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation fails and the stream record is retried
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a change to the DynamoDB table produces a stream record then a DynamoDB table is created with streaming enabled
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a change to the DynamoDB table produces a stream record
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a change to the DynamoDB table produces a stream record then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a change to the DynamoDB table produces a stream record
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a change to the DynamoDB table produces a stream record then a Lambda event source mapping is created to process the DynamoDB Stream
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a change to the DynamoDB table produces a stream record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a change to the DynamoDB table produces a stream record then the event source mapping polls the stream and invokes the Lambda function with the record
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a change to the DynamoDB table produces a stream record
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a change to the DynamoDB table produces a stream record then the Lambda invocation fails and the stream record is retried
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When a change to the DynamoDB table produces a stream record
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then the event source mapping polls the stream and invokes the Lambda function with the record then a DynamoDB table is created with streaming enabled
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda event source mapping is created to process the DynamoDB Stream
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then the event source mapping polls the stream and invokes the Lambda function with the record then a change to the DynamoDB table produces a stream record
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation fails and the stream record is retried
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When the Lambda invocation fails and the stream record is retried
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then the Lambda invocation fails and the stream record is retried then a DynamoDB table is created with streaming enabled
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When the Lambda invocation fails and the stream record is retried
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then the Lambda invocation fails and the stream record is retried then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When the Lambda invocation fails and the stream record is retried
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then the Lambda invocation fails and the stream record is retried then a Lambda event source mapping is created to process the DynamoDB Stream
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When the Lambda invocation fails and the stream record is retried
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then the Lambda invocation fails and the stream record is retried then a change to the DynamoDB table produces a stream record
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When the Lambda invocation fails and the stream record is retried
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation processes the stream record successfully then the Lambda invocation fails and the stream record is retried then the event source mapping polls the stream and invokes the Lambda function with the record
    Given iid in inv_status
    When the Lambda invocation processes the stream record successfully
    When the Lambda invocation fails and the stream record is retried
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a DynamoDB table is created with streaming enabled then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a DynamoDB table is created with streaming enabled
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a DynamoDB table is created with streaming enabled then a Lambda event source mapping is created to process the DynamoDB Stream
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a DynamoDB table is created with streaming enabled
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a DynamoDB table is created with streaming enabled then a change to the DynamoDB table produces a stream record
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a DynamoDB table is created with streaming enabled
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a DynamoDB table is created with streaming enabled then the event source mapping polls the stream and invokes the Lambda function with the record
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a DynamoDB table is created with streaming enabled
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a DynamoDB table is created with streaming enabled then the Lambda invocation processes the stream record successfully
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a DynamoDB table is created with streaming enabled
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a Lambda function is deployed then a DynamoDB table is created with streaming enabled
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a Lambda function is deployed
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a Lambda function is deployed then a Lambda event source mapping is created to process the DynamoDB Stream
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a Lambda function is deployed
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a Lambda function is deployed then a change to the DynamoDB table produces a stream record
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a Lambda function is deployed
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a Lambda function is deployed then the event source mapping polls the stream and invokes the Lambda function with the record
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a Lambda function is deployed
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a Lambda function is deployed then the Lambda invocation processes the stream record successfully
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a Lambda function is deployed
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a Lambda event source mapping is created to process the DynamoDB Stream then a DynamoDB table is created with streaming enabled
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a Lambda event source mapping is created to process the DynamoDB Stream then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a Lambda event source mapping is created to process the DynamoDB Stream then a change to the DynamoDB table produces a stream record
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a Lambda event source mapping is created to process the DynamoDB Stream then the event source mapping polls the stream and invokes the Lambda function with the record
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation processes the stream record successfully
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a Lambda event source mapping is created to process the DynamoDB Stream
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a change to the DynamoDB table produces a stream record then a DynamoDB table is created with streaming enabled
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a change to the DynamoDB table produces a stream record
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a change to the DynamoDB table produces a stream record then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a change to the DynamoDB table produces a stream record
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a change to the DynamoDB table produces a stream record then a Lambda event source mapping is created to process the DynamoDB Stream
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a change to the DynamoDB table produces a stream record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a change to the DynamoDB table produces a stream record then the event source mapping polls the stream and invokes the Lambda function with the record
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a change to the DynamoDB table produces a stream record
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a change to the DynamoDB table produces a stream record then the Lambda invocation processes the stream record successfully
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When a change to the DynamoDB table produces a stream record
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then the event source mapping polls the stream and invokes the Lambda function with the record then a DynamoDB table is created with streaming enabled
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda event source mapping is created to process the DynamoDB Stream
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then the event source mapping polls the stream and invokes the Lambda function with the record then a change to the DynamoDB table produces a stream record
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation processes the stream record successfully
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When the event source mapping polls the stream and invokes the Lambda function with the record
    When the Lambda invocation processes the stream record successfully
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then the Lambda invocation processes the stream record successfully then a DynamoDB table is created with streaming enabled
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When the Lambda invocation processes the stream record successfully
    When a DynamoDB table is created with streaming enabled
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then the Lambda invocation processes the stream record successfully then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When the Lambda invocation processes the stream record successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then the Lambda invocation processes the stream record successfully then a Lambda event source mapping is created to process the DynamoDB Stream
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When the Lambda invocation processes the stream record successfully
    When a Lambda event source mapping is created to process the DynamoDB Stream
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then the Lambda invocation processes the stream record successfully then a change to the DynamoDB table produces a stream record
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When the Lambda invocation processes the stream record successfully
    When a change to the DynamoDB table produces a stream record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then the Lambda invocation processes the stream record successfully then the event source mapping polls the stream and invokes the Lambda function with the record
    Given iid in inv_status
    When the Lambda invocation fails and the stream record is retried
    When the Lambda invocation processes the stream record successfully
    When the event source mapping polls the stream and invokes the Lambda function with the record
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled
