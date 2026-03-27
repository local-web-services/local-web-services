@lambdasqsproducer @generated
Feature: LambdaSqsProducer - Action Sequences

  # Generated from FizzBee spec: lambda_sqs_producer.fizz
  # Safety invariants: InvocationRequiresActiveFunction, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "SQS" queue is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    When an "SQS" queue is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function sends a message to the "SQS" queue during invocation
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function sends a message to the "SQS" queue during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a Lambda function is deployed
    Given qid not in queue_status
    Given an "SQS" queue has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda function is invoked
    Given qid not in queue_status
    Given an "SQS" queue has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda function sends a message to the "SQS" queue during invocation
    Given qid not in queue_status
    Given an "SQS" queue has been created
    When the Lambda function sends a message to the "SQS" queue during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda invocation completes successfully
    Given qid not in queue_status
    Given an "SQS" queue has been created
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda invocation fails
    Given qid not in queue_status
    Given an "SQS" queue has been created
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an "SQS" queue is created
    Given fid in func_status
    Given the Lambda function has been invoked
    When an "SQS" queue is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function sends a message to the "SQS" queue during invocation
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function sends a message to the "SQS" queue during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has sent a message to the "SQS" queue during invocation
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation then an "SQS" queue is created
    Given iid in inv_status
    Given the Lambda function has sent a message to the "SQS" queue during invocation
    When an "SQS" queue is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has sent a message to the "SQS" queue during invocation
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda function has sent a message to the "SQS" queue during invocation
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda function has sent a message to the "SQS" queue during invocation
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an "SQS" queue is created
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When an "SQS" queue is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function sends a message to the "SQS" queue during invocation
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When the Lambda function sends a message to the "SQS" queue during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has failed
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an "SQS" queue is created
    Given iid in inv_status
    Given the Lambda invocation has failed
    When an "SQS" queue is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda invocation has failed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function sends a message to the "SQS" queue during invocation
    Given iid in inv_status
    Given the Lambda invocation has failed
    When the Lambda function sends a message to the "SQS" queue during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda invocation has failed
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "SQS" queue is created then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given an "SQS" queue has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function sends a message to the "SQS" queue during invocation
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has been invoked
    When the Lambda function sends a message to the "SQS" queue during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function sends a message to the "SQS" queue during invocation then the Lambda invocation completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has sent a message to the "SQS" queue during invocation
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully then the Lambda invocation fails
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda invocation has completed successfully
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails then an "SQS" queue is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda invocation has failed
    When an "SQS" queue is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a Lambda function is deployed then the Lambda function sends a message to the "SQS" queue during invocation
    Given qid not in queue_status
    Given an "SQS" queue has been created
    Given a Lambda function has been deployed
    When the Lambda function sends a message to the "SQS" queue during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda function is invoked then the Lambda invocation completes successfully
    Given qid not in queue_status
    Given an "SQS" queue has been created
    Given the Lambda function has been invoked
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda function sends a message to the "SQS" queue during invocation then the Lambda invocation fails
    Given qid not in queue_status
    Given an "SQS" queue has been created
    Given the Lambda function has sent a message to the "SQS" queue during invocation
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda invocation completes successfully then a Lambda function is deployed
    Given qid not in queue_status
    Given an "SQS" queue has been created
    Given the Lambda invocation has completed successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda invocation fails then the Lambda function is invoked
    Given qid not in queue_status
    Given an "SQS" queue has been created
    Given the Lambda invocation has failed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Lambda function has been deployed
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an "SQS" queue is created then the Lambda invocation fails
    Given fid in func_status
    Given the Lambda function has been invoked
    Given an "SQS" queue has been created
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function sends a message to the "SQS" queue during invocation then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has sent a message to the "SQS" queue during invocation
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully then an "SQS" queue is created
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda invocation has completed successfully
    When an "SQS" queue is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails then the Lambda function sends a message to the "SQS" queue during invocation
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda invocation has failed
    When the Lambda function sends a message to the "SQS" queue during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation then a Lambda function is deployed then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda function has sent a message to the "SQS" queue during invocation
    Given a Lambda function has been deployed
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation then an "SQS" queue is created then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has sent a message to the "SQS" queue during invocation
    Given an "SQS" queue has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation then the Lambda function is invoked then an "SQS" queue is created
    Given iid in inv_status
    Given the Lambda function has sent a message to the "SQS" queue during invocation
    Given the Lambda function has been invoked
    When an "SQS" queue is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation then the Lambda invocation completes successfully then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has sent a message to the "SQS" queue during invocation
    Given the Lambda invocation has completed successfully
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation then the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda function has sent a message to the "SQS" queue during invocation
    Given the Lambda invocation has failed
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed then an "SQS" queue is created
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given a Lambda function has been deployed
    When an "SQS" queue is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an "SQS" queue is created then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given an "SQS" queue has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked then the Lambda function sends a message to the "SQS" queue during invocation
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given the Lambda function has been invoked
    When the Lambda function sends a message to the "SQS" queue during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function sends a message to the "SQS" queue during invocation then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given the Lambda function has sent a message to the "SQS" queue during invocation
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given the Lambda invocation has failed
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an "SQS" queue is created then the Lambda function sends a message to the "SQS" queue during invocation
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given an "SQS" queue has been created
    When the Lambda function sends a message to the "SQS" queue during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given the Lambda function has been invoked
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function sends a message to the "SQS" queue during invocation then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given the Lambda function has sent a message to the "SQS" queue during invocation
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then an "SQS" queue is created
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given the Lambda invocation has completed successfully
    When an "SQS" queue is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
