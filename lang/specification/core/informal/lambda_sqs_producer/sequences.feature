@lambdasqsproducer @generated
Feature: LambdaSqsProducer - Action Sequences

  # Generated from FizzBee spec: lambda_sqs_producer.fizz
  # Safety invariants: InvocationRequiresActiveFunction, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "lambda" "function" is deployed then a "sqs" "queue" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then a "lambda" "function" is deployed
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then the "lambda" "function" is invoked
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then the "lambda" "function" invocation completes successfully
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then the "lambda" "function" invocation fails
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" is invoked then a "sqs" "queue" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" invocation completes successfully
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" invocation fails
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" sends a message to the "sqs" "queue" during invocation then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" sends a message to the "sqs" "queue" during invocation then a "sqs" "queue" is created
    Given iid in inv_status
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" sends a message to the "sqs" "queue" during invocation then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" sends a message to the "sqs" "queue" during invocation then the "lambda" "function" invocation completes successfully
    Given iid in inv_status
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" sends a message to the "sqs" "queue" during invocation then the "lambda" "function" invocation fails
    Given iid in inv_status
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "sqs" "queue" is created
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" invocation fails
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "sqs" "queue" is created
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" invocation completes successfully
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "function" is deployed then a "sqs" "queue" is created then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "sqs" "queue" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked then the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" sends a message to the "sqs" "queue" during invocation then the "lambda" "function" invocation completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation completes successfully then the "lambda" "function" invocation fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation fails then a "sqs" "queue" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then a "lambda" "function" is deployed then the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a "lambda" "function" is deployed
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then the "lambda" "function" is invoked then the "lambda" "function" invocation completes successfully
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When the "lambda" "function" is invoked
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then the "lambda" "function" sends a message to the "sqs" "queue" during invocation then the "lambda" "function" invocation fails
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then the "lambda" "function" invocation fails then the "lambda" "function" is invoked
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When the "lambda" "function" invocation fails
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed then the "lambda" "function" invocation completes successfully
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" is invoked then a "sqs" "queue" is created then the "lambda" "function" invocation fails
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "sqs" "queue" is created
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" sends a message to the "sqs" "queue" during invocation then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" invocation completes successfully then a "sqs" "queue" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" invocation completes successfully
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" invocation fails then the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" invocation fails
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" sends a message to the "sqs" "queue" during invocation then a "lambda" "function" is deployed then the "lambda" "function" invocation fails
    Given iid in inv_status
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" sends a message to the "sqs" "queue" during invocation then a "sqs" "queue" is created then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    When a "sqs" "queue" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" sends a message to the "sqs" "queue" during invocation then the "lambda" "function" is invoked then a "sqs" "queue" is created
    Given iid in inv_status
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    When the "lambda" "function" is invoked
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" sends a message to the "sqs" "queue" during invocation then the "lambda" "function" invocation completes successfully then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" sends a message to the "sqs" "queue" during invocation then the "lambda" "function" invocation fails then the "lambda" "function" invocation completes successfully
    Given iid in inv_status
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    When the "lambda" "function" invocation fails
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed then a "sqs" "queue" is created
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "sqs" "queue" is created then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "sqs" "queue" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" is invoked then the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" is invoked
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" sends a message to the "sqs" "queue" during invocation then the "lambda" "function" invocation fails
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" invocation fails then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" invocation fails
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "sqs" "queue" is created then the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "sqs" "queue" is created
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" is invoked then the "lambda" "function" invocation completes successfully
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" is invoked
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" sends a message to the "sqs" "queue" during invocation then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" invocation completes successfully then a "sqs" "queue" is created
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" invocation completes successfully
    When a "sqs" "queue" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
