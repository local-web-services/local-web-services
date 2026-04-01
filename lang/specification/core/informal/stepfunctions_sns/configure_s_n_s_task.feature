@stepfunctionssns @generated
Feature: StepfunctionsSns - A Sns Publish Task Is Configured On The State Machine

  # Generated from FizzBee spec: stepfunctions_sns.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ExecutionRequiresActiveTopic

  Background:
    Given the system is initialized

  @minimal @happy @configure_s_n_s_task
  Scenario: a "SNS" publish task is configured on the state machine
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the state machine has no "SNS" task configured
    And the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    When a "SNS" publish task is configured on the state machine
    Then the state machine will publish a "sns" "message" to the "sns" "topic" when it reaches the task state
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @guard @negative @configure_s_n_s_task
  Scenario: a "SNS" publish task is configured on the state machine fails when the "step functions" "state machine" did not exist
    Given the "step functions" "state machine" did not exist
    When a "SNS" publish task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_s_n_s_task @lifecycle
  Scenario: a "SNS" publish task is configured on the state machine fails when the "step functions" "state machine" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was not "ACTIVE"
    When a "SNS" publish task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_s_n_s_task
  Scenario: a "SNS" publish task is configured on the state machine fails when the state machine already has a "SNS" task configured
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the state machine already has a "SNS" task configured
    When a "SNS" publish task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_s_n_s_task
  Scenario: a "SNS" publish task is configured on the state machine fails when the "sns" "topic" did not exist
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the state machine has no "SNS" task configured
    And the "sns" "topic" did not exist
    When a "SNS" publish task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_s_n_s_task @lifecycle
  Scenario: a "SNS" publish task is configured on the state machine fails when the "sns" "topic" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the state machine has no "SNS" task configured
    And the "sns" "topic" existed
    And the "sns" "topic" was not "ACTIVE"
    When a "SNS" publish task is configured on the state machine
    Then the operation is rejected
