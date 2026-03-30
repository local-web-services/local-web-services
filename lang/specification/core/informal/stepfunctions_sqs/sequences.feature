@stepfunctionssqs @generated
Feature: StepfunctionsSqs - Action Sequences

  # Generated from FizzBee spec: stepfunctions_sqs.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @sequence
  Scenario: a Step Functions state machine is created then an "SQS" queue is created
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an "SQS" queue is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a Step Functions state machine is created then an "SQS" send-message task is configured on the state machine
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an "SQS" send-message task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a Step Functions state machine is created then a running execution reaches the "SQS" task state and sends a message to the queue
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution reaches the "SQS" task state and sends a message to the queue
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" queue is created then a Step Functions state machine is created
    Given qid not in queue_status
    Given an "SQS" queue has been created
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" queue is created then an "SQS" send-message task is configured on the state machine
    Given qid not in queue_status
    Given an "SQS" queue has been created
    When an "SQS" send-message task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" queue is created then an execution of the state machine is started
    Given qid not in queue_status
    Given an "SQS" queue has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" queue is created then a running execution reaches the "SQS" task state and sends a message to the queue
    Given qid not in queue_status
    Given an "SQS" queue has been created
    When a running execution reaches the "SQS" task state and sends a message to the queue
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then a Step Functions state machine is created
    Given smid in sm_status
    Given an "SQS" send-message task has been configured on the state machine
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then an "SQS" queue is created
    Given smid in sm_status
    Given an "SQS" send-message task has been configured on the state machine
    When an "SQS" queue is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then an execution of the state machine is started
    Given smid in sm_status
    Given an "SQS" send-message task has been configured on the state machine
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then a running execution reaches the "SQS" task state and sends a message to the queue
    Given smid in sm_status
    Given an "SQS" send-message task has been configured on the state machine
    When a running execution reaches the "SQS" task state and sends a message to the queue
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an execution of the state machine is started then an "SQS" queue is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    When an "SQS" queue is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an execution of the state machine is started then an "SQS" send-message task is configured on the state machine
    Given smid in sm_status
    Given an execution of the state machine has been started
    When an "SQS" send-message task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an execution of the state machine is started then a running execution reaches the "SQS" task state and sends a message to the queue
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution reaches the "SQS" task state and sends a message to the queue
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has reached the "SQS" task state and sent a message to the queue
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then an "SQS" queue is created
    Given eid in exec_status
    Given a running execution has reached the "SQS" task state and sent a message to the queue
    When an "SQS" queue is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then an "SQS" send-message task is configured on the state machine
    Given eid in exec_status
    Given a running execution has reached the "SQS" task state and sent a message to the queue
    When an "SQS" send-message task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has reached the "SQS" task state and sent a message to the queue
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a Step Functions state machine is created then an "SQS" queue is created then an "SQS" send-message task is configured on the state machine
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an "SQS" queue has been created
    When an "SQS" send-message task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a Step Functions state machine is created then an "SQS" send-message task is configured on the state machine then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an "SQS" send-message task has been configured on the state machine
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution reaches the "SQS" task state and sends a message to the queue
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an execution of the state machine has been started
    When a running execution reaches the "SQS" task state and sends a message to the queue
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a Step Functions state machine is created then a running execution reaches the "SQS" task state and sends a message to the queue then an "SQS" queue is created
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has reached the "SQS" task state and sent a message to the queue
    When an "SQS" queue is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" queue is created then a Step Functions state machine is created then an execution of the state machine is started
    Given qid not in queue_status
    Given an "SQS" queue has been created
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" queue is created then an "SQS" send-message task is configured on the state machine then a running execution reaches the "SQS" task state and sends a message to the queue
    Given qid not in queue_status
    Given an "SQS" queue has been created
    Given an "SQS" send-message task has been configured on the state machine
    When a running execution reaches the "SQS" task state and sends a message to the queue
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" queue is created then an execution of the state machine is started then a Step Functions state machine is created
    Given qid not in queue_status
    Given an "SQS" queue has been created
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" queue is created then a running execution reaches the "SQS" task state and sends a message to the queue then an "SQS" send-message task is configured on the state machine
    Given qid not in queue_status
    Given an "SQS" queue has been created
    Given a running execution has reached the "SQS" task state and sent a message to the queue
    When an "SQS" send-message task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then a Step Functions state machine is created then a running execution reaches the "SQS" task state and sends a message to the queue
    Given smid in sm_status
    Given an "SQS" send-message task has been configured on the state machine
    Given a Step Functions state machine has been created
    When a running execution reaches the "SQS" task state and sends a message to the queue
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then an "SQS" queue is created then a Step Functions state machine is created
    Given smid in sm_status
    Given an "SQS" send-message task has been configured on the state machine
    Given an "SQS" queue has been created
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then an execution of the state machine is started then an "SQS" queue is created
    Given smid in sm_status
    Given an "SQS" send-message task has been configured on the state machine
    Given an execution of the state machine has been started
    When an "SQS" queue is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" send-message task is configured on the state machine then a running execution reaches the "SQS" task state and sends a message to the queue then an execution of the state machine is started
    Given smid in sm_status
    Given an "SQS" send-message task has been configured on the state machine
    Given a running execution has reached the "SQS" task state and sent a message to the queue
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then an "SQS" queue is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a Step Functions state machine has been created
    When an "SQS" queue is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an execution of the state machine is started then an "SQS" queue is created then an "SQS" send-message task is configured on the state machine
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given an "SQS" queue has been created
    When an "SQS" send-message task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an execution of the state machine is started then an "SQS" send-message task is configured on the state machine then a running execution reaches the "SQS" task state and sends a message to the queue
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given an "SQS" send-message task has been configured on the state machine
    When a running execution reaches the "SQS" task state and sends a message to the queue
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an execution of the state machine is started then a running execution reaches the "SQS" task state and sends a message to the queue then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has reached the "SQS" task state and sent a message to the queue
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then a Step Functions state machine is created then an "SQS" send-message task is configured on the state machine
    Given eid in exec_status
    Given a running execution has reached the "SQS" task state and sent a message to the queue
    Given a Step Functions state machine has been created
    When an "SQS" send-message task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then an "SQS" queue is created then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has reached the "SQS" task state and sent a message to the queue
    Given an "SQS" queue has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then an "SQS" send-message task is configured on the state machine then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has reached the "SQS" task state and sent a message to the queue
    Given an "SQS" send-message task has been configured on the state machine
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue then an execution of the state machine is started then an "SQS" queue is created
    Given eid in exec_status
    Given a running execution has reached the "SQS" task state and sent a message to the queue
    Given an execution of the state machine has been started
    When an "SQS" queue is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
