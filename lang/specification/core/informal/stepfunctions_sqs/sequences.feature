@stepfunctionssqs @generated
Feature: StepfunctionsSqs - Action Sequences

  # Generated from FizzBee spec: stepfunctions_sqs.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "step functions" "state machine" is created then a "sqs" "queue" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "sqs" "queue" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "step functions" "state machine" is created then an "sqs" send-message task is configured on the "step functions" "state machine"
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then a "step functions" "state machine" is created
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then an "sqs" send-message task is configured on the "step functions" "state machine"
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: an "sqs" send-message task is configured on the "step functions" "state machine" then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: an "sqs" send-message task is configured on the "step functions" "state machine" then a "sqs" "queue" is created
    Given smid in sm_status
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    When a "sqs" "queue" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: an "sqs" send-message task is configured on the "step functions" "state machine" then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid in sm_status
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: an "sqs" send-message task is configured on the "step functions" "state machine" then a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    Given smid in sm_status
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "sqs" "queue" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "sqs" "queue" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then an "sqs" send-message task is configured on the "step functions" "state machine"
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue then a "sqs" "queue" is created
    Given eid in exec_status
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    When a "sqs" "queue" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue then an "sqs" send-message task is configured on the "step functions" "state machine"
    Given eid in exec_status
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "step functions" "state machine" is created then a "sqs" "queue" is created then an "sqs" send-message task is configured on the "step functions" "state machine"
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "sqs" "queue" is created
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "step functions" "state machine" is created then an "sqs" send-message task is configured on the "step functions" "state machine" then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue then a "sqs" "queue" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    When a "sqs" "queue" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then an "sqs" send-message task is configured on the "step functions" "state machine" then a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a "sqs" "queue" is created then a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue then an "sqs" send-message task is configured on the "step functions" "state machine"
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: an "sqs" send-message task is configured on the "step functions" "state machine" then a "step functions" "state machine" is created then a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    Given smid in sm_status
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: an "sqs" send-message task is configured on the "step functions" "state machine" then a "sqs" "queue" is created then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    When a "sqs" "queue" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: an "sqs" send-message task is configured on the "step functions" "state machine" then an "step functions" "execution" of the "step functions" "state machine" is started then a "sqs" "queue" is created
    Given smid in sm_status
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "sqs" "queue" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: an "sqs" send-message task is configured on the "step functions" "state machine" then a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid in sm_status
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created then a "sqs" "queue" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    When a "sqs" "queue" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "sqs" "queue" is created then an "sqs" send-message task is configured on the "step functions" "state machine"
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "sqs" "queue" is created
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then an "sqs" send-message task is configured on the "step functions" "state machine" then a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue then a "step functions" "state machine" is created then an "sqs" send-message task is configured on the "step functions" "state machine"
    Given eid in exec_status
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    When a "step functions" "state machine" is created
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue then a "sqs" "queue" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    When a "sqs" "queue" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue then an "sqs" send-message task is configured on the "step functions" "state machine" then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @sequence
  Scenario: a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue then an "step functions" "execution" of the "step functions" "state machine" is started then a "sqs" "queue" is created
    Given eid in exec_status
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "sqs" "queue" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
