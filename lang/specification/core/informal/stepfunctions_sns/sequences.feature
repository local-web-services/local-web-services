@stepfunctionssns @generated
Feature: StepfunctionsSns - Action Sequences

  # Generated from FizzBee spec: stepfunctions_sns.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ExecutionRequiresActiveTopic

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an "SNS" topic is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an "SNS" topic is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an "SNS" publish task is configured on the state machine
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an "SNS" publish task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution publishes a message to the "SNS" topic and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution publishes a message to the "SNS" topic and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Step Functions state machine is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" publish task is configured on the state machine
    Given tid not in topic_status
    When an "SNS" topic is created
    When an "SNS" publish task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an execution of the state machine is started
    Given tid not in topic_status
    When an "SNS" topic is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a running execution publishes a message to the "SNS" topic and succeeds
    Given tid not in topic_status
    When an "SNS" topic is created
    When a running execution publishes a message to the "SNS" topic and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" publish task is configured on the state machine then a Step Functions state machine is created
    Given smid in sm_status
    When an "SNS" publish task is configured on the state machine
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" publish task is configured on the state machine then an "SNS" topic is created
    Given smid in sm_status
    When an "SNS" publish task is configured on the state machine
    When an "SNS" topic is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" publish task is configured on the state machine then an execution of the state machine is started
    Given smid in sm_status
    When an "SNS" publish task is configured on the state machine
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" publish task is configured on the state machine then a running execution publishes a message to the "SNS" topic and succeeds
    Given smid in sm_status
    When an "SNS" publish task is configured on the state machine
    When a running execution publishes a message to the "SNS" topic and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an "SNS" topic is created
    Given smid in sm_status
    When an execution of the state machine is started
    When an "SNS" topic is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an "SNS" publish task is configured on the state machine
    Given smid in sm_status
    When an execution of the state machine is started
    When an "SNS" publish task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution publishes a message to the "SNS" topic and succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution publishes a message to the "SNS" topic and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a running execution publishes a message to the "SNS" topic and succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution publishes a message to the "SNS" topic and succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a running execution publishes a message to the "SNS" topic and succeeds then an "SNS" topic is created
    Given eid in exec_status
    When a running execution publishes a message to the "SNS" topic and succeeds
    When an "SNS" topic is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a running execution publishes a message to the "SNS" topic and succeeds then an "SNS" publish task is configured on the state machine
    Given eid in exec_status
    When a running execution publishes a message to the "SNS" topic and succeeds
    When an "SNS" publish task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a running execution publishes a message to the "SNS" topic and succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution publishes a message to the "SNS" topic and succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an "SNS" topic is created then an "SNS" publish task is configured on the state machine
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an "SNS" topic is created
    When an "SNS" publish task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an "SNS" publish task is configured on the state machine then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an "SNS" publish task is configured on the state machine
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution publishes a message to the "SNS" topic and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a running execution publishes a message to the "SNS" topic and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution publishes a message to the "SNS" topic and succeeds then an "SNS" topic is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution publishes a message to the "SNS" topic and succeeds
    When an "SNS" topic is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Step Functions state machine is created then an execution of the state machine is started
    Given tid not in topic_status
    When an "SNS" topic is created
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" publish task is configured on the state machine then a running execution publishes a message to the "SNS" topic and succeeds
    Given tid not in topic_status
    When an "SNS" topic is created
    When an "SNS" publish task is configured on the state machine
    When a running execution publishes a message to the "SNS" topic and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an execution of the state machine is started then a Step Functions state machine is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a running execution publishes a message to the "SNS" topic and succeeds then an "SNS" publish task is configured on the state machine
    Given tid not in topic_status
    When an "SNS" topic is created
    When a running execution publishes a message to the "SNS" topic and succeeds
    When an "SNS" publish task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" publish task is configured on the state machine then a Step Functions state machine is created then a running execution publishes a message to the "SNS" topic and succeeds
    Given smid in sm_status
    When an "SNS" publish task is configured on the state machine
    When a Step Functions state machine is created
    When a running execution publishes a message to the "SNS" topic and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" publish task is configured on the state machine then an "SNS" topic is created then a Step Functions state machine is created
    Given smid in sm_status
    When an "SNS" publish task is configured on the state machine
    When an "SNS" topic is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" publish task is configured on the state machine then an execution of the state machine is started then an "SNS" topic is created
    Given smid in sm_status
    When an "SNS" publish task is configured on the state machine
    When an execution of the state machine is started
    When an "SNS" topic is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an "SNS" publish task is configured on the state machine then a running execution publishes a message to the "SNS" topic and succeeds then an execution of the state machine is started
    Given smid in sm_status
    When an "SNS" publish task is configured on the state machine
    When a running execution publishes a message to the "SNS" topic and succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then an "SNS" topic is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When an "SNS" topic is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an "SNS" topic is created then an "SNS" publish task is configured on the state machine
    Given smid in sm_status
    When an execution of the state machine is started
    When an "SNS" topic is created
    When an "SNS" publish task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an "SNS" publish task is configured on the state machine then a running execution publishes a message to the "SNS" topic and succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When an "SNS" publish task is configured on the state machine
    When a running execution publishes a message to the "SNS" topic and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution publishes a message to the "SNS" topic and succeeds then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution publishes a message to the "SNS" topic and succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a running execution publishes a message to the "SNS" topic and succeeds then a Step Functions state machine is created then an "SNS" publish task is configured on the state machine
    Given eid in exec_status
    When a running execution publishes a message to the "SNS" topic and succeeds
    When a Step Functions state machine is created
    When an "SNS" publish task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a running execution publishes a message to the "SNS" topic and succeeds then an "SNS" topic is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution publishes a message to the "SNS" topic and succeeds
    When an "SNS" topic is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a running execution publishes a message to the "SNS" topic and succeeds then an "SNS" publish task is configured on the state machine then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution publishes a message to the "SNS" topic and succeeds
    When an "SNS" publish task is configured on the state machine
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @exhaustive @sequence
  Scenario: a running execution publishes a message to the "SNS" topic and succeeds then an execution of the state machine is started then an "SNS" topic is created
    Given eid in exec_status
    When a running execution publishes a message to the "SNS" topic and succeeds
    When an execution of the state machine is started
    When an "SNS" topic is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic
