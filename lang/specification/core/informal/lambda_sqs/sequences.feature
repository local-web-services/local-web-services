@lambdasqs @generated
Feature: LambdaSqs - Action Sequences

  # Generated from FizzBee spec: lambda_sqs.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, MessagesReferenceActiveQueues, ESMReferencesActiveQueue

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "sqs" "queue" is created then the "sqs" "queue" is configured with a dead-letter queue
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When the "sqs" "queue" is configured with a dead-letter queue
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then a message arrives in the "sqs" "queue"
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a message arrives in the "sqs" "queue"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then a "lambda" "function" is deployed
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then a "lambda" "event source mapping" is created linking a queue to a function
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a "lambda" "event source mapping" is created linking a queue to a function
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then the event source mapping polls the queue and invokes the "lambda" "function"
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When the event source mapping polls the queue and invokes the "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then the "lambda" "function" invocation completes successfully
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then the "lambda" "function" invocation fails
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "sqs" "queue" is configured with a dead-letter queue then a "sqs" "queue" is created
    Given qid in queue_status
    When the "sqs" "queue" is configured with a dead-letter queue
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "sqs" "queue" is configured with a dead-letter queue then a message arrives in the "sqs" "queue"
    Given qid in queue_status
    When the "sqs" "queue" is configured with a dead-letter queue
    When a message arrives in the "sqs" "queue"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "sqs" "queue" is configured with a dead-letter queue then a "lambda" "function" is deployed
    Given qid in queue_status
    When the "sqs" "queue" is configured with a dead-letter queue
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "sqs" "queue" is configured with a dead-letter queue then a "lambda" "event source mapping" is created linking a queue to a function
    Given qid in queue_status
    When the "sqs" "queue" is configured with a dead-letter queue
    When a "lambda" "event source mapping" is created linking a queue to a function
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "sqs" "queue" is configured with a dead-letter queue then the event source mapping polls the queue and invokes the "lambda" "function"
    Given qid in queue_status
    When the "sqs" "queue" is configured with a dead-letter queue
    When the event source mapping polls the queue and invokes the "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "sqs" "queue" is configured with a dead-letter queue then the "lambda" "function" invocation completes successfully
    Given qid in queue_status
    When the "sqs" "queue" is configured with a dead-letter queue
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "sqs" "queue" is configured with a dead-letter queue then the "lambda" "function" invocation fails
    Given qid in queue_status
    When the "sqs" "queue" is configured with a dead-letter queue
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a message arrives in the "sqs" "queue" then a "sqs" "queue" is created
    Given qid in queue_status
    When a message arrives in the "sqs" "queue"
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a message arrives in the "sqs" "queue" then the "sqs" "queue" is configured with a dead-letter queue
    Given qid in queue_status
    When a message arrives in the "sqs" "queue"
    When the "sqs" "queue" is configured with a dead-letter queue
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a message arrives in the "sqs" "queue" then a "lambda" "function" is deployed
    Given qid in queue_status
    When a message arrives in the "sqs" "queue"
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a message arrives in the "sqs" "queue" then a "lambda" "event source mapping" is created linking a queue to a function
    Given qid in queue_status
    When a message arrives in the "sqs" "queue"
    When a "lambda" "event source mapping" is created linking a queue to a function
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a message arrives in the "sqs" "queue" then the event source mapping polls the queue and invokes the "lambda" "function"
    Given qid in queue_status
    When a message arrives in the "sqs" "queue"
    When the event source mapping polls the queue and invokes the "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a message arrives in the "sqs" "queue" then the "lambda" "function" invocation completes successfully
    Given qid in queue_status
    When a message arrives in the "sqs" "queue"
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a message arrives in the "sqs" "queue" then the "lambda" "function" invocation fails
    Given qid in queue_status
    When a message arrives in the "sqs" "queue"
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "function" is deployed then a "sqs" "queue" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "sqs" "queue" is configured with a dead-letter queue
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "sqs" "queue" is configured with a dead-letter queue
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "function" is deployed then a message arrives in the "sqs" "queue"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a message arrives in the "sqs" "queue"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "function" is deployed then a "lambda" "event source mapping" is created linking a queue to a function
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "lambda" "event source mapping" is created linking a queue to a function
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "function" is deployed then the event source mapping polls the queue and invokes the "lambda" "function"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the event source mapping polls the queue and invokes the "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "event source mapping" is created linking a queue to a function then a "sqs" "queue" is created
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created linking a queue to a function
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "event source mapping" is created linking a queue to a function then the "sqs" "queue" is configured with a dead-letter queue
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created linking a queue to a function
    When the "sqs" "queue" is configured with a dead-letter queue
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "event source mapping" is created linking a queue to a function then a message arrives in the "sqs" "queue"
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created linking a queue to a function
    When a message arrives in the "sqs" "queue"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "event source mapping" is created linking a queue to a function then a "lambda" "function" is deployed
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created linking a queue to a function
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "event source mapping" is created linking a queue to a function then the event source mapping polls the queue and invokes the "lambda" "function"
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created linking a queue to a function
    When the event source mapping polls the queue and invokes the "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "event source mapping" is created linking a queue to a function then the "lambda" "function" invocation completes successfully
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created linking a queue to a function
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "event source mapping" is created linking a queue to a function then the "lambda" "function" invocation fails
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created linking a queue to a function
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" then a "sqs" "queue" is created
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the "lambda" "function"
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" then the "sqs" "queue" is configured with a dead-letter queue
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the "lambda" "function"
    When the "sqs" "queue" is configured with a dead-letter queue
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" then a message arrives in the "sqs" "queue"
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the "lambda" "function"
    When a message arrives in the "sqs" "queue"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" then a "lambda" "function" is deployed
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the "lambda" "function"
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" then a "lambda" "event source mapping" is created linking a queue to a function
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the "lambda" "function"
    When a "lambda" "event source mapping" is created linking a queue to a function
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" then the "lambda" "function" invocation completes successfully
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the "lambda" "function"
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" then the "lambda" "function" invocation fails
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the "lambda" "function"
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "sqs" "queue" is created
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "sqs" "queue" is configured with a dead-letter queue
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "sqs" "queue" is configured with a dead-letter queue
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a message arrives in the "sqs" "queue"
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a message arrives in the "sqs" "queue"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "lambda" "event source mapping" is created linking a queue to a function
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "event source mapping" is created linking a queue to a function
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the event source mapping polls the queue and invokes the "lambda" "function"
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the event source mapping polls the queue and invokes the "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" invocation fails
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "sqs" "queue" is created
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "sqs" "queue" is configured with a dead-letter queue
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "sqs" "queue" is configured with a dead-letter queue
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a message arrives in the "sqs" "queue"
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a message arrives in the "sqs" "queue"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "lambda" "event source mapping" is created linking a queue to a function
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "lambda" "event source mapping" is created linking a queue to a function
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the event source mapping polls the queue and invokes the "lambda" "function"
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the event source mapping polls the queue and invokes the "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" invocation completes successfully
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then the "sqs" "queue" is configured with a dead-letter queue then a message arrives in the "sqs" "queue"
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When the "sqs" "queue" is configured with a dead-letter queue
    When a message arrives in the "sqs" "queue"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then a message arrives in the "sqs" "queue" then a "lambda" "function" is deployed
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a message arrives in the "sqs" "queue"
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then a "lambda" "function" is deployed then a "lambda" "event source mapping" is created linking a queue to a function
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a "lambda" "function" is deployed
    When a "lambda" "event source mapping" is created linking a queue to a function
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then a "lambda" "event source mapping" is created linking a queue to a function then the event source mapping polls the queue and invokes the "lambda" "function"
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a "lambda" "event source mapping" is created linking a queue to a function
    When the event source mapping polls the queue and invokes the "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then the event source mapping polls the queue and invokes the "lambda" "function" then the "lambda" "function" invocation completes successfully
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When the event source mapping polls the queue and invokes the "lambda" "function"
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then the "lambda" "function" invocation completes successfully then the "lambda" "function" invocation fails
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then the "lambda" "function" invocation fails then the "sqs" "queue" is configured with a dead-letter queue
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When the "lambda" "function" invocation fails
    When the "sqs" "queue" is configured with a dead-letter queue
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "sqs" "queue" is configured with a dead-letter queue then a "sqs" "queue" is created then a "lambda" "function" is deployed
    Given qid in queue_status
    When the "sqs" "queue" is configured with a dead-letter queue
    When a "sqs" "queue" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "sqs" "queue" is configured with a dead-letter queue then a message arrives in the "sqs" "queue" then a "lambda" "event source mapping" is created linking a queue to a function
    Given qid in queue_status
    When the "sqs" "queue" is configured with a dead-letter queue
    When a message arrives in the "sqs" "queue"
    When a "lambda" "event source mapping" is created linking a queue to a function
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "sqs" "queue" is configured with a dead-letter queue then a "lambda" "function" is deployed then the event source mapping polls the queue and invokes the "lambda" "function"
    Given qid in queue_status
    When the "sqs" "queue" is configured with a dead-letter queue
    When a "lambda" "function" is deployed
    When the event source mapping polls the queue and invokes the "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "sqs" "queue" is configured with a dead-letter queue then a "lambda" "event source mapping" is created linking a queue to a function then the "lambda" "function" invocation completes successfully
    Given qid in queue_status
    When the "sqs" "queue" is configured with a dead-letter queue
    When a "lambda" "event source mapping" is created linking a queue to a function
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "sqs" "queue" is configured with a dead-letter queue then the event source mapping polls the queue and invokes the "lambda" "function" then the "lambda" "function" invocation fails
    Given qid in queue_status
    When the "sqs" "queue" is configured with a dead-letter queue
    When the event source mapping polls the queue and invokes the "lambda" "function"
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "sqs" "queue" is configured with a dead-letter queue then the "lambda" "function" invocation completes successfully then a "sqs" "queue" is created
    Given qid in queue_status
    When the "sqs" "queue" is configured with a dead-letter queue
    When the "lambda" "function" invocation completes successfully
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "sqs" "queue" is configured with a dead-letter queue then the "lambda" "function" invocation fails then a message arrives in the "sqs" "queue"
    Given qid in queue_status
    When the "sqs" "queue" is configured with a dead-letter queue
    When the "lambda" "function" invocation fails
    When a message arrives in the "sqs" "queue"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a message arrives in the "sqs" "queue" then a "sqs" "queue" is created then a "lambda" "event source mapping" is created linking a queue to a function
    Given qid in queue_status
    When a message arrives in the "sqs" "queue"
    When a "sqs" "queue" is created
    When a "lambda" "event source mapping" is created linking a queue to a function
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a message arrives in the "sqs" "queue" then the "sqs" "queue" is configured with a dead-letter queue then the event source mapping polls the queue and invokes the "lambda" "function"
    Given qid in queue_status
    When a message arrives in the "sqs" "queue"
    When the "sqs" "queue" is configured with a dead-letter queue
    When the event source mapping polls the queue and invokes the "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a message arrives in the "sqs" "queue" then a "lambda" "function" is deployed then the "lambda" "function" invocation completes successfully
    Given qid in queue_status
    When a message arrives in the "sqs" "queue"
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a message arrives in the "sqs" "queue" then a "lambda" "event source mapping" is created linking a queue to a function then the "lambda" "function" invocation fails
    Given qid in queue_status
    When a message arrives in the "sqs" "queue"
    When a "lambda" "event source mapping" is created linking a queue to a function
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a message arrives in the "sqs" "queue" then the event source mapping polls the queue and invokes the "lambda" "function" then a "sqs" "queue" is created
    Given qid in queue_status
    When a message arrives in the "sqs" "queue"
    When the event source mapping polls the queue and invokes the "lambda" "function"
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a message arrives in the "sqs" "queue" then the "lambda" "function" invocation completes successfully then the "sqs" "queue" is configured with a dead-letter queue
    Given qid in queue_status
    When a message arrives in the "sqs" "queue"
    When the "lambda" "function" invocation completes successfully
    When the "sqs" "queue" is configured with a dead-letter queue
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a message arrives in the "sqs" "queue" then the "lambda" "function" invocation fails then a "lambda" "function" is deployed
    Given qid in queue_status
    When a message arrives in the "sqs" "queue"
    When the "lambda" "function" invocation fails
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "function" is deployed then a "sqs" "queue" is created then the event source mapping polls the queue and invokes the "lambda" "function"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "sqs" "queue" is created
    When the event source mapping polls the queue and invokes the "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "sqs" "queue" is configured with a dead-letter queue then the "lambda" "function" invocation completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "sqs" "queue" is configured with a dead-letter queue
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "function" is deployed then a message arrives in the "sqs" "queue" then the "lambda" "function" invocation fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a message arrives in the "sqs" "queue"
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "function" is deployed then a "lambda" "event source mapping" is created linking a queue to a function then a "sqs" "queue" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "lambda" "event source mapping" is created linking a queue to a function
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "function" is deployed then the event source mapping polls the queue and invokes the "lambda" "function" then the "sqs" "queue" is configured with a dead-letter queue
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the event source mapping polls the queue and invokes the "lambda" "function"
    When the "sqs" "queue" is configured with a dead-letter queue
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation completes successfully then a message arrives in the "sqs" "queue"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation completes successfully
    When a message arrives in the "sqs" "queue"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation fails then a "lambda" "event source mapping" is created linking a queue to a function
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails
    When a "lambda" "event source mapping" is created linking a queue to a function
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "event source mapping" is created linking a queue to a function then a "sqs" "queue" is created then the "lambda" "function" invocation completes successfully
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created linking a queue to a function
    When a "sqs" "queue" is created
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "event source mapping" is created linking a queue to a function then the "sqs" "queue" is configured with a dead-letter queue then the "lambda" "function" invocation fails
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created linking a queue to a function
    When the "sqs" "queue" is configured with a dead-letter queue
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "event source mapping" is created linking a queue to a function then a message arrives in the "sqs" "queue" then a "sqs" "queue" is created
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created linking a queue to a function
    When a message arrives in the "sqs" "queue"
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "event source mapping" is created linking a queue to a function then a "lambda" "function" is deployed then the "sqs" "queue" is configured with a dead-letter queue
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created linking a queue to a function
    When a "lambda" "function" is deployed
    When the "sqs" "queue" is configured with a dead-letter queue
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "event source mapping" is created linking a queue to a function then the event source mapping polls the queue and invokes the "lambda" "function" then a message arrives in the "sqs" "queue"
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created linking a queue to a function
    When the event source mapping polls the queue and invokes the "lambda" "function"
    When a message arrives in the "sqs" "queue"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "event source mapping" is created linking a queue to a function then the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created linking a queue to a function
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "event source mapping" is created linking a queue to a function then the "lambda" "function" invocation fails then the event source mapping polls the queue and invokes the "lambda" "function"
    Given eid not in esm_status
    When a "lambda" "event source mapping" is created linking a queue to a function
    When the "lambda" "function" invocation fails
    When the event source mapping polls the queue and invokes the "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" then a "sqs" "queue" is created then the "lambda" "function" invocation fails
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the "lambda" "function"
    When a "sqs" "queue" is created
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" then the "sqs" "queue" is configured with a dead-letter queue then a "sqs" "queue" is created
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the "lambda" "function"
    When the "sqs" "queue" is configured with a dead-letter queue
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" then a message arrives in the "sqs" "queue" then the "sqs" "queue" is configured with a dead-letter queue
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the "lambda" "function"
    When a message arrives in the "sqs" "queue"
    When the "sqs" "queue" is configured with a dead-letter queue
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" then a "lambda" "function" is deployed then a message arrives in the "sqs" "queue"
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the "lambda" "function"
    When a "lambda" "function" is deployed
    When a message arrives in the "sqs" "queue"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" then a "lambda" "event source mapping" is created linking a queue to a function then a "lambda" "function" is deployed
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the "lambda" "function"
    When a "lambda" "event source mapping" is created linking a queue to a function
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" then the "lambda" "function" invocation completes successfully then a "lambda" "event source mapping" is created linking a queue to a function
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the "lambda" "function"
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "event source mapping" is created linking a queue to a function
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" then the "lambda" "function" invocation fails then the "lambda" "function" invocation completes successfully
    Given eid in esm_status
    When the event source mapping polls the queue and invokes the "lambda" "function"
    When the "lambda" "function" invocation fails
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "sqs" "queue" is created then the "sqs" "queue" is configured with a dead-letter queue
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "sqs" "queue" is created
    When the "sqs" "queue" is configured with a dead-letter queue
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "sqs" "queue" is configured with a dead-letter queue then a message arrives in the "sqs" "queue"
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "sqs" "queue" is configured with a dead-letter queue
    When a message arrives in the "sqs" "queue"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a message arrives in the "sqs" "queue" then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a message arrives in the "sqs" "queue"
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed then a "lambda" "event source mapping" is created linking a queue to a function
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    When a "lambda" "event source mapping" is created linking a queue to a function
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "lambda" "event source mapping" is created linking a queue to a function then the event source mapping polls the queue and invokes the "lambda" "function"
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "event source mapping" is created linking a queue to a function
    When the event source mapping polls the queue and invokes the "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the event source mapping polls the queue and invokes the "lambda" "function" then the "lambda" "function" invocation fails
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the event source mapping polls the queue and invokes the "lambda" "function"
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" invocation fails then a "sqs" "queue" is created
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" invocation fails
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "sqs" "queue" is created then a message arrives in the "sqs" "queue"
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "sqs" "queue" is created
    When a message arrives in the "sqs" "queue"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "sqs" "queue" is configured with a dead-letter queue then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "sqs" "queue" is configured with a dead-letter queue
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a message arrives in the "sqs" "queue" then a "lambda" "event source mapping" is created linking a queue to a function
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a message arrives in the "sqs" "queue"
    When a "lambda" "event source mapping" is created linking a queue to a function
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "lambda" "function" is deployed then the event source mapping polls the queue and invokes the "lambda" "function"
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "lambda" "function" is deployed
    When the event source mapping polls the queue and invokes the "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "lambda" "event source mapping" is created linking a queue to a function then the "lambda" "function" invocation completes successfully
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "lambda" "event source mapping" is created linking a queue to a function
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the event source mapping polls the queue and invokes the "lambda" "function" then a "sqs" "queue" is created
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the event source mapping polls the queue and invokes the "lambda" "function"
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" invocation completes successfully then the "sqs" "queue" is configured with a dead-letter queue
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" invocation completes successfully
    When the "sqs" "queue" is configured with a dead-letter queue
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"
