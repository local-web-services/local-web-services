@lambdasqs @generated
Feature: LambdaSqs - Action Sequences

  # Generated from FizzBee spec: lambda_sqs.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, MessagesReferenceActiveQueues, ESMReferencesActiveQueue

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the "SQS" queue is configured with a dead-letter queue
    Given qid not in queue_status
    Given an "SQS" queue has been created
    When the "SQS" queue is configured with a dead-letter queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a message arrives in the "SQS" queue
    Given qid not in queue_status
    Given an "SQS" queue has been created
    When a message arrives in the "SQS" queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a Lambda function is deployed
    Given qid not in queue_status
    Given an "SQS" queue has been created
    When a Lambda function is deployed
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a Lambda event source mapping is created linking a queue to a function
    Given qid not in queue_status
    Given an "SQS" queue has been created
    When a Lambda event source mapping is created linking a queue to a function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the event source mapping polls the queue and invokes the Lambda function
    Given qid not in queue_status
    Given an "SQS" queue has been created
    When the event source mapping polls the queue and invokes the Lambda function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda invocation completes successfully
    Given qid not in queue_status
    Given an "SQS" queue has been created
    When the Lambda invocation completes successfully
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda invocation fails
    Given qid not in queue_status
    Given an "SQS" queue has been created
    When the Lambda invocation fails
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then an "SQS" queue is created
    Given qid in queue_status
    Given the "SQS" queue has been configured with a dead-letter queue
    When an "SQS" queue is created
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then a message arrives in the "SQS" queue
    Given qid in queue_status
    Given the "SQS" queue has been configured with a dead-letter queue
    When a message arrives in the "SQS" queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then a Lambda function is deployed
    Given qid in queue_status
    Given the "SQS" queue has been configured with a dead-letter queue
    When a Lambda function is deployed
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then a Lambda event source mapping is created linking a queue to a function
    Given qid in queue_status
    Given the "SQS" queue has been configured with a dead-letter queue
    When a Lambda event source mapping is created linking a queue to a function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then the event source mapping polls the queue and invokes the Lambda function
    Given qid in queue_status
    Given the "SQS" queue has been configured with a dead-letter queue
    When the event source mapping polls the queue and invokes the Lambda function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then the Lambda invocation completes successfully
    Given qid in queue_status
    Given the "SQS" queue has been configured with a dead-letter queue
    When the Lambda invocation completes successfully
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then the Lambda invocation fails
    Given qid in queue_status
    Given the "SQS" queue has been configured with a dead-letter queue
    When the Lambda invocation fails
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then an "SQS" queue is created
    Given qid in queue_status
    Given a message has arrived in the "SQS" queue
    When an "SQS" queue is created
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then the "SQS" queue is configured with a dead-letter queue
    Given qid in queue_status
    Given a message has arrived in the "SQS" queue
    When the "SQS" queue is configured with a dead-letter queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then a Lambda function is deployed
    Given qid in queue_status
    Given a message has arrived in the "SQS" queue
    When a Lambda function is deployed
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then a Lambda event source mapping is created linking a queue to a function
    Given qid in queue_status
    Given a message has arrived in the "SQS" queue
    When a Lambda event source mapping is created linking a queue to a function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then the event source mapping polls the queue and invokes the Lambda function
    Given qid in queue_status
    Given a message has arrived in the "SQS" queue
    When the event source mapping polls the queue and invokes the Lambda function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then the Lambda invocation completes successfully
    Given qid in queue_status
    Given a message has arrived in the "SQS" queue
    When the Lambda invocation completes successfully
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then the Lambda invocation fails
    Given qid in queue_status
    Given a message has arrived in the "SQS" queue
    When the Lambda invocation fails
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "SQS" queue is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    When an "SQS" queue is created
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the "SQS" queue is configured with a dead-letter queue
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the "SQS" queue is configured with a dead-letter queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a message arrives in the "SQS" queue
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a message arrives in the "SQS" queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Lambda event source mapping is created linking a queue to a function
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a Lambda event source mapping is created linking a queue to a function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the event source mapping polls the queue and invokes the Lambda function
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the event source mapping polls the queue and invokes the Lambda function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda invocation completes successfully
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda invocation fails
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then an "SQS" queue is created
    Given eid not in esm_status
    Given a Lambda event source mapping has been created linking a queue to a function
    When an "SQS" queue is created
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then the "SQS" queue is configured with a dead-letter queue
    Given eid not in esm_status
    Given a Lambda event source mapping has been created linking a queue to a function
    When the "SQS" queue is configured with a dead-letter queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then a message arrives in the "SQS" queue
    Given eid not in esm_status
    Given a Lambda event source mapping has been created linking a queue to a function
    When a message arrives in the "SQS" queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then a Lambda function is deployed
    Given eid not in esm_status
    Given a Lambda event source mapping has been created linking a queue to a function
    When a Lambda function is deployed
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then the event source mapping polls the queue and invokes the Lambda function
    Given eid not in esm_status
    Given a Lambda event source mapping has been created linking a queue to a function
    When the event source mapping polls the queue and invokes the Lambda function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then the Lambda invocation completes successfully
    Given eid not in esm_status
    Given a Lambda event source mapping has been created linking a queue to a function
    When the Lambda invocation completes successfully
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then the Lambda invocation fails
    Given eid not in esm_status
    Given a Lambda event source mapping has been created linking a queue to a function
    When the Lambda invocation fails
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then an "SQS" queue is created
    Given eid in esm_status
    Given the event source mapping has polled the queue and invoked the Lambda function
    When an "SQS" queue is created
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then the "SQS" queue is configured with a dead-letter queue
    Given eid in esm_status
    Given the event source mapping has polled the queue and invoked the Lambda function
    When the "SQS" queue is configured with a dead-letter queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then a message arrives in the "SQS" queue
    Given eid in esm_status
    Given the event source mapping has polled the queue and invoked the Lambda function
    When a message arrives in the "SQS" queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then a Lambda function is deployed
    Given eid in esm_status
    Given the event source mapping has polled the queue and invoked the Lambda function
    When a Lambda function is deployed
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then a Lambda event source mapping is created linking a queue to a function
    Given eid in esm_status
    Given the event source mapping has polled the queue and invoked the Lambda function
    When a Lambda event source mapping is created linking a queue to a function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then the Lambda invocation completes successfully
    Given eid in esm_status
    Given the event source mapping has polled the queue and invoked the Lambda function
    When the Lambda invocation completes successfully
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then the Lambda invocation fails
    Given eid in esm_status
    Given the event source mapping has polled the queue and invoked the Lambda function
    When the Lambda invocation fails
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an "SQS" queue is created
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When an "SQS" queue is created
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the "SQS" queue is configured with a dead-letter queue
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When the "SQS" queue is configured with a dead-letter queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a message arrives in the "SQS" queue
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When a message arrives in the "SQS" queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When a Lambda function is deployed
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda event source mapping is created linking a queue to a function
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When a Lambda event source mapping is created linking a queue to a function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the event source mapping polls the queue and invokes the Lambda function
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When the event source mapping polls the queue and invokes the Lambda function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When the Lambda invocation fails
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an "SQS" queue is created
    Given iid in inv_status
    Given the Lambda invocation has failed
    When an "SQS" queue is created
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the "SQS" queue is configured with a dead-letter queue
    Given iid in inv_status
    Given the Lambda invocation has failed
    When the "SQS" queue is configured with a dead-letter queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a message arrives in the "SQS" queue
    Given iid in inv_status
    Given the Lambda invocation has failed
    When a message arrives in the "SQS" queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has failed
    When a Lambda function is deployed
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda event source mapping is created linking a queue to a function
    Given iid in inv_status
    Given the Lambda invocation has failed
    When a Lambda event source mapping is created linking a queue to a function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the event source mapping polls the queue and invokes the Lambda function
    Given iid in inv_status
    Given the Lambda invocation has failed
    When the event source mapping polls the queue and invokes the Lambda function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda invocation has failed
    When the Lambda invocation completes successfully
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the "SQS" queue is configured with a dead-letter queue then a message arrives in the "SQS" queue
    Given qid not in queue_status
    Given an "SQS" queue has been created
    Given the "SQS" queue has been configured with a dead-letter queue
    When a message arrives in the "SQS" queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a message arrives in the "SQS" queue then a Lambda function is deployed
    Given qid not in queue_status
    Given an "SQS" queue has been created
    Given a message has arrived in the "SQS" queue
    When a Lambda function is deployed
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a Lambda function is deployed then a Lambda event source mapping is created linking a queue to a function
    Given qid not in queue_status
    Given an "SQS" queue has been created
    Given a Lambda function has been deployed
    When a Lambda event source mapping is created linking a queue to a function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a Lambda event source mapping is created linking a queue to a function then the event source mapping polls the queue and invokes the Lambda function
    Given qid not in queue_status
    Given an "SQS" queue has been created
    Given a Lambda event source mapping has been created linking a queue to a function
    When the event source mapping polls the queue and invokes the Lambda function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the event source mapping polls the queue and invokes the Lambda function then the Lambda invocation completes successfully
    Given qid not in queue_status
    Given an "SQS" queue has been created
    Given the event source mapping has polled the queue and invoked the Lambda function
    When the Lambda invocation completes successfully
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda invocation completes successfully then the Lambda invocation fails
    Given qid not in queue_status
    Given an "SQS" queue has been created
    Given the Lambda invocation has completed successfully
    When the Lambda invocation fails
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the Lambda invocation fails then the "SQS" queue is configured with a dead-letter queue
    Given qid not in queue_status
    Given an "SQS" queue has been created
    Given the Lambda invocation has failed
    When the "SQS" queue is configured with a dead-letter queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then an "SQS" queue is created then a Lambda function is deployed
    Given qid in queue_status
    Given the "SQS" queue has been configured with a dead-letter queue
    Given an "SQS" queue has been created
    When a Lambda function is deployed
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then a message arrives in the "SQS" queue then a Lambda event source mapping is created linking a queue to a function
    Given qid in queue_status
    Given the "SQS" queue has been configured with a dead-letter queue
    Given a message has arrived in the "SQS" queue
    When a Lambda event source mapping is created linking a queue to a function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then a Lambda function is deployed then the event source mapping polls the queue and invokes the Lambda function
    Given qid in queue_status
    Given the "SQS" queue has been configured with a dead-letter queue
    Given a Lambda function has been deployed
    When the event source mapping polls the queue and invokes the Lambda function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then a Lambda event source mapping is created linking a queue to a function then the Lambda invocation completes successfully
    Given qid in queue_status
    Given the "SQS" queue has been configured with a dead-letter queue
    Given a Lambda event source mapping has been created linking a queue to a function
    When the Lambda invocation completes successfully
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then the event source mapping polls the queue and invokes the Lambda function then the Lambda invocation fails
    Given qid in queue_status
    Given the "SQS" queue has been configured with a dead-letter queue
    Given the event source mapping has polled the queue and invoked the Lambda function
    When the Lambda invocation fails
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then the Lambda invocation completes successfully then an "SQS" queue is created
    Given qid in queue_status
    Given the "SQS" queue has been configured with a dead-letter queue
    Given the Lambda invocation has completed successfully
    When an "SQS" queue is created
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "SQS" queue is configured with a dead-letter queue then the Lambda invocation fails then a message arrives in the "SQS" queue
    Given qid in queue_status
    Given the "SQS" queue has been configured with a dead-letter queue
    Given the Lambda invocation has failed
    When a message arrives in the "SQS" queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then an "SQS" queue is created then a Lambda event source mapping is created linking a queue to a function
    Given qid in queue_status
    Given a message has arrived in the "SQS" queue
    Given an "SQS" queue has been created
    When a Lambda event source mapping is created linking a queue to a function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then the "SQS" queue is configured with a dead-letter queue then the event source mapping polls the queue and invokes the Lambda function
    Given qid in queue_status
    Given a message has arrived in the "SQS" queue
    Given the "SQS" queue has been configured with a dead-letter queue
    When the event source mapping polls the queue and invokes the Lambda function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then a Lambda function is deployed then the Lambda invocation completes successfully
    Given qid in queue_status
    Given a message has arrived in the "SQS" queue
    Given a Lambda function has been deployed
    When the Lambda invocation completes successfully
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then a Lambda event source mapping is created linking a queue to a function then the Lambda invocation fails
    Given qid in queue_status
    Given a message has arrived in the "SQS" queue
    Given a Lambda event source mapping has been created linking a queue to a function
    When the Lambda invocation fails
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then the event source mapping polls the queue and invokes the Lambda function then an "SQS" queue is created
    Given qid in queue_status
    Given a message has arrived in the "SQS" queue
    Given the event source mapping has polled the queue and invoked the Lambda function
    When an "SQS" queue is created
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then the Lambda invocation completes successfully then the "SQS" queue is configured with a dead-letter queue
    Given qid in queue_status
    Given a message has arrived in the "SQS" queue
    Given the Lambda invocation has completed successfully
    When the "SQS" queue is configured with a dead-letter queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a message arrives in the "SQS" queue then the Lambda invocation fails then a Lambda function is deployed
    Given qid in queue_status
    Given a message has arrived in the "SQS" queue
    Given the Lambda invocation has failed
    When a Lambda function is deployed
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "SQS" queue is created then the event source mapping polls the queue and invokes the Lambda function
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given an "SQS" queue has been created
    When the event source mapping polls the queue and invokes the Lambda function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the "SQS" queue is configured with a dead-letter queue then the Lambda invocation completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the "SQS" queue has been configured with a dead-letter queue
    When the Lambda invocation completes successfully
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a message arrives in the "SQS" queue then the Lambda invocation fails
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a message has arrived in the "SQS" queue
    When the Lambda invocation fails
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Lambda event source mapping is created linking a queue to a function then an "SQS" queue is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a Lambda event source mapping has been created linking a queue to a function
    When an "SQS" queue is created
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the event source mapping polls the queue and invokes the Lambda function then the "SQS" queue is configured with a dead-letter queue
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the event source mapping has polled the queue and invoked the Lambda function
    When the "SQS" queue is configured with a dead-letter queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully then a message arrives in the "SQS" queue
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda invocation has completed successfully
    When a message arrives in the "SQS" queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails then a Lambda event source mapping is created linking a queue to a function
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda invocation has failed
    When a Lambda event source mapping is created linking a queue to a function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then an "SQS" queue is created then the Lambda invocation completes successfully
    Given eid not in esm_status
    Given a Lambda event source mapping has been created linking a queue to a function
    Given an "SQS" queue has been created
    When the Lambda invocation completes successfully
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then the "SQS" queue is configured with a dead-letter queue then the Lambda invocation fails
    Given eid not in esm_status
    Given a Lambda event source mapping has been created linking a queue to a function
    Given the "SQS" queue has been configured with a dead-letter queue
    When the Lambda invocation fails
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then a message arrives in the "SQS" queue then an "SQS" queue is created
    Given eid not in esm_status
    Given a Lambda event source mapping has been created linking a queue to a function
    Given a message has arrived in the "SQS" queue
    When an "SQS" queue is created
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then a Lambda function is deployed then the "SQS" queue is configured with a dead-letter queue
    Given eid not in esm_status
    Given a Lambda event source mapping has been created linking a queue to a function
    Given a Lambda function has been deployed
    When the "SQS" queue is configured with a dead-letter queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then the event source mapping polls the queue and invokes the Lambda function then a message arrives in the "SQS" queue
    Given eid not in esm_status
    Given a Lambda event source mapping has been created linking a queue to a function
    Given the event source mapping has polled the queue and invoked the Lambda function
    When a message arrives in the "SQS" queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then the Lambda invocation completes successfully then a Lambda function is deployed
    Given eid not in esm_status
    Given a Lambda event source mapping has been created linking a queue to a function
    Given the Lambda invocation has completed successfully
    When a Lambda function is deployed
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Lambda event source mapping is created linking a queue to a function then the Lambda invocation fails then the event source mapping polls the queue and invokes the Lambda function
    Given eid not in esm_status
    Given a Lambda event source mapping has been created linking a queue to a function
    Given the Lambda invocation has failed
    When the event source mapping polls the queue and invokes the Lambda function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then an "SQS" queue is created then the Lambda invocation fails
    Given eid in esm_status
    Given the event source mapping has polled the queue and invoked the Lambda function
    Given an "SQS" queue has been created
    When the Lambda invocation fails
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then the "SQS" queue is configured with a dead-letter queue then an "SQS" queue is created
    Given eid in esm_status
    Given the event source mapping has polled the queue and invoked the Lambda function
    Given the "SQS" queue has been configured with a dead-letter queue
    When an "SQS" queue is created
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then a message arrives in the "SQS" queue then the "SQS" queue is configured with a dead-letter queue
    Given eid in esm_status
    Given the event source mapping has polled the queue and invoked the Lambda function
    Given a message has arrived in the "SQS" queue
    When the "SQS" queue is configured with a dead-letter queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then a Lambda function is deployed then a message arrives in the "SQS" queue
    Given eid in esm_status
    Given the event source mapping has polled the queue and invoked the Lambda function
    Given a Lambda function has been deployed
    When a message arrives in the "SQS" queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then a Lambda event source mapping is created linking a queue to a function then a Lambda function is deployed
    Given eid in esm_status
    Given the event source mapping has polled the queue and invoked the Lambda function
    Given a Lambda event source mapping has been created linking a queue to a function
    When a Lambda function is deployed
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then the Lambda invocation completes successfully then a Lambda event source mapping is created linking a queue to a function
    Given eid in esm_status
    Given the event source mapping has polled the queue and invoked the Lambda function
    Given the Lambda invocation has completed successfully
    When a Lambda event source mapping is created linking a queue to a function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the event source mapping polls the queue and invokes the Lambda function then the Lambda invocation fails then the Lambda invocation completes successfully
    Given eid in esm_status
    Given the event source mapping has polled the queue and invoked the Lambda function
    Given the Lambda invocation has failed
    When the Lambda invocation completes successfully
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an "SQS" queue is created then the "SQS" queue is configured with a dead-letter queue
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given an "SQS" queue has been created
    When the "SQS" queue is configured with a dead-letter queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the "SQS" queue is configured with a dead-letter queue then a message arrives in the "SQS" queue
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given the "SQS" queue has been configured with a dead-letter queue
    When a message arrives in the "SQS" queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a message arrives in the "SQS" queue then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given a message has arrived in the "SQS" queue
    When a Lambda function is deployed
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed then a Lambda event source mapping is created linking a queue to a function
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given a Lambda function has been deployed
    When a Lambda event source mapping is created linking a queue to a function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda event source mapping is created linking a queue to a function then the event source mapping polls the queue and invokes the Lambda function
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given a Lambda event source mapping has been created linking a queue to a function
    When the event source mapping polls the queue and invokes the Lambda function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the event source mapping polls the queue and invokes the Lambda function then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given the event source mapping has polled the queue and invoked the Lambda function
    When the Lambda invocation fails
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then an "SQS" queue is created
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given the Lambda invocation has failed
    When an "SQS" queue is created
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an "SQS" queue is created then a message arrives in the "SQS" queue
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given an "SQS" queue has been created
    When a message arrives in the "SQS" queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the "SQS" queue is configured with a dead-letter queue then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given the "SQS" queue has been configured with a dead-letter queue
    When a Lambda function is deployed
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a message arrives in the "SQS" queue then a Lambda event source mapping is created linking a queue to a function
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given a message has arrived in the "SQS" queue
    When a Lambda event source mapping is created linking a queue to a function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed then the event source mapping polls the queue and invokes the Lambda function
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given a Lambda function has been deployed
    When the event source mapping polls the queue and invokes the Lambda function
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda event source mapping is created linking a queue to a function then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given a Lambda event source mapping has been created linking a queue to a function
    When the Lambda invocation completes successfully
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the event source mapping polls the queue and invokes the Lambda function then an "SQS" queue is created
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given the event source mapping has polled the queue and invoked the Lambda function
    When an "SQS" queue is created
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then the "SQS" queue is configured with a dead-letter queue
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given the Lambda invocation has completed successfully
    When the "SQS" queue is configured with a dead-letter queue
    Then every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue
