@stepfunctionssns @generated
Feature: StepfunctionsSns - A Running Execution Publishes A Message To The Sns Topic And Succeeds

  # Generated from FizzBee spec: stepfunctions_sns.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ExecutionRequiresActiveTopic

  Background:
    Given the system is initialized

  @minimal @happy @publish_task
  Scenario: a running execution publishes a message to the "SNS" topic and succeeds
    Given an execution is "RUNNING"
    And the target topic is "ACTIVE"
    When a running execution publishes a message to the "SNS" topic and succeeds
    Then the execution is "SUCCEEDED" and the message has been published to the topic
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @standard @negative @publish_task
  Scenario: a running execution publishes a message to the "SNS" topic and succeeds fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution publishes a message to the "SNS" topic and succeeds
    Then the operation is rejected

  @standard @negative @publish_task @lifecycle @internal
  Scenario: a running execution publishes a message to the "SNS" topic and succeeds fails when the target topic is not "ACTIVE"
    Given an execution is "RUNNING"
    And the target topic is not "ACTIVE"
    When a running execution publishes a message to the "SNS" topic and succeeds
    Then the operation is rejected
