@stepfunctionsdynamodb @generated
Feature: StepfunctionsDynamodb - Action Sequences

  # Generated from FizzBee spec: stepfunctions_dynamodb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ItemRequiresActiveTable

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "step functions" "state machine" is created then a "dynamodb" "table" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "dynamodb" "table" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "step functions" "state machine" is created then a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "table" is created then a "step functions" "state machine" is created
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "table" is created then a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "table" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "table" is created then a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "table" is created then a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "PutItem" task is configured on the "step functions" "state machine" then a "step functions" "state machine" is created
    Given smid in sm_status
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "PutItem" task is configured on the "step functions" "state machine" then a "dynamodb" "table" is created
    Given smid in sm_status
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    When a "dynamodb" "table" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "PutItem" task is configured on the "step functions" "state machine" then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid in sm_status
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "PutItem" task is configured on the "step functions" "state machine" then a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    Given smid in sm_status
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "PutItem" task is configured on the "step functions" "state machine" then a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    Given smid in sm_status
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "dynamodb" "table" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "dynamodb" "table" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds then a "dynamodb" "table" is created
    Given eid in exec_status
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    When a "dynamodb" "table" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds then a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    Given eid in exec_status
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds then a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    Given eid in exec_status
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a running "step functions" "execution" attempts to get an item that does not exist and the execution fails then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a running "step functions" "execution" attempts to get an item that does not exist and the execution fails then a "dynamodb" "table" is created
    Given eid in exec_status
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    When a "dynamodb" "table" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a running "step functions" "execution" attempts to get an item that does not exist and the execution fails then a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    Given eid in exec_status
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a running "step functions" "execution" attempts to get an item that does not exist and the execution fails then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a running "step functions" "execution" attempts to get an item that does not exist and the execution fails then a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    Given eid in exec_status
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "step functions" "state machine" is created then a "dynamodb" "table" is created then a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "dynamodb" "table" is created
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "step functions" "state machine" is created then a "dynamodb" "PutItem" task is configured on the "step functions" "state machine" then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds then a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" attempts to get an item that does not exist and the execution fails then a "dynamodb" "table" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    When a "dynamodb" "table" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "table" is created then a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "table" is created then a "dynamodb" "PutItem" task is configured on the "step functions" "state machine" then a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "table" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "table" is created then a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds then a "step functions" "state machine" is created
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "table" is created then a running "step functions" "execution" attempts to get an item that does not exist and the execution fails then a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "PutItem" task is configured on the "step functions" "state machine" then a "step functions" "state machine" is created then a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    Given smid in sm_status
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "PutItem" task is configured on the "step functions" "state machine" then a "dynamodb" "table" is created then a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    Given smid in sm_status
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    When a "dynamodb" "table" is created
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "PutItem" task is configured on the "step functions" "state machine" then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given smid in sm_status
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "PutItem" task is configured on the "step functions" "state machine" then a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds then a "dynamodb" "table" is created
    Given smid in sm_status
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    When a "dynamodb" "table" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a "dynamodb" "PutItem" task is configured on the "step functions" "state machine" then a running "step functions" "execution" attempts to get an item that does not exist and the execution fails then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid in sm_status
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created then a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "dynamodb" "table" is created then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "dynamodb" "table" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "dynamodb" "PutItem" task is configured on the "step functions" "state machine" then a "dynamodb" "table" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    When a "dynamodb" "table" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds then a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" attempts to get an item that does not exist and the execution fails then a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds then a "step functions" "state machine" is created then a "dynamodb" "table" is created
    Given eid in exec_status
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    When a "step functions" "state machine" is created
    When a "dynamodb" "table" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds then a "dynamodb" "table" is created then a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    Given eid in exec_status
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    When a "dynamodb" "table" is created
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds then a "dynamodb" "PutItem" task is configured on the "step functions" "state machine" then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    Given eid in exec_status
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds then a running "step functions" "execution" attempts to get an item that does not exist and the execution fails then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a running "step functions" "execution" attempts to get an item that does not exist and the execution fails then a "step functions" "state machine" is created then a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    Given eid in exec_status
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    When a "step functions" "state machine" is created
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a running "step functions" "execution" attempts to get an item that does not exist and the execution fails then a "dynamodb" "table" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    When a "dynamodb" "table" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a running "step functions" "execution" attempts to get an item that does not exist and the execution fails then a "dynamodb" "PutItem" task is configured on the "step functions" "state machine" then a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    Given eid in exec_status
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    When a "dynamodb" "PutItem" task is configured on the "step functions" "state machine"
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a running "step functions" "execution" attempts to get an item that does not exist and the execution fails then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"

  @sequence
  Scenario: a running "step functions" "execution" attempts to get an item that does not exist and the execution fails then a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds then a "dynamodb" "table" is created
    Given eid in exec_status
    When a running "step functions" "execution" attempts to get an item that does not exist and the execution fails
    When a running "step functions" "execution" writes an item to the "dynamodb" "table" and succeeds
    When a "dynamodb" "table" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"
