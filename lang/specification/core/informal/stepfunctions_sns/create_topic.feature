@stepfunctionssns @generated
Feature: StepfunctionsSns - A "Sns" "Topic" Is Created

  # Generated from FizzBee spec: stepfunctions_sns.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ExecutionRequiresActiveTopic

  Background:
    Given the system is initialized

  @minimal @happy @create_topic
  Scenario: a "sns" "topic" is created
    Given the "sns" "topic" did not already exist
    When a "sns" "topic" is created
    Then the "sns" "topic" will be "ACTIVE"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution"'s state machine targets an "ACTIVE" "sns" "topic"

  @guard @negative @create_topic
  Scenario: a "sns" "topic" is created fails when the "sns" "topic" already existed
    Given the "sns" "topic" already existed
    When a "sns" "topic" is created
    Then the operation is rejected
