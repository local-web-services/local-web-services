@stepfunctionssns @generated
Feature: StepfunctionsSns - A Running "Step Functions" "Execution" Publishes A Message To The "Sns" "Topic" And Succeeds

  # Generated from FizzBee spec: stepfunctions_sns.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ExecutionRequiresActiveTopic

  Background:
    Given the system is initialized

  @minimal @happy @publish_task
  Scenario: a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    Given a "step functions" "execution" was "RUNNING"
    And the target topic was "ACTIVE"
    When a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    Then the "step functions" "execution" will be "SUCCEEDED" and the message has been published to the topic
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @guard @negative @publish_task
  Scenario: a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    Then the operation is rejected

  @guard @negative @publish_task @lifecycle
  Scenario: a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds fails when the target topic was not "ACTIVE"
    Given a "step functions" "execution" was "RUNNING"
    And the target topic was not "ACTIVE"
    When a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    Then the operation is rejected
