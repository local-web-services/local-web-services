@dynamodblambda @generated
Feature: DynamodbLambda - Action Sequences

  # Generated from FizzBee spec: dynamodb_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, ESMReferencesActiveStream

  Background:
    Given the system is initialized

  @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a Lambda function is deployed
    Given tid not in table_status
    Given a DynamoDB table has been created with streaming enabled
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a Lambda event source mapping is created to process the DynamoDB Stream
    Given tid not in table_status
    Given a DynamoDB table has been created with streaming enabled
    When a Lambda event source mapping is created to process the DynamoDB Stream
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a change to the DynamoDB table produces a stream record
    Given tid not in table_status
    Given a DynamoDB table has been created with streaming enabled
    When a change to the DynamoDB table produces a stream record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the event source mapping polls the stream and invokes the Lambda function with the record
    Given tid not in table_status
    Given a DynamoDB table has been created with streaming enabled
    When the event source mapping polls the stream and invokes the Lambda function with the record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the Lambda invocation processes the stream record successfully
    Given tid not in table_status
    Given a DynamoDB table has been created with streaming enabled
    When the Lambda invocation processes the stream record successfully
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the Lambda invocation fails and the stream record is retried
    Given tid not in table_status
    Given a DynamoDB table has been created with streaming enabled
    When the Lambda invocation fails and the stream record is retried
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda function is deployed then a DynamoDB table is created with streaming enabled
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a DynamoDB table is created with streaming enabled
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda function is deployed then a Lambda event source mapping is created to process the DynamoDB Stream
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a Lambda event source mapping is created to process the DynamoDB Stream
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda function is deployed then a change to the DynamoDB table produces a stream record
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a change to the DynamoDB table produces a stream record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda function is deployed then the event source mapping polls the stream and invokes the Lambda function with the record
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the event source mapping polls the stream and invokes the Lambda function with the record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation processes the stream record successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda invocation processes the stream record successfully
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails and the stream record is retried
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda invocation fails and the stream record is retried
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a DynamoDB table is created with streaming enabled
    Given eid not in esm_status
    Given a Lambda event source mapping has been created to process the DynamoDB Stream
    When a DynamoDB table is created with streaming enabled
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a Lambda function is deployed
    Given eid not in esm_status
    Given a Lambda event source mapping has been created to process the DynamoDB Stream
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a change to the DynamoDB table produces a stream record
    Given eid not in esm_status
    Given a Lambda event source mapping has been created to process the DynamoDB Stream
    When a change to the DynamoDB table produces a stream record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the event source mapping polls the stream and invokes the Lambda function with the record
    Given eid not in esm_status
    Given a Lambda event source mapping has been created to process the DynamoDB Stream
    When the event source mapping polls the stream and invokes the Lambda function with the record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation processes the stream record successfully
    Given eid not in esm_status
    Given a Lambda event source mapping has been created to process the DynamoDB Stream
    When the Lambda invocation processes the stream record successfully
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation fails and the stream record is retried
    Given eid not in esm_status
    Given a Lambda event source mapping has been created to process the DynamoDB Stream
    When the Lambda invocation fails and the stream record is retried
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a DynamoDB table is created with streaming enabled
    Given tid in table_status
    Given a change to the DynamoDB table has produced a stream record
    When a DynamoDB table is created with streaming enabled
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a Lambda function is deployed
    Given tid in table_status
    Given a change to the DynamoDB table has produced a stream record
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a Lambda event source mapping is created to process the DynamoDB Stream
    Given tid in table_status
    Given a change to the DynamoDB table has produced a stream record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the event source mapping polls the stream and invokes the Lambda function with the record
    Given tid in table_status
    Given a change to the DynamoDB table has produced a stream record
    When the event source mapping polls the stream and invokes the Lambda function with the record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the Lambda invocation processes the stream record successfully
    Given tid in table_status
    Given a change to the DynamoDB table has produced a stream record
    When the Lambda invocation processes the stream record successfully
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the Lambda invocation fails and the stream record is retried
    Given tid in table_status
    Given a change to the DynamoDB table has produced a stream record
    When the Lambda invocation fails and the stream record is retried
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a DynamoDB table is created with streaming enabled
    Given eid in esm_status
    Given the event source mapping has polled the stream and invoked the Lambda function with the record
    When a DynamoDB table is created with streaming enabled
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda function is deployed
    Given eid in esm_status
    Given the event source mapping has polled the stream and invoked the Lambda function with the record
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda event source mapping is created to process the DynamoDB Stream
    Given eid in esm_status
    Given the event source mapping has polled the stream and invoked the Lambda function with the record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a change to the DynamoDB table produces a stream record
    Given eid in esm_status
    Given the event source mapping has polled the stream and invoked the Lambda function with the record
    When a change to the DynamoDB table produces a stream record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation processes the stream record successfully
    Given eid in esm_status
    Given the event source mapping has polled the stream and invoked the Lambda function with the record
    When the Lambda invocation processes the stream record successfully
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation fails and the stream record is retried
    Given eid in esm_status
    Given the event source mapping has polled the stream and invoked the Lambda function with the record
    When the Lambda invocation fails and the stream record is retried
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a DynamoDB table is created with streaming enabled
    Given iid in inv_status
    Given the Lambda invocation has processed the stream record successfully
    When a DynamoDB table is created with streaming enabled
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has processed the stream record successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a Lambda event source mapping is created to process the DynamoDB Stream
    Given iid in inv_status
    Given the Lambda invocation has processed the stream record successfully
    When a Lambda event source mapping is created to process the DynamoDB Stream
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a change to the DynamoDB table produces a stream record
    Given iid in inv_status
    Given the Lambda invocation has processed the stream record successfully
    When a change to the DynamoDB table produces a stream record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then the event source mapping polls the stream and invokes the Lambda function with the record
    Given iid in inv_status
    Given the Lambda invocation has processed the stream record successfully
    When the event source mapping polls the stream and invokes the Lambda function with the record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then the Lambda invocation fails and the stream record is retried
    Given iid in inv_status
    Given the Lambda invocation has processed the stream record successfully
    When the Lambda invocation fails and the stream record is retried
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a DynamoDB table is created with streaming enabled
    Given iid in inv_status
    Given the Lambda invocation has failed and the stream record has been retried
    When a DynamoDB table is created with streaming enabled
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has failed and the stream record has been retried
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a Lambda event source mapping is created to process the DynamoDB Stream
    Given iid in inv_status
    Given the Lambda invocation has failed and the stream record has been retried
    When a Lambda event source mapping is created to process the DynamoDB Stream
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a change to the DynamoDB table produces a stream record
    Given iid in inv_status
    Given the Lambda invocation has failed and the stream record has been retried
    When a change to the DynamoDB table produces a stream record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then the event source mapping polls the stream and invokes the Lambda function with the record
    Given iid in inv_status
    Given the Lambda invocation has failed and the stream record has been retried
    When the event source mapping polls the stream and invokes the Lambda function with the record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then the Lambda invocation processes the stream record successfully
    Given iid in inv_status
    Given the Lambda invocation has failed and the stream record has been retried
    When the Lambda invocation processes the stream record successfully
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a Lambda function is deployed then a Lambda event source mapping is created to process the DynamoDB Stream
    Given tid not in table_status
    Given a DynamoDB table has been created with streaming enabled
    Given a Lambda function has been deployed
    When a Lambda event source mapping is created to process the DynamoDB Stream
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a Lambda event source mapping is created to process the DynamoDB Stream then a change to the DynamoDB table produces a stream record
    Given tid not in table_status
    Given a DynamoDB table has been created with streaming enabled
    Given a Lambda event source mapping has been created to process the DynamoDB Stream
    When a change to the DynamoDB table produces a stream record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a DynamoDB table is created with streaming enabled then a change to the DynamoDB table produces a stream record then the event source mapping polls the stream and invokes the Lambda function with the record
    Given tid not in table_status
    Given a DynamoDB table has been created with streaming enabled
    Given a change to the DynamoDB table has produced a stream record
    When the event source mapping polls the stream and invokes the Lambda function with the record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation processes the stream record successfully
    Given tid not in table_status
    Given a DynamoDB table has been created with streaming enabled
    Given the event source mapping has polled the stream and invoked the Lambda function with the record
    When the Lambda invocation processes the stream record successfully
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the Lambda invocation processes the stream record successfully then the Lambda invocation fails and the stream record is retried
    Given tid not in table_status
    Given a DynamoDB table has been created with streaming enabled
    Given the Lambda invocation has processed the stream record successfully
    When the Lambda invocation fails and the stream record is retried
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a DynamoDB table is created with streaming enabled then the Lambda invocation fails and the stream record is retried then a Lambda function is deployed
    Given tid not in table_status
    Given a DynamoDB table has been created with streaming enabled
    Given the Lambda invocation has failed and the stream record has been retried
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda function is deployed then a DynamoDB table is created with streaming enabled then a change to the DynamoDB table produces a stream record
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a DynamoDB table has been created with streaming enabled
    When a change to the DynamoDB table produces a stream record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda function is deployed then a Lambda event source mapping is created to process the DynamoDB Stream then the event source mapping polls the stream and invokes the Lambda function with the record
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a Lambda event source mapping has been created to process the DynamoDB Stream
    When the event source mapping polls the stream and invokes the Lambda function with the record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda function is deployed then a change to the DynamoDB table produces a stream record then the Lambda invocation processes the stream record successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a change to the DynamoDB table has produced a stream record
    When the Lambda invocation processes the stream record successfully
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda function is deployed then the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation fails and the stream record is retried
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the event source mapping has polled the stream and invoked the Lambda function with the record
    When the Lambda invocation fails and the stream record is retried
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation processes the stream record successfully then a DynamoDB table is created with streaming enabled
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda invocation has processed the stream record successfully
    When a DynamoDB table is created with streaming enabled
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails and the stream record is retried then a Lambda event source mapping is created to process the DynamoDB Stream
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda invocation has failed and the stream record has been retried
    When a Lambda event source mapping is created to process the DynamoDB Stream
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a DynamoDB table is created with streaming enabled then the event source mapping polls the stream and invokes the Lambda function with the record
    Given eid not in esm_status
    Given a Lambda event source mapping has been created to process the DynamoDB Stream
    Given a DynamoDB table has been created with streaming enabled
    When the event source mapping polls the stream and invokes the Lambda function with the record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a Lambda function is deployed then the Lambda invocation processes the stream record successfully
    Given eid not in esm_status
    Given a Lambda event source mapping has been created to process the DynamoDB Stream
    Given a Lambda function has been deployed
    When the Lambda invocation processes the stream record successfully
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then a change to the DynamoDB table produces a stream record then the Lambda invocation fails and the stream record is retried
    Given eid not in esm_status
    Given a Lambda event source mapping has been created to process the DynamoDB Stream
    Given a change to the DynamoDB table has produced a stream record
    When the Lambda invocation fails and the stream record is retried
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the event source mapping polls the stream and invokes the Lambda function with the record then a DynamoDB table is created with streaming enabled
    Given eid not in esm_status
    Given a Lambda event source mapping has been created to process the DynamoDB Stream
    Given the event source mapping has polled the stream and invoked the Lambda function with the record
    When a DynamoDB table is created with streaming enabled
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation processes the stream record successfully then a Lambda function is deployed
    Given eid not in esm_status
    Given a Lambda event source mapping has been created to process the DynamoDB Stream
    Given the Lambda invocation has processed the stream record successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream then the Lambda invocation fails and the stream record is retried then a change to the DynamoDB table produces a stream record
    Given eid not in esm_status
    Given a Lambda event source mapping has been created to process the DynamoDB Stream
    Given the Lambda invocation has failed and the stream record has been retried
    When a change to the DynamoDB table produces a stream record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a DynamoDB table is created with streaming enabled then the Lambda invocation processes the stream record successfully
    Given tid in table_status
    Given a change to the DynamoDB table has produced a stream record
    Given a DynamoDB table has been created with streaming enabled
    When the Lambda invocation processes the stream record successfully
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a Lambda function is deployed then the Lambda invocation fails and the stream record is retried
    Given tid in table_status
    Given a change to the DynamoDB table has produced a stream record
    Given a Lambda function has been deployed
    When the Lambda invocation fails and the stream record is retried
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the DynamoDB table produces a stream record then a Lambda event source mapping is created to process the DynamoDB Stream then a DynamoDB table is created with streaming enabled
    Given tid in table_status
    Given a change to the DynamoDB table has produced a stream record
    Given a Lambda event source mapping has been created to process the DynamoDB Stream
    When a DynamoDB table is created with streaming enabled
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda function is deployed
    Given tid in table_status
    Given a change to the DynamoDB table has produced a stream record
    Given the event source mapping has polled the stream and invoked the Lambda function with the record
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the Lambda invocation processes the stream record successfully then a Lambda event source mapping is created to process the DynamoDB Stream
    Given tid in table_status
    Given a change to the DynamoDB table has produced a stream record
    Given the Lambda invocation has processed the stream record successfully
    When a Lambda event source mapping is created to process the DynamoDB Stream
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: a change to the DynamoDB table produces a stream record then the Lambda invocation fails and the stream record is retried then the event source mapping polls the stream and invokes the Lambda function with the record
    Given tid in table_status
    Given a change to the DynamoDB table has produced a stream record
    Given the Lambda invocation has failed and the stream record has been retried
    When the event source mapping polls the stream and invokes the Lambda function with the record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a DynamoDB table is created with streaming enabled then the Lambda invocation fails and the stream record is retried
    Given eid in esm_status
    Given the event source mapping has polled the stream and invoked the Lambda function with the record
    Given a DynamoDB table has been created with streaming enabled
    When the Lambda invocation fails and the stream record is retried
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda function is deployed then a DynamoDB table is created with streaming enabled
    Given eid in esm_status
    Given the event source mapping has polled the stream and invoked the Lambda function with the record
    Given a Lambda function has been deployed
    When a DynamoDB table is created with streaming enabled
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a Lambda event source mapping is created to process the DynamoDB Stream then a Lambda function is deployed
    Given eid in esm_status
    Given the event source mapping has polled the stream and invoked the Lambda function with the record
    Given a Lambda event source mapping has been created to process the DynamoDB Stream
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then a change to the DynamoDB table produces a stream record then a Lambda event source mapping is created to process the DynamoDB Stream
    Given eid in esm_status
    Given the event source mapping has polled the stream and invoked the Lambda function with the record
    Given a change to the DynamoDB table has produced a stream record
    When a Lambda event source mapping is created to process the DynamoDB Stream
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation processes the stream record successfully then a change to the DynamoDB table produces a stream record
    Given eid in esm_status
    Given the event source mapping has polled the stream and invoked the Lambda function with the record
    Given the Lambda invocation has processed the stream record successfully
    When a change to the DynamoDB table produces a stream record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation fails and the stream record is retried then the Lambda invocation processes the stream record successfully
    Given eid in esm_status
    Given the event source mapping has polled the stream and invoked the Lambda function with the record
    Given the Lambda invocation has failed and the stream record has been retried
    When the Lambda invocation processes the stream record successfully
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a DynamoDB table is created with streaming enabled then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has processed the stream record successfully
    Given a DynamoDB table has been created with streaming enabled
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a Lambda function is deployed then a Lambda event source mapping is created to process the DynamoDB Stream
    Given iid in inv_status
    Given the Lambda invocation has processed the stream record successfully
    Given a Lambda function has been deployed
    When a Lambda event source mapping is created to process the DynamoDB Stream
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a Lambda event source mapping is created to process the DynamoDB Stream then a change to the DynamoDB table produces a stream record
    Given iid in inv_status
    Given the Lambda invocation has processed the stream record successfully
    Given a Lambda event source mapping has been created to process the DynamoDB Stream
    When a change to the DynamoDB table produces a stream record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then a change to the DynamoDB table produces a stream record then the event source mapping polls the stream and invokes the Lambda function with the record
    Given iid in inv_status
    Given the Lambda invocation has processed the stream record successfully
    Given a change to the DynamoDB table has produced a stream record
    When the event source mapping polls the stream and invokes the Lambda function with the record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then the event source mapping polls the stream and invokes the Lambda function with the record then the Lambda invocation fails and the stream record is retried
    Given iid in inv_status
    Given the Lambda invocation has processed the stream record successfully
    Given the event source mapping has polled the stream and invoked the Lambda function with the record
    When the Lambda invocation fails and the stream record is retried
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation processes the stream record successfully then the Lambda invocation fails and the stream record is retried then a DynamoDB table is created with streaming enabled
    Given iid in inv_status
    Given the Lambda invocation has processed the stream record successfully
    Given the Lambda invocation has failed and the stream record has been retried
    When a DynamoDB table is created with streaming enabled
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a DynamoDB table is created with streaming enabled then a Lambda event source mapping is created to process the DynamoDB Stream
    Given iid in inv_status
    Given the Lambda invocation has failed and the stream record has been retried
    Given a DynamoDB table has been created with streaming enabled
    When a Lambda event source mapping is created to process the DynamoDB Stream
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a Lambda function is deployed then a change to the DynamoDB table produces a stream record
    Given iid in inv_status
    Given the Lambda invocation has failed and the stream record has been retried
    Given a Lambda function has been deployed
    When a change to the DynamoDB table produces a stream record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a Lambda event source mapping is created to process the DynamoDB Stream then the event source mapping polls the stream and invokes the Lambda function with the record
    Given iid in inv_status
    Given the Lambda invocation has failed and the stream record has been retried
    Given a Lambda event source mapping has been created to process the DynamoDB Stream
    When the event source mapping polls the stream and invokes the Lambda function with the record
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then a change to the DynamoDB table produces a stream record then the Lambda invocation processes the stream record successfully
    Given iid in inv_status
    Given the Lambda invocation has failed and the stream record has been retried
    Given a change to the DynamoDB table has produced a stream record
    When the Lambda invocation processes the stream record successfully
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then the event source mapping polls the stream and invokes the Lambda function with the record then a DynamoDB table is created with streaming enabled
    Given iid in inv_status
    Given the Lambda invocation has failed and the stream record has been retried
    Given the event source mapping has polled the stream and invoked the Lambda function with the record
    When a DynamoDB table is created with streaming enabled
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @sequence
  Scenario: the Lambda invocation fails and the stream record is retried then the Lambda invocation processes the stream record successfully then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has failed and the stream record has been retried
    Given the Lambda invocation has processed the stream record successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled
