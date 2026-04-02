@stepfunctionssqs @generated
Feature: StepfunctionsSqs - An "Sqs" Send-Message Task Is Configured On The "Step Functions" "State Machine"

  # Generated from FizzBee spec: stepfunctions_sqs.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @configure_s_q_s_task
  Scenario: an "sqs" send-message task is configured on the "step functions" "state machine"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" has no "sqs" task configured
    And the "sqs" "queue" existed
    And the "sqs" "queue" was "ACTIVE"
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    Then the "step functions" "state machine" will enqueue an "sqs" "message" when it reaches the task state
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @guard @negative @configure_s_q_s_task
  Scenario: an "sqs" send-message task is configured on the "step functions" "state machine" fails when the "step functions" "state machine" did not exist
    Given the "step functions" "state machine" did not exist
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @configure_s_q_s_task @lifecycle
  Scenario: an "sqs" send-message task is configured on the "step functions" "state machine" fails when the "step functions" "state machine" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was not "ACTIVE"
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @configure_s_q_s_task
  Scenario: an "sqs" send-message task is configured on the "step functions" "state machine" fails when the "step functions" "state machine" already has an "sqs" task configured
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" already has an "sqs" task configured
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @configure_s_q_s_task
  Scenario: an "sqs" send-message task is configured on the "step functions" "state machine" fails when the "sqs" "queue" did not exist
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" has no "sqs" task configured
    And the "sqs" "queue" did not exist
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @configure_s_q_s_task @lifecycle
  Scenario: an "sqs" send-message task is configured on the "step functions" "state machine" fails when the "sqs" "queue" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" has no "sqs" task configured
    And the "sqs" "queue" existed
    And the "sqs" "queue" was not "ACTIVE"
    When an "sqs" send-message task is configured on the "step functions" "state machine"
    Then the operation is rejected
