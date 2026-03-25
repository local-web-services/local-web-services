@lambdasqsproducer @generated
Feature: LambdaSqsProducer - Action Sequences

  # Generated from FizzBee spec: lambda_sqs_producer.fizz
  # Safety invariants: InvocationRequiresActiveFunction, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "SQS" queue is created
    Given fid not in func_status
    When a Lambda function is deployed
    When an "SQS" queue is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function sends a message to the "SQS" queue during invocation
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function sends a message to the "SQS" queue during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a Lambda function is deployed
    Given qid not in queue_status
    When an "SQS" queue is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda function is invoked
    Given qid not in queue_status
    When an "SQS" queue is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda function sends a message to the "SQS" queue during invocation
    Given qid not in queue_status
    When an "SQS" queue is created
    When the Lambda function sends a message to the "SQS" queue during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda invocation completes successfully
    Given qid not in queue_status
    When an "SQS" queue is created
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda invocation fails
    Given qid not in queue_status
    When an "SQS" queue is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an "SQS" queue is created
    Given fid in func_status
    When the Lambda function is invoked
    When an "SQS" queue is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function sends a message to the "SQS" queue during invocation
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function sends a message to the "SQS" queue during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function sends a message to the "SQS" queue during invocation
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation then an "SQS" queue is created
    Given iid in inv_status
    When the Lambda function sends a message to the "SQS" queue during invocation
    When an "SQS" queue is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function sends a message to the "SQS" queue during invocation
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda function sends a message to the "SQS" queue during invocation
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda function sends a message to the "SQS" queue during invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an "SQS" queue is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an "SQS" queue is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function sends a message to the "SQS" queue during invocation
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function sends a message to the "SQS" queue during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an "SQS" queue is created
    Given iid in inv_status
    When the Lambda invocation fails
    When an "SQS" queue is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function sends a message to the "SQS" queue during invocation
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function sends a message to the "SQS" queue during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "SQS" queue is created then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When an "SQS" queue is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function sends a message to the "SQS" queue during invocation
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda function sends a message to the "SQS" queue during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function sends a message to the "SQS" queue during invocation then the Lambda invocation completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function sends a message to the "SQS" queue during invocation
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully then the Lambda invocation fails
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails then an "SQS" queue is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails
    When an "SQS" queue is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a Lambda function is deployed then the Lambda function sends a message to the "SQS" queue during invocation
    Given qid not in queue_status
    When an "SQS" queue is created
    When a Lambda function is deployed
    When the Lambda function sends a message to the "SQS" queue during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda function is invoked then the Lambda invocation completes successfully
    Given qid not in queue_status
    When an "SQS" queue is created
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda function sends a message to the "SQS" queue during invocation then the Lambda invocation fails
    Given qid not in queue_status
    When an "SQS" queue is created
    When the Lambda function sends a message to the "SQS" queue during invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda invocation completes successfully then a Lambda function is deployed
    Given qid not in queue_status
    When an "SQS" queue is created
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda invocation fails then the Lambda function is invoked
    Given qid not in queue_status
    When an "SQS" queue is created
    When the Lambda invocation fails
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an "SQS" queue is created then the Lambda invocation fails
    Given fid in func_status
    When the Lambda function is invoked
    When an "SQS" queue is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function sends a message to the "SQS" queue during invocation then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function sends a message to the "SQS" queue during invocation
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully then an "SQS" queue is created
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    When an "SQS" queue is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails then the Lambda function sends a message to the "SQS" queue during invocation
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation fails
    When the Lambda function sends a message to the "SQS" queue during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation then a Lambda function is deployed then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda function sends a message to the "SQS" queue during invocation
    When a Lambda function is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation then an "SQS" queue is created then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function sends a message to the "SQS" queue during invocation
    When an "SQS" queue is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation then the Lambda function is invoked then an "SQS" queue is created
    Given iid in inv_status
    When the Lambda function sends a message to the "SQS" queue during invocation
    When the Lambda function is invoked
    When an "SQS" queue is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation then the Lambda invocation completes successfully then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function sends a message to the "SQS" queue during invocation
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation then the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda function sends a message to the "SQS" queue during invocation
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed then an "SQS" queue is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    When an "SQS" queue is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an "SQS" queue is created then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an "SQS" queue is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked then the Lambda function sends a message to the "SQS" queue during invocation
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    When the Lambda function sends a message to the "SQS" queue during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function sends a message to the "SQS" queue during invocation then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function sends a message to the "SQS" queue during invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an "SQS" queue is created then the Lambda function sends a message to the "SQS" queue during invocation
    Given iid in inv_status
    When the Lambda invocation fails
    When an "SQS" queue is created
    When the Lambda function sends a message to the "SQS" queue during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function sends a message to the "SQS" queue during invocation then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function sends a message to the "SQS" queue during invocation
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then an "SQS" queue is created
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    When an "SQS" queue is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
