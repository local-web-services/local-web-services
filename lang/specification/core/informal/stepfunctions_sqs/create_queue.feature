@stepfunctionssqs @generated
Feature: StepfunctionsSqs - An Sqs Queue Is Created

  # Generated from FizzBee spec: stepfunctions_sqs.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @create_queue
  Scenario: an "SQS" queue is created
    Given the queue does not already exist
    When an "SQS" queue is created
    Then the queue is "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @guard @negative @create_queue
  Scenario: an "SQS" queue is created fails when the queue already exists
    Given the queue already exists
    When an "SQS" queue is created
    Then the operation is rejected
