@stepfunctionssns @generated
Feature: StepfunctionsSns - An Sns Publish Task Is Configured On The State Machine

  # Generated from FizzBee spec: stepfunctions_sns.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ExecutionRequiresActiveTopic

  Background:
    Given the system is initialized

  @minimal @happy @configure_s_n_s_task
  Scenario: an "SNS" publish task is configured on the state machine
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine has no "SNS" task configured
    And the topic exists
    And the topic is "ACTIVE"
    When an "SNS" publish task is configured on the state machine
    Then the state machine will publish a message to the topic when it reaches the task state
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @guard @negative @configure_s_n_s_task
  Scenario: an "SNS" publish task is configured on the state machine fails when the state machine does not exist
    Given the state machine does not exist
    When an "SNS" publish task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_s_n_s_task @lifecycle
  Scenario: an "SNS" publish task is configured on the state machine fails when the state machine is not "ACTIVE"
    Given the state machine exists
    And the state machine is not "ACTIVE"
    When an "SNS" publish task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_s_n_s_task
  Scenario: an "SNS" publish task is configured on the state machine fails when the state machine already has an "SNS" task configured
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine already has an "SNS" task configured
    When an "SNS" publish task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_s_n_s_task
  Scenario: an "SNS" publish task is configured on the state machine fails when the topic does not exist
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine has no "SNS" task configured
    And the topic does not exist
    When an "SNS" publish task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_s_n_s_task @lifecycle
  Scenario: an "SNS" publish task is configured on the state machine fails when the topic is not "ACTIVE"
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine has no "SNS" task configured
    And the topic exists
    And the topic is not "ACTIVE"
    When an "SNS" publish task is configured on the state machine
    Then the operation is rejected
