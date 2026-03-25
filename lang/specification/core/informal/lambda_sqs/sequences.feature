@lambdasqs @generated
Feature: LambdaSqs - Action Sequences

  # Generated from FizzBee spec: lambda_sqs.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, MessagesReferenceActiveQueues, ESMReferencesActiveQueue

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the "SQS" queue is configured with a dead-letter queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When the "SQS" queue is configured with a dead-letter queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a message arrives in the "SQS" queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When a message arrives in the "SQS" queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a Lambda function is deployed
    Given qid not in queue_status
    When an "SQS" queue is created
    When a Lambda function is deployed
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a Lambda event source mapping is created linking a queue to a function
    Given qid not in queue_status
    When an "SQS" queue is created
    When a Lambda event source mapping is created linking a queue to a function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the event source mapping polls the queue and invokes the Lambda function
    Given qid not in queue_status
    When an "SQS" queue is created
    When the event source mapping polls the queue and invokes the Lambda function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda invocation completes successfully
    Given qid not in queue_status
    When an "SQS" queue is created
    When the Lambda invocation completes successfully
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda invocation fails
    Given qid not in queue_status
    When an "SQS" queue is created
    When the Lambda invocation fails
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then an "SQS" queue is created
    Given qid in queue_status
    When the "SQS" queue is configured with a dead-letter queue
    When an "SQS" queue is created
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then a message arrives in the "SQS" queue
    Given qid in queue_status
    When the "SQS" queue is configured with a dead-letter queue
    When a message arrives in the "SQS" queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then a Lambda function is deployed
    Given qid in queue_status
    When the "SQS" queue is configured with a dead-letter queue
    When a Lambda function is deployed
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then a Lambda event source mapping is created linking a queue to a function
    Given qid in queue_status
    When the "SQS" queue is configured with a dead-letter queue
    When a Lambda event source mapping is created linking a queue to a function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then the event source mapping polls the queue and invokes the Lambda function
    Given qid in queue_status
    When the "SQS" queue is configured with a dead-letter queue
    When the event source mapping polls the queue and invokes the Lambda function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then the Lambda invocation completes successfully
    Given qid in queue_status
    When the "SQS" queue is configured with a dead-letter queue
    When the Lambda invocation completes successfully
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then the Lambda invocation fails
    Given qid in queue_status
    When the "SQS" queue is configured with a dead-letter queue
    When the Lambda invocation fails
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then an "SQS" queue is created
    Given qid in queue_status
    When a message arrives in the "SQS" queue
    When an "SQS" queue is created
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then the "SQS" queue is configured with a dead-letter queue
    Given qid in queue_status
    When a message arrives in the "SQS" queue
    When the "SQS" queue is configured with a dead-letter queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then a Lambda function is deployed
    Given qid in queue_status
    When a message arrives in the "SQS" queue
    When a Lambda function is deployed
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then a Lambda event source mapping is created linking a queue to a function
    Given qid in queue_status
    When a message arrives in the "SQS" queue
    When a Lambda event source mapping is created linking a queue to a function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then the event source mapping polls the queue and invokes the Lambda function
    Given qid in queue_status
    When a message arrives in the "SQS" queue
    When the event source mapping polls the queue and invokes the Lambda function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then the Lambda invocation completes successfully
    Given qid in queue_status
    When a message arrives in the "SQS" queue
    When the Lambda invocation completes successfully
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then the Lambda invocation fails
    Given qid in queue_status
    When a message arrives in the "SQS" queue
    When the Lambda invocation fails
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "SQS" queue is created
    Given fid not in func_status
    When a Lambda function is deployed
    When an "SQS" queue is created
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the "SQS" queue is configured with a dead-letter queue
    Given fid not in func_status
    When a Lambda function is deployed
    When the "SQS" queue is configured with a dead-letter queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a message arrives in the "SQS" queue
    Given fid not in func_status
    When a Lambda function is deployed
    When a message arrives in the "SQS" queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Lambda event source mapping is created linking a queue to a function
    Given fid not in func_status
    When a Lambda function is deployed
    When a Lambda event source mapping is created linking a queue to a function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the event source mapping polls the queue and invokes the Lambda function
    Given fid not in func_status
    When a Lambda function is deployed
    When the event source mapping polls the queue and invokes the Lambda function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then an "SQS" queue is created
    Given eid not in esm_status
    When a Lambda event source mapping is created linking a queue to a function
    When an "SQS" queue is created
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then the "SQS" queue is configured with a dead-letter queue
    Given eid not in esm_status
    When a Lambda event source mapping is created linking a queue to a function
    When the "SQS" queue is configured with a dead-letter queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then a message arrives in the "SQS" queue
    Given eid not in esm_status
    When a Lambda event source mapping is created linking a queue to a function
    When a message arrives in the "SQS" queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then a Lambda function is deployed
    Given eid not in esm_status
    When a Lambda event source mapping is created linking a queue to a function
    When a Lambda function is deployed
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then the event source mapping polls the queue and invokes the Lambda function
    Given eid not in esm_status
    When a Lambda event source mapping is created linking a queue to a function
    When the event source mapping polls the queue and invokes the Lambda function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then the Lambda invocation completes successfully
    Given eid not in esm_status
    When a Lambda event source mapping is created linking a queue to a function
    When the Lambda invocation completes successfully
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then the Lambda invocation fails
    Given eid not in esm_status
    When a Lambda event source mapping is created linking a queue to a function
    When the Lambda invocation fails
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then an "SQS" queue is created
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the Lambda function
    When an "SQS" queue is created
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then the "SQS" queue is configured with a dead-letter queue
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the Lambda function
    When the "SQS" queue is configured with a dead-letter queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then a message arrives in the "SQS" queue
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the Lambda function
    When a message arrives in the "SQS" queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then a Lambda function is deployed
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the Lambda function
    When a Lambda function is deployed
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then a Lambda event source mapping is created linking a queue to a function
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the Lambda function
    When a Lambda event source mapping is created linking a queue to a function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then the Lambda invocation completes successfully
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the Lambda function
    When the Lambda invocation completes successfully
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then the Lambda invocation fails
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the Lambda function
    When the Lambda invocation fails
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an "SQS" queue is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an "SQS" queue is created
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the "SQS" queue is configured with a dead-letter queue
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the "SQS" queue is configured with a dead-letter queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a message arrives in the "SQS" queue
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a message arrives in the "SQS" queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda event source mapping is created linking a queue to a function
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda event source mapping is created linking a queue to a function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the event source mapping polls the queue and invokes the Lambda function
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the event source mapping polls the queue and invokes the Lambda function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an "SQS" queue is created
    Given iid in inv_status
    When the Lambda invocation fails
    When an "SQS" queue is created
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the "SQS" queue is configured with a dead-letter queue
    Given iid in inv_status
    When the Lambda invocation fails
    When the "SQS" queue is configured with a dead-letter queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a message arrives in the "SQS" queue
    Given iid in inv_status
    When the Lambda invocation fails
    When a message arrives in the "SQS" queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function is deployed
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda event source mapping is created linking a queue to a function
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda event source mapping is created linking a queue to a function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the event source mapping polls the queue and invokes the Lambda function
    Given iid in inv_status
    When the Lambda invocation fails
    When the event source mapping polls the queue and invokes the Lambda function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the "SQS" queue is configured with a dead-letter queue then a message arrives in the "SQS" queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When the "SQS" queue is configured with a dead-letter queue
    When a message arrives in the "SQS" queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a message arrives in the "SQS" queue then a Lambda function is deployed
    Given qid not in queue_status
    When an "SQS" queue is created
    When a message arrives in the "SQS" queue
    When a Lambda function is deployed
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a Lambda function is deployed then a Lambda event source mapping is created linking a queue to a function
    Given qid not in queue_status
    When an "SQS" queue is created
    When a Lambda function is deployed
    When a Lambda event source mapping is created linking a queue to a function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a Lambda event source mapping is created linking a queue to a function then the event source mapping polls the queue and invokes the Lambda function
    Given qid not in queue_status
    When an "SQS" queue is created
    When a Lambda event source mapping is created linking a queue to a function
    When the event source mapping polls the queue and invokes the Lambda function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the event source mapping polls the queue and invokes the Lambda function then the Lambda invocation completes successfully
    Given qid not in queue_status
    When an "SQS" queue is created
    When the event source mapping polls the queue and invokes the Lambda function
    When the Lambda invocation completes successfully
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda invocation completes successfully then the Lambda invocation fails
    Given qid not in queue_status
    When an "SQS" queue is created
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda invocation fails then the "SQS" queue is configured with a dead-letter queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When the Lambda invocation fails
    When the "SQS" queue is configured with a dead-letter queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then an "SQS" queue is created then a Lambda function is deployed
    Given qid in queue_status
    When the "SQS" queue is configured with a dead-letter queue
    When an "SQS" queue is created
    When a Lambda function is deployed
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then a message arrives in the "SQS" queue then a Lambda event source mapping is created linking a queue to a function
    Given qid in queue_status
    When the "SQS" queue is configured with a dead-letter queue
    When a message arrives in the "SQS" queue
    When a Lambda event source mapping is created linking a queue to a function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then a Lambda function is deployed then the event source mapping polls the queue and invokes the Lambda function
    Given qid in queue_status
    When the "SQS" queue is configured with a dead-letter queue
    When a Lambda function is deployed
    When the event source mapping polls the queue and invokes the Lambda function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then a Lambda event source mapping is created linking a queue to a function then the Lambda invocation completes successfully
    Given qid in queue_status
    When the "SQS" queue is configured with a dead-letter queue
    When a Lambda event source mapping is created linking a queue to a function
    When the Lambda invocation completes successfully
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then the event source mapping polls the queue and invokes the Lambda function then the Lambda invocation fails
    Given qid in queue_status
    When the "SQS" queue is configured with a dead-letter queue
    When the event source mapping polls the queue and invokes the Lambda function
    When the Lambda invocation fails
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then the Lambda invocation completes successfully then an "SQS" queue is created
    Given qid in queue_status
    When the "SQS" queue is configured with a dead-letter queue
    When the Lambda invocation completes successfully
    When an "SQS" queue is created
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then the Lambda invocation fails then a message arrives in the "SQS" queue
    Given qid in queue_status
    When the "SQS" queue is configured with a dead-letter queue
    When the Lambda invocation fails
    When a message arrives in the "SQS" queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then an "SQS" queue is created then a Lambda event source mapping is created linking a queue to a function
    Given qid in queue_status
    When a message arrives in the "SQS" queue
    When an "SQS" queue is created
    When a Lambda event source mapping is created linking a queue to a function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then the "SQS" queue is configured with a dead-letter queue then the event source mapping polls the queue and invokes the Lambda function
    Given qid in queue_status
    When a message arrives in the "SQS" queue
    When the "SQS" queue is configured with a dead-letter queue
    When the event source mapping polls the queue and invokes the Lambda function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then a Lambda function is deployed then the Lambda invocation completes successfully
    Given qid in queue_status
    When a message arrives in the "SQS" queue
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then a Lambda event source mapping is created linking a queue to a function then the Lambda invocation fails
    Given qid in queue_status
    When a message arrives in the "SQS" queue
    When a Lambda event source mapping is created linking a queue to a function
    When the Lambda invocation fails
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then the event source mapping polls the queue and invokes the Lambda function then an "SQS" queue is created
    Given qid in queue_status
    When a message arrives in the "SQS" queue
    When the event source mapping polls the queue and invokes the Lambda function
    When an "SQS" queue is created
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then the Lambda invocation completes successfully then the "SQS" queue is configured with a dead-letter queue
    Given qid in queue_status
    When a message arrives in the "SQS" queue
    When the Lambda invocation completes successfully
    When the "SQS" queue is configured with a dead-letter queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then the Lambda invocation fails then a Lambda function is deployed
    Given qid in queue_status
    When a message arrives in the "SQS" queue
    When the Lambda invocation fails
    When a Lambda function is deployed
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "SQS" queue is created then the event source mapping polls the queue and invokes the Lambda function
    Given fid not in func_status
    When a Lambda function is deployed
    When an "SQS" queue is created
    When the event source mapping polls the queue and invokes the Lambda function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the "SQS" queue is configured with a dead-letter queue then the Lambda invocation completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the "SQS" queue is configured with a dead-letter queue
    When the Lambda invocation completes successfully
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a message arrives in the "SQS" queue then the Lambda invocation fails
    Given fid not in func_status
    When a Lambda function is deployed
    When a message arrives in the "SQS" queue
    When the Lambda invocation fails
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Lambda event source mapping is created linking a queue to a function then an "SQS" queue is created
    Given fid not in func_status
    When a Lambda function is deployed
    When a Lambda event source mapping is created linking a queue to a function
    When an "SQS" queue is created
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the event source mapping polls the queue and invokes the Lambda function then the "SQS" queue is configured with a dead-letter queue
    Given fid not in func_status
    When a Lambda function is deployed
    When the event source mapping polls the queue and invokes the Lambda function
    When the "SQS" queue is configured with a dead-letter queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully then a message arrives in the "SQS" queue
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    When a message arrives in the "SQS" queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails then a Lambda event source mapping is created linking a queue to a function
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails
    When a Lambda event source mapping is created linking a queue to a function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then an "SQS" queue is created then the Lambda invocation completes successfully
    Given eid not in esm_status
    When a Lambda event source mapping is created linking a queue to a function
    When an "SQS" queue is created
    When the Lambda invocation completes successfully
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then the "SQS" queue is configured with a dead-letter queue then the Lambda invocation fails
    Given eid not in esm_status
    When a Lambda event source mapping is created linking a queue to a function
    When the "SQS" queue is configured with a dead-letter queue
    When the Lambda invocation fails
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then a message arrives in the "SQS" queue then an "SQS" queue is created
    Given eid not in esm_status
    When a Lambda event source mapping is created linking a queue to a function
    When a message arrives in the "SQS" queue
    When an "SQS" queue is created
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then a Lambda function is deployed then the "SQS" queue is configured with a dead-letter queue
    Given eid not in esm_status
    When a Lambda event source mapping is created linking a queue to a function
    When a Lambda function is deployed
    When the "SQS" queue is configured with a dead-letter queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then the event source mapping polls the queue and invokes the Lambda function then a message arrives in the "SQS" queue
    Given eid not in esm_status
    When a Lambda event source mapping is created linking a queue to a function
    When the event source mapping polls the queue and invokes the Lambda function
    When a message arrives in the "SQS" queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then the Lambda invocation completes successfully then a Lambda function is deployed
    Given eid not in esm_status
    When a Lambda event source mapping is created linking a queue to a function
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then the Lambda invocation fails then the event source mapping polls the queue and invokes the Lambda function
    Given eid not in esm_status
    When a Lambda event source mapping is created linking a queue to a function
    When the Lambda invocation fails
    When the event source mapping polls the queue and invokes the Lambda function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then an "SQS" queue is created then the Lambda invocation fails
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the Lambda function
    When an "SQS" queue is created
    When the Lambda invocation fails
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then the "SQS" queue is configured with a dead-letter queue then an "SQS" queue is created
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the Lambda function
    When the "SQS" queue is configured with a dead-letter queue
    When an "SQS" queue is created
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then a message arrives in the "SQS" queue then the "SQS" queue is configured with a dead-letter queue
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the Lambda function
    When a message arrives in the "SQS" queue
    When the "SQS" queue is configured with a dead-letter queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then a Lambda function is deployed then a message arrives in the "SQS" queue
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the Lambda function
    When a Lambda function is deployed
    When a message arrives in the "SQS" queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then a Lambda event source mapping is created linking a queue to a function then a Lambda function is deployed
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the Lambda function
    When a Lambda event source mapping is created linking a queue to a function
    When a Lambda function is deployed
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then the Lambda invocation completes successfully then a Lambda event source mapping is created linking a queue to a function
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the Lambda function
    When the Lambda invocation completes successfully
    When a Lambda event source mapping is created linking a queue to a function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then the Lambda invocation fails then the Lambda invocation completes successfully
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the Lambda function
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an "SQS" queue is created then the "SQS" queue is configured with a dead-letter queue
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an "SQS" queue is created
    When the "SQS" queue is configured with a dead-letter queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the "SQS" queue is configured with a dead-letter queue then a message arrives in the "SQS" queue
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the "SQS" queue is configured with a dead-letter queue
    When a message arrives in the "SQS" queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a message arrives in the "SQS" queue then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a message arrives in the "SQS" queue
    When a Lambda function is deployed
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed then a Lambda event source mapping is created linking a queue to a function
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    When a Lambda event source mapping is created linking a queue to a function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda event source mapping is created linking a queue to a function then the event source mapping polls the queue and invokes the Lambda function
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda event source mapping is created linking a queue to a function
    When the event source mapping polls the queue and invokes the Lambda function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the event source mapping polls the queue and invokes the Lambda function then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the event source mapping polls the queue and invokes the Lambda function
    When the Lambda invocation fails
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then an "SQS" queue is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    When an "SQS" queue is created
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an "SQS" queue is created then a message arrives in the "SQS" queue
    Given iid in inv_status
    When the Lambda invocation fails
    When an "SQS" queue is created
    When a message arrives in the "SQS" queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the "SQS" queue is configured with a dead-letter queue then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When the "SQS" queue is configured with a dead-letter queue
    When a Lambda function is deployed
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a message arrives in the "SQS" queue then a Lambda event source mapping is created linking a queue to a function
    Given iid in inv_status
    When the Lambda invocation fails
    When a message arrives in the "SQS" queue
    When a Lambda event source mapping is created linking a queue to a function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed then the event source mapping polls the queue and invokes the Lambda function
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function is deployed
    When the event source mapping polls the queue and invokes the Lambda function
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda event source mapping is created linking a queue to a function then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda event source mapping is created linking a queue to a function
    When the Lambda invocation completes successfully
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the event source mapping polls the queue and invokes the Lambda function then an "SQS" queue is created
    Given iid in inv_status
    When the Lambda invocation fails
    When the event source mapping polls the queue and invokes the Lambda function
    When an "SQS" queue is created
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then the "SQS" queue is configured with a dead-letter queue
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    When the "SQS" queue is configured with a dead-letter queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue
