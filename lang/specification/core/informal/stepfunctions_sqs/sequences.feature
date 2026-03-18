@stepfunctionssqs @generated
Feature: StepfunctionsSqs - Action Sequences

  # Generated from FizzBee spec: stepfunctions_sqs.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an "SQS" queue is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an "SQS" queue is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an "SQS" send-message task is configured on the state machine
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an "SQS" send-message task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution reaches the "SQS" task state and sends a message to the queue
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a Step Functions state machine is created
    Given qid not in queue_status
    When an "SQS" queue is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an "SQS" send-message task is configured on the state machine
    Given qid not in queue_status
    When an "SQS" queue is created
    When an "SQS" send-message task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an execution of the state machine is started
    Given qid not in queue_status
    When an "SQS" queue is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a running execution reaches the "SQS" task state and sends a message to the queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When a running execution reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then a Step Functions state machine is created
    Given smid in sm_status
    When an "SQS" send-message task is configured on the state machine
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then an "SQS" queue is created
    Given smid in sm_status
    When an "SQS" send-message task is configured on the state machine
    When an "SQS" queue is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then an execution of the state machine is started
    Given smid in sm_status
    When an "SQS" send-message task is configured on the state machine
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then a running execution reaches the "SQS" task state and sends a message to the queue
    Given smid in sm_status
    When an "SQS" send-message task is configured on the state machine
    When a running execution reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an "SQS" queue is created
    Given smid in sm_status
    When an execution of the state machine is started
    When an "SQS" queue is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an "SQS" send-message task is configured on the state machine
    Given smid in sm_status
    When an execution of the state machine is started
    When an "SQS" send-message task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution reaches the "SQS" task state and sends a message to the queue
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then an "SQS" queue is created
    Given eid in exec_status
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When an "SQS" queue is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then an "SQS" send-message task is configured on the state machine
    Given eid in exec_status
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When an "SQS" send-message task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then an execution of the state machine is started
    Given eid in exec_status
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an "SQS" queue is created then an "SQS" send-message task is configured on the state machine
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an "SQS" queue is created
    When an "SQS" send-message task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an "SQS" queue is created then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an "SQS" queue is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an "SQS" queue is created then a running execution reaches the "SQS" task state and sends a message to the queue
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an "SQS" queue is created
    When a running execution reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an "SQS" send-message task is configured on the state machine then an "SQS" queue is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an "SQS" send-message task is configured on the state machine
    When an "SQS" queue is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an "SQS" send-message task is configured on the state machine then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an "SQS" send-message task is configured on the state machine
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an "SQS" send-message task is configured on the state machine then a running execution reaches the "SQS" task state and sends a message to the queue
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an "SQS" send-message task is configured on the state machine
    When a running execution reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then an "SQS" queue is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When an "SQS" queue is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then an "SQS" send-message task is configured on the state machine
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When an "SQS" send-message task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution reaches the "SQS" task state and sends a message to the queue
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a running execution reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution reaches the "SQS" task state and sends a message to the queue then an "SQS" queue is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When an "SQS" queue is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution reaches the "SQS" task state and sends a message to the queue then an "SQS" send-message task is configured on the state machine
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When an "SQS" send-message task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution reaches the "SQS" task state and sends a message to the queue then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a Step Functions state machine is created then an "SQS" send-message task is configured on the state machine
    Given qid not in queue_status
    When an "SQS" queue is created
    When a Step Functions state machine is created
    When an "SQS" send-message task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a Step Functions state machine is created then an execution of the state machine is started
    Given qid not in queue_status
    When an "SQS" queue is created
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a Step Functions state machine is created then a running execution reaches the "SQS" task state and sends a message to the queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When a Step Functions state machine is created
    When a running execution reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an "SQS" send-message task is configured on the state machine then a Step Functions state machine is created
    Given qid not in queue_status
    When an "SQS" queue is created
    When an "SQS" send-message task is configured on the state machine
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an "SQS" send-message task is configured on the state machine then an execution of the state machine is started
    Given qid not in queue_status
    When an "SQS" queue is created
    When an "SQS" send-message task is configured on the state machine
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an "SQS" send-message task is configured on the state machine then a running execution reaches the "SQS" task state and sends a message to the queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When an "SQS" send-message task is configured on the state machine
    When a running execution reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an execution of the state machine is started then a Step Functions state machine is created
    Given qid not in queue_status
    When an "SQS" queue is created
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an execution of the state machine is started then an "SQS" send-message task is configured on the state machine
    Given qid not in queue_status
    When an "SQS" queue is created
    When an execution of the state machine is started
    When an "SQS" send-message task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an execution of the state machine is started then a running execution reaches the "SQS" task state and sends a message to the queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When an execution of the state machine is started
    When a running execution reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a running execution reaches the "SQS" task state and sends a message to the queue then a Step Functions state machine is created
    Given qid not in queue_status
    When an "SQS" queue is created
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a running execution reaches the "SQS" task state and sends a message to the queue then an "SQS" send-message task is configured on the state machine
    Given qid not in queue_status
    When an "SQS" queue is created
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When an "SQS" send-message task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a running execution reaches the "SQS" task state and sends a message to the queue then an execution of the state machine is started
    Given qid not in queue_status
    When an "SQS" queue is created
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then a Step Functions state machine is created then an "SQS" queue is created
    Given smid in sm_status
    When an "SQS" send-message task is configured on the state machine
    When a Step Functions state machine is created
    When an "SQS" queue is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then a Step Functions state machine is created then an execution of the state machine is started
    Given smid in sm_status
    When an "SQS" send-message task is configured on the state machine
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then a Step Functions state machine is created then a running execution reaches the "SQS" task state and sends a message to the queue
    Given smid in sm_status
    When an "SQS" send-message task is configured on the state machine
    When a Step Functions state machine is created
    When a running execution reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then an "SQS" queue is created then a Step Functions state machine is created
    Given smid in sm_status
    When an "SQS" send-message task is configured on the state machine
    When an "SQS" queue is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then an "SQS" queue is created then an execution of the state machine is started
    Given smid in sm_status
    When an "SQS" send-message task is configured on the state machine
    When an "SQS" queue is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then an "SQS" queue is created then a running execution reaches the "SQS" task state and sends a message to the queue
    Given smid in sm_status
    When an "SQS" send-message task is configured on the state machine
    When an "SQS" queue is created
    When a running execution reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    When an "SQS" send-message task is configured on the state machine
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then an execution of the state machine is started then an "SQS" queue is created
    Given smid in sm_status
    When an "SQS" send-message task is configured on the state machine
    When an execution of the state machine is started
    When an "SQS" queue is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then an execution of the state machine is started then a running execution reaches the "SQS" task state and sends a message to the queue
    Given smid in sm_status
    When an "SQS" send-message task is configured on the state machine
    When an execution of the state machine is started
    When a running execution reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then a running execution reaches the "SQS" task state and sends a message to the queue then a Step Functions state machine is created
    Given smid in sm_status
    When an "SQS" send-message task is configured on the state machine
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then a running execution reaches the "SQS" task state and sends a message to the queue then an "SQS" queue is created
    Given smid in sm_status
    When an "SQS" send-message task is configured on the state machine
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When an "SQS" queue is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then a running execution reaches the "SQS" task state and sends a message to the queue then an execution of the state machine is started
    Given smid in sm_status
    When an "SQS" send-message task is configured on the state machine
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then an "SQS" queue is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When an "SQS" queue is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then an "SQS" send-message task is configured on the state machine
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When an "SQS" send-message task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution reaches the "SQS" task state and sends a message to the queue
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a running execution reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an "SQS" queue is created then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When an "SQS" queue is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an "SQS" queue is created then an "SQS" send-message task is configured on the state machine
    Given smid in sm_status
    When an execution of the state machine is started
    When an "SQS" queue is created
    When an "SQS" send-message task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an "SQS" queue is created then a running execution reaches the "SQS" task state and sends a message to the queue
    Given smid in sm_status
    When an execution of the state machine is started
    When an "SQS" queue is created
    When a running execution reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an "SQS" send-message task is configured on the state machine then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When an "SQS" send-message task is configured on the state machine
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an "SQS" send-message task is configured on the state machine then an "SQS" queue is created
    Given smid in sm_status
    When an execution of the state machine is started
    When an "SQS" send-message task is configured on the state machine
    When an "SQS" queue is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an "SQS" send-message task is configured on the state machine then a running execution reaches the "SQS" task state and sends a message to the queue
    Given smid in sm_status
    When an execution of the state machine is started
    When an "SQS" send-message task is configured on the state machine
    When a running execution reaches the "SQS" task state and sends a message to the queue
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution reaches the "SQS" task state and sends a message to the queue then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution reaches the "SQS" task state and sends a message to the queue then an "SQS" queue is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When an "SQS" queue is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution reaches the "SQS" task state and sends a message to the queue then an "SQS" send-message task is configured on the state machine
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When an "SQS" send-message task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then a Step Functions state machine is created then an "SQS" queue is created
    Given eid in exec_status
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When a Step Functions state machine is created
    When an "SQS" queue is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then a Step Functions state machine is created then an "SQS" send-message task is configured on the state machine
    Given eid in exec_status
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When a Step Functions state machine is created
    When an "SQS" send-message task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then a Step Functions state machine is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then an "SQS" queue is created then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When an "SQS" queue is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then an "SQS" queue is created then an "SQS" send-message task is configured on the state machine
    Given eid in exec_status
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When an "SQS" queue is created
    When an "SQS" send-message task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then an "SQS" queue is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When an "SQS" queue is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then an "SQS" send-message task is configured on the state machine then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When an "SQS" send-message task is configured on the state machine
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then an "SQS" send-message task is configured on the state machine then an "SQS" queue is created
    Given eid in exec_status
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When an "SQS" send-message task is configured on the state machine
    When an "SQS" queue is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then an "SQS" send-message task is configured on the state machine then an execution of the state machine is started
    Given eid in exec_status
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When an "SQS" send-message task is configured on the state machine
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then an execution of the state machine is started then an "SQS" queue is created
    Given eid in exec_status
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When an execution of the state machine is started
    When an "SQS" queue is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then an execution of the state machine is started then an "SQS" send-message task is configured on the state machine
    Given eid in exec_status
    When a running execution reaches the "SQS" task state and sends a message to the queue
    When an execution of the state machine is started
    When an "SQS" send-message task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
