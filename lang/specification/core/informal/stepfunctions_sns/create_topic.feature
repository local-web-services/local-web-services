@stepfunctionssns @generated
Feature: StepfunctionsSns - An Sns Topic Is Created

  # Generated from FizzBee spec: stepfunctions_sns.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ExecutionRequiresActiveTopic

  Background:
    Given the system is initialized

  @minimal @happy @create_topic
  Scenario: an "SNS" topic is created
    Given the topic does not already exist
    When an "SNS" topic is created
    Then the topic is "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @guard @negative @create_topic
  Scenario: an "SNS" topic is created fails when the topic already exists
    Given the topic already exists
    When an "SNS" topic is created
    Then the operation is rejected
