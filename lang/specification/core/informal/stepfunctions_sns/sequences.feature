@stepfunctionssns @generated
Feature: StepfunctionsSns - Action Sequences

  # Generated from FizzBee spec: stepfunctions_sns.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ExecutionRequiresActiveTopic

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "step functions" "state machine" is created then a "sns" "topic" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "sns" "topic" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a "step functions" "state machine" is created then a "SNS" publish task is configured on the state machine
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "SNS" publish task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a "sns" "topic" is created then a "step functions" "state machine" is created
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a "sns" "topic" is created then a "SNS" publish task is configured on the state machine
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "SNS" publish task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a "sns" "topic" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given tid not in topic_status
    When a "sns" "topic" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a "sns" "topic" is created then a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a "SNS" publish task is configured on the state machine then a "step functions" "state machine" is created
    Given smid in sm_status
    When a "SNS" publish task is configured on the state machine
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a "SNS" publish task is configured on the state machine then a "sns" "topic" is created
    Given smid in sm_status
    When a "SNS" publish task is configured on the state machine
    When a "sns" "topic" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a "SNS" publish task is configured on the state machine then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid in sm_status
    When a "SNS" publish task is configured on the state machine
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a "SNS" publish task is configured on the state machine then a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    Given smid in sm_status
    When a "SNS" publish task is configured on the state machine
    When a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "sns" "topic" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "sns" "topic" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "SNS" publish task is configured on the state machine
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "SNS" publish task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds then a "sns" "topic" is created
    Given eid in exec_status
    When a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    When a "sns" "topic" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds then a "SNS" publish task is configured on the state machine
    Given eid in exec_status
    When a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    When a "SNS" publish task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a "step functions" "state machine" is created then a "sns" "topic" is created then a "SNS" publish task is configured on the state machine
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "sns" "topic" is created
    When a "SNS" publish task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a "step functions" "state machine" is created then a "SNS" publish task is configured on the state machine then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "SNS" publish task is configured on the state machine
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds then a "sns" "topic" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    When a "sns" "topic" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a "sns" "topic" is created then a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a "sns" "topic" is created then a "SNS" publish task is configured on the state machine then a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "SNS" publish task is configured on the state machine
    When a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a "sns" "topic" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given tid not in topic_status
    When a "sns" "topic" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a "sns" "topic" is created then a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds then a "SNS" publish task is configured on the state machine
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    When a "SNS" publish task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a "SNS" publish task is configured on the state machine then a "step functions" "state machine" is created then a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    Given smid in sm_status
    When a "SNS" publish task is configured on the state machine
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a "SNS" publish task is configured on the state machine then a "sns" "topic" is created then a "step functions" "state machine" is created
    Given smid in sm_status
    When a "SNS" publish task is configured on the state machine
    When a "sns" "topic" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a "SNS" publish task is configured on the state machine then an "step functions" "execution" of the "step functions" "state machine" is started then a "sns" "topic" is created
    Given smid in sm_status
    When a "SNS" publish task is configured on the state machine
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "sns" "topic" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a "SNS" publish task is configured on the state machine then a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid in sm_status
    When a "SNS" publish task is configured on the state machine
    When a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created then a "sns" "topic" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    When a "sns" "topic" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "sns" "topic" is created then a "SNS" publish task is configured on the state machine
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "sns" "topic" is created
    When a "SNS" publish task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "SNS" publish task is configured on the state machine then a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "SNS" publish task is configured on the state machine
    When a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds then a "step functions" "state machine" is created then a "SNS" publish task is configured on the state machine
    Given eid in exec_status
    When a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    When a "step functions" "state machine" is created
    When a "SNS" publish task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds then a "sns" "topic" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    When a "sns" "topic" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds then a "SNS" publish task is configured on the state machine then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    When a "SNS" publish task is configured on the state machine
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic

  @sequence
  Scenario: a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds then an "step functions" "execution" of the "step functions" "state machine" is started then a "sns" "topic" is created
    Given eid in exec_status
    When a running "step functions" "execution" publishes a message to the "sns" "topic" and succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "sns" "topic" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution's state machine targets an "ACTIVE" topic
