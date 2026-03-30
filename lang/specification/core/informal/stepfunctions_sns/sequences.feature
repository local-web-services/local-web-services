@stepfunctionssns @generated
Feature: StepfunctionsSns - Action Sequences

  # Generated from FizzBee spec: stepfunctions_sns.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ExecutionRequiresActiveTopic

  Background:
    Given the system is initialized

  @sequence
  Scenario: a Step Functions state machine is created then an "SNS" topic is created
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an "SNS" topic is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a Step Functions state machine is created then an "SNS" publish task is configured on the state machine
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an "SNS" publish task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a Step Functions state machine is created then a running execution publishes a message to the "SNS" topic and succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution publishes a message to the "SNS" topic and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" topic is created then a Step Functions state machine is created
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" topic is created then an "SNS" publish task is configured on the state machine
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When an "SNS" publish task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" topic is created then an execution of the state machine is started
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" topic is created then a running execution publishes a message to the "SNS" topic and succeeds
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When a running execution publishes a message to the "SNS" topic and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" publish task is configured on the state machine then a Step Functions state machine is created
    Given smid in sm_status
    Given an "SNS" publish task has been configured on the state machine
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" publish task is configured on the state machine then an "SNS" topic is created
    Given smid in sm_status
    Given an "SNS" publish task has been configured on the state machine
    When an "SNS" topic is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" publish task is configured on the state machine then an execution of the state machine is started
    Given smid in sm_status
    Given an "SNS" publish task has been configured on the state machine
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" publish task is configured on the state machine then a running execution publishes a message to the "SNS" topic and succeeds
    Given smid in sm_status
    Given an "SNS" publish task has been configured on the state machine
    When a running execution publishes a message to the "SNS" topic and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an execution of the state machine is started then an "SNS" topic is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    When an "SNS" topic is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an execution of the state machine is started then an "SNS" publish task is configured on the state machine
    Given smid in sm_status
    Given an execution of the state machine has been started
    When an "SNS" publish task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an execution of the state machine is started then a running execution publishes a message to the "SNS" topic and succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution publishes a message to the "SNS" topic and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a running execution publishes a message to the "SNS" topic and succeeds then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has published a message to the "SNS" topic and succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a running execution publishes a message to the "SNS" topic and succeeds then an "SNS" topic is created
    Given eid in exec_status
    Given a running execution has published a message to the "SNS" topic and succeeded
    When an "SNS" topic is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a running execution publishes a message to the "SNS" topic and succeeds then an "SNS" publish task is configured on the state machine
    Given eid in exec_status
    Given a running execution has published a message to the "SNS" topic and succeeded
    When an "SNS" publish task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a running execution publishes a message to the "SNS" topic and succeeds then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has published a message to the "SNS" topic and succeeded
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a Step Functions state machine is created then an "SNS" topic is created then an "SNS" publish task is configured on the state machine
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an "SNS" topic has been created
    When an "SNS" publish task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a Step Functions state machine is created then an "SNS" publish task is configured on the state machine then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an "SNS" publish task has been configured on the state machine
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution publishes a message to the "SNS" topic and succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an execution of the state machine has been started
    When a running execution publishes a message to the "SNS" topic and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a Step Functions state machine is created then a running execution publishes a message to the "SNS" topic and succeeds then an "SNS" topic is created
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has published a message to the "SNS" topic and succeeded
    When an "SNS" topic is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" topic is created then a Step Functions state machine is created then an execution of the state machine is started
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" topic is created then an "SNS" publish task is configured on the state machine then a running execution publishes a message to the "SNS" topic and succeeds
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given an "SNS" publish task has been configured on the state machine
    When a running execution publishes a message to the "SNS" topic and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" topic is created then an execution of the state machine is started then a Step Functions state machine is created
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" topic is created then a running execution publishes a message to the "SNS" topic and succeeds then an "SNS" publish task is configured on the state machine
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given a running execution has published a message to the "SNS" topic and succeeded
    When an "SNS" publish task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" publish task is configured on the state machine then a Step Functions state machine is created then a running execution publishes a message to the "SNS" topic and succeeds
    Given smid in sm_status
    Given an "SNS" publish task has been configured on the state machine
    Given a Step Functions state machine has been created
    When a running execution publishes a message to the "SNS" topic and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" publish task is configured on the state machine then an "SNS" topic is created then a Step Functions state machine is created
    Given smid in sm_status
    Given an "SNS" publish task has been configured on the state machine
    Given an "SNS" topic has been created
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" publish task is configured on the state machine then an execution of the state machine is started then an "SNS" topic is created
    Given smid in sm_status
    Given an "SNS" publish task has been configured on the state machine
    Given an execution of the state machine has been started
    When an "SNS" topic is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "SNS" publish task is configured on the state machine then a running execution publishes a message to the "SNS" topic and succeeds then an execution of the state machine is started
    Given smid in sm_status
    Given an "SNS" publish task has been configured on the state machine
    Given a running execution has published a message to the "SNS" topic and succeeded
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then an "SNS" topic is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a Step Functions state machine has been created
    When an "SNS" topic is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an execution of the state machine is started then an "SNS" topic is created then an "SNS" publish task is configured on the state machine
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given an "SNS" topic has been created
    When an "SNS" publish task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an execution of the state machine is started then an "SNS" publish task is configured on the state machine then a running execution publishes a message to the "SNS" topic and succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given an "SNS" publish task has been configured on the state machine
    When a running execution publishes a message to the "SNS" topic and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an execution of the state machine is started then a running execution publishes a message to the "SNS" topic and succeeds then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has published a message to the "SNS" topic and succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a running execution publishes a message to the "SNS" topic and succeeds then a Step Functions state machine is created then an "SNS" publish task is configured on the state machine
    Given eid in exec_status
    Given a running execution has published a message to the "SNS" topic and succeeded
    Given a Step Functions state machine has been created
    When an "SNS" publish task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a running execution publishes a message to the "SNS" topic and succeeds then an "SNS" topic is created then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has published a message to the "SNS" topic and succeeded
    Given an "SNS" topic has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a running execution publishes a message to the "SNS" topic and succeeds then an "SNS" publish task is configured on the state machine then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has published a message to the "SNS" topic and succeeded
    Given an "SNS" publish task has been configured on the state machine
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a running execution publishes a message to the "SNS" topic and succeeds then an execution of the state machine is started then an "SNS" topic is created
    Given eid in exec_status
    Given a running execution has published a message to the "SNS" topic and succeeded
    Given an execution of the state machine has been started
    When an "SNS" topic is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic
