@stepfunctionssqs @generated
Feature: StepfunctionsSqs - A "Step Functions" "State Machine" Is Created

  # Generated from FizzBee spec: stepfunctions_sqs.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @create_state_machine
  Scenario: a "step functions" "state machine" is created
    Given the "step functions" "state machine" did not already exist
    When a "step functions" "state machine" is created
    Then the "step functions" "state machine" will be "ACTIVE" with no "SQS" task configured
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @guard @negative @create_state_machine
  Scenario: a "step functions" "state machine" is created fails when the "step functions" "state machine" already existed
    Given the "step functions" "state machine" already existed
    When a "step functions" "state machine" is created
    Then the operation is rejected
