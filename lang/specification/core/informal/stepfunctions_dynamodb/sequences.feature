@stepfunctionsdynamodb @generated
Feature: StepfunctionsDynamodb - Action Sequences

  # Generated from FizzBee spec: stepfunctions_dynamodb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ItemRequiresActiveTable

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a DynamoDB table is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a DynamoDB PutItem task is configured on the state machine
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution writes an item to the DynamoDB table and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution attempts to get an item that does not exist and the execution fails
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a Step Functions state machine is created
    Given tid not in table_status
    When a DynamoDB table is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a DynamoDB PutItem task is configured on the state machine
    Given tid not in table_status
    When a DynamoDB table is created
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an execution of the state machine is started
    Given tid not in table_status
    When a DynamoDB table is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a running execution writes an item to the DynamoDB table and succeeds
    Given tid not in table_status
    When a DynamoDB table is created
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a running execution attempts to get an item that does not exist and the execution fails
    Given tid not in table_status
    When a DynamoDB table is created
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a Step Functions state machine is created
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a DynamoDB table is created
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then an execution of the state machine is started
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a running execution writes an item to the DynamoDB table and succeeds
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a running execution attempts to get an item that does not exist and the execution fails
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a DynamoDB table is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a DynamoDB PutItem task is configured on the state machine
    Given smid in sm_status
    When an execution of the state machine is started
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution writes an item to the DynamoDB table and succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution attempts to get an item that does not exist and the execution fails
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB table is created
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB PutItem task is configured on the state machine
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a running execution attempts to get an item that does not exist and the execution fails
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB table is created
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB PutItem task is configured on the state machine
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then an execution of the state machine is started
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a running execution writes an item to the DynamoDB table and succeeds
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a DynamoDB table is created then a DynamoDB PutItem task is configured on the state machine
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a DynamoDB table is created
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a DynamoDB table is created then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a DynamoDB table is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a DynamoDB table is created then a running execution writes an item to the DynamoDB table and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a DynamoDB table is created
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a DynamoDB table is created then a running execution attempts to get an item that does not exist and the execution fails
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a DynamoDB table is created
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a DynamoDB PutItem task is configured on the state machine then a DynamoDB table is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a DynamoDB PutItem task is configured on the state machine
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a DynamoDB PutItem task is configured on the state machine then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a DynamoDB PutItem task is configured on the state machine
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a DynamoDB PutItem task is configured on the state machine then a running execution writes an item to the DynamoDB table and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a DynamoDB PutItem task is configured on the state machine
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a DynamoDB PutItem task is configured on the state machine then a running execution attempts to get an item that does not exist and the execution fails
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a DynamoDB PutItem task is configured on the state machine
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a DynamoDB table is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a DynamoDB PutItem task is configured on the state machine
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution writes an item to the DynamoDB table and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution attempts to get an item that does not exist and the execution fails
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB table is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution writes an item to the DynamoDB table and succeeds
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB PutItem task is configured on the state machine
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution writes an item to the DynamoDB table and succeeds
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution writes an item to the DynamoDB table and succeeds then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution writes an item to the DynamoDB table and succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution writes an item to the DynamoDB table and succeeds then a running execution attempts to get an item that does not exist and the execution fails
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution writes an item to the DynamoDB table and succeeds
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB table is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution attempts to get an item that does not exist and the execution fails
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB PutItem task is configured on the state machine
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution attempts to get an item that does not exist and the execution fails
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution attempts to get an item that does not exist and the execution fails then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution attempts to get an item that does not exist and the execution fails
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution attempts to get an item that does not exist and the execution fails then a running execution writes an item to the DynamoDB table and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution attempts to get an item that does not exist and the execution fails
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a Step Functions state machine is created then a DynamoDB PutItem task is configured on the state machine
    Given tid not in table_status
    When a DynamoDB table is created
    When a Step Functions state machine is created
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a Step Functions state machine is created then an execution of the state machine is started
    Given tid not in table_status
    When a DynamoDB table is created
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a Step Functions state machine is created then a running execution writes an item to the DynamoDB table and succeeds
    Given tid not in table_status
    When a DynamoDB table is created
    When a Step Functions state machine is created
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a Step Functions state machine is created then a running execution attempts to get an item that does not exist and the execution fails
    Given tid not in table_status
    When a DynamoDB table is created
    When a Step Functions state machine is created
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a DynamoDB PutItem task is configured on the state machine then a Step Functions state machine is created
    Given tid not in table_status
    When a DynamoDB table is created
    When a DynamoDB PutItem task is configured on the state machine
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a DynamoDB PutItem task is configured on the state machine then an execution of the state machine is started
    Given tid not in table_status
    When a DynamoDB table is created
    When a DynamoDB PutItem task is configured on the state machine
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a DynamoDB PutItem task is configured on the state machine then a running execution writes an item to the DynamoDB table and succeeds
    Given tid not in table_status
    When a DynamoDB table is created
    When a DynamoDB PutItem task is configured on the state machine
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a DynamoDB PutItem task is configured on the state machine then a running execution attempts to get an item that does not exist and the execution fails
    Given tid not in table_status
    When a DynamoDB table is created
    When a DynamoDB PutItem task is configured on the state machine
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an execution of the state machine is started then a Step Functions state machine is created
    Given tid not in table_status
    When a DynamoDB table is created
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an execution of the state machine is started then a DynamoDB PutItem task is configured on the state machine
    Given tid not in table_status
    When a DynamoDB table is created
    When an execution of the state machine is started
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an execution of the state machine is started then a running execution writes an item to the DynamoDB table and succeeds
    Given tid not in table_status
    When a DynamoDB table is created
    When an execution of the state machine is started
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an execution of the state machine is started then a running execution attempts to get an item that does not exist and the execution fails
    Given tid not in table_status
    When a DynamoDB table is created
    When an execution of the state machine is started
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a running execution writes an item to the DynamoDB table and succeeds then a Step Functions state machine is created
    Given tid not in table_status
    When a DynamoDB table is created
    When a running execution writes an item to the DynamoDB table and succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB PutItem task is configured on the state machine
    Given tid not in table_status
    When a DynamoDB table is created
    When a running execution writes an item to the DynamoDB table and succeeds
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a running execution writes an item to the DynamoDB table and succeeds then an execution of the state machine is started
    Given tid not in table_status
    When a DynamoDB table is created
    When a running execution writes an item to the DynamoDB table and succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a running execution writes an item to the DynamoDB table and succeeds then a running execution attempts to get an item that does not exist and the execution fails
    Given tid not in table_status
    When a DynamoDB table is created
    When a running execution writes an item to the DynamoDB table and succeeds
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a running execution attempts to get an item that does not exist and the execution fails then a Step Functions state machine is created
    Given tid not in table_status
    When a DynamoDB table is created
    When a running execution attempts to get an item that does not exist and the execution fails
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB PutItem task is configured on the state machine
    Given tid not in table_status
    When a DynamoDB table is created
    When a running execution attempts to get an item that does not exist and the execution fails
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a running execution attempts to get an item that does not exist and the execution fails then an execution of the state machine is started
    Given tid not in table_status
    When a DynamoDB table is created
    When a running execution attempts to get an item that does not exist and the execution fails
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a running execution attempts to get an item that does not exist and the execution fails then a running execution writes an item to the DynamoDB table and succeeds
    Given tid not in table_status
    When a DynamoDB table is created
    When a running execution attempts to get an item that does not exist and the execution fails
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a Step Functions state machine is created then a DynamoDB table is created
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When a Step Functions state machine is created
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a Step Functions state machine is created then an execution of the state machine is started
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a Step Functions state machine is created then a running execution writes an item to the DynamoDB table and succeeds
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When a Step Functions state machine is created
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a Step Functions state machine is created then a running execution attempts to get an item that does not exist and the execution fails
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When a Step Functions state machine is created
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a DynamoDB table is created then a Step Functions state machine is created
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When a DynamoDB table is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a DynamoDB table is created then an execution of the state machine is started
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When a DynamoDB table is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a DynamoDB table is created then a running execution writes an item to the DynamoDB table and succeeds
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When a DynamoDB table is created
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a DynamoDB table is created then a running execution attempts to get an item that does not exist and the execution fails
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When a DynamoDB table is created
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then an execution of the state machine is started then a DynamoDB table is created
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When an execution of the state machine is started
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then an execution of the state machine is started then a running execution writes an item to the DynamoDB table and succeeds
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When an execution of the state machine is started
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then an execution of the state machine is started then a running execution attempts to get an item that does not exist and the execution fails
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When an execution of the state machine is started
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a running execution writes an item to the DynamoDB table and succeeds then a Step Functions state machine is created
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When a running execution writes an item to the DynamoDB table and succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB table is created
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When a running execution writes an item to the DynamoDB table and succeeds
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a running execution writes an item to the DynamoDB table and succeeds then an execution of the state machine is started
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When a running execution writes an item to the DynamoDB table and succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a running execution writes an item to the DynamoDB table and succeeds then a running execution attempts to get an item that does not exist and the execution fails
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When a running execution writes an item to the DynamoDB table and succeeds
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a running execution attempts to get an item that does not exist and the execution fails then a Step Functions state machine is created
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When a running execution attempts to get an item that does not exist and the execution fails
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB table is created
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When a running execution attempts to get an item that does not exist and the execution fails
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a running execution attempts to get an item that does not exist and the execution fails then an execution of the state machine is started
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When a running execution attempts to get an item that does not exist and the execution fails
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a running execution attempts to get an item that does not exist and the execution fails then a running execution writes an item to the DynamoDB table and succeeds
    Given smid in sm_status
    When a DynamoDB PutItem task is configured on the state machine
    When a running execution attempts to get an item that does not exist and the execution fails
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a DynamoDB table is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a DynamoDB PutItem task is configured on the state machine
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution writes an item to the DynamoDB table and succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution attempts to get an item that does not exist and the execution fails
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a DynamoDB table is created then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a DynamoDB table is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a DynamoDB table is created then a DynamoDB PutItem task is configured on the state machine
    Given smid in sm_status
    When an execution of the state machine is started
    When a DynamoDB table is created
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a DynamoDB table is created then a running execution writes an item to the DynamoDB table and succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a DynamoDB table is created
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a DynamoDB table is created then a running execution attempts to get an item that does not exist and the execution fails
    Given smid in sm_status
    When an execution of the state machine is started
    When a DynamoDB table is created
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a DynamoDB PutItem task is configured on the state machine then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a DynamoDB PutItem task is configured on the state machine
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a DynamoDB PutItem task is configured on the state machine then a DynamoDB table is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a DynamoDB PutItem task is configured on the state machine
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a DynamoDB PutItem task is configured on the state machine then a running execution writes an item to the DynamoDB table and succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a DynamoDB PutItem task is configured on the state machine
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a DynamoDB PutItem task is configured on the state machine then a running execution attempts to get an item that does not exist and the execution fails
    Given smid in sm_status
    When an execution of the state machine is started
    When a DynamoDB PutItem task is configured on the state machine
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution writes an item to the DynamoDB table and succeeds then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution writes an item to the DynamoDB table and succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB table is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution writes an item to the DynamoDB table and succeeds
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB PutItem task is configured on the state machine
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution writes an item to the DynamoDB table and succeeds
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution writes an item to the DynamoDB table and succeeds then a running execution attempts to get an item that does not exist and the execution fails
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution writes an item to the DynamoDB table and succeeds
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution attempts to get an item that does not exist and the execution fails then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution attempts to get an item that does not exist and the execution fails
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB table is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution attempts to get an item that does not exist and the execution fails
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB PutItem task is configured on the state machine
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution attempts to get an item that does not exist and the execution fails
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution attempts to get an item that does not exist and the execution fails then a running execution writes an item to the DynamoDB table and succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution attempts to get an item that does not exist and the execution fails
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a Step Functions state machine is created then a DynamoDB table is created
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When a Step Functions state machine is created
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a Step Functions state machine is created then a DynamoDB PutItem task is configured on the state machine
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When a Step Functions state machine is created
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a Step Functions state machine is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a Step Functions state machine is created then a running execution attempts to get an item that does not exist and the execution fails
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When a Step Functions state machine is created
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB table is created then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When a DynamoDB table is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB table is created then a DynamoDB PutItem task is configured on the state machine
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When a DynamoDB table is created
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB table is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When a DynamoDB table is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB table is created then a running execution attempts to get an item that does not exist and the execution fails
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When a DynamoDB table is created
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB PutItem task is configured on the state machine then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When a DynamoDB PutItem task is configured on the state machine
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB PutItem task is configured on the state machine then a DynamoDB table is created
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When a DynamoDB PutItem task is configured on the state machine
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB PutItem task is configured on the state machine then an execution of the state machine is started
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When a DynamoDB PutItem task is configured on the state machine
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB PutItem task is configured on the state machine then a running execution attempts to get an item that does not exist and the execution fails
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When a DynamoDB PutItem task is configured on the state machine
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then an execution of the state machine is started then a DynamoDB table is created
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When an execution of the state machine is started
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then an execution of the state machine is started then a DynamoDB PutItem task is configured on the state machine
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When an execution of the state machine is started
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then an execution of the state machine is started then a running execution attempts to get an item that does not exist and the execution fails
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When an execution of the state machine is started
    When a running execution attempts to get an item that does not exist and the execution fails
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a running execution attempts to get an item that does not exist and the execution fails then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When a running execution attempts to get an item that does not exist and the execution fails
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB table is created
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When a running execution attempts to get an item that does not exist and the execution fails
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB PutItem task is configured on the state machine
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When a running execution attempts to get an item that does not exist and the execution fails
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a running execution attempts to get an item that does not exist and the execution fails then an execution of the state machine is started
    Given eid in exec_status
    When a running execution writes an item to the DynamoDB table and succeeds
    When a running execution attempts to get an item that does not exist and the execution fails
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a Step Functions state machine is created then a DynamoDB table is created
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When a Step Functions state machine is created
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a Step Functions state machine is created then a DynamoDB PutItem task is configured on the state machine
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When a Step Functions state machine is created
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a Step Functions state machine is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a Step Functions state machine is created then a running execution writes an item to the DynamoDB table and succeeds
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When a Step Functions state machine is created
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB table is created then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When a DynamoDB table is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB table is created then a DynamoDB PutItem task is configured on the state machine
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When a DynamoDB table is created
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB table is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When a DynamoDB table is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB table is created then a running execution writes an item to the DynamoDB table and succeeds
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When a DynamoDB table is created
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB PutItem task is configured on the state machine then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When a DynamoDB PutItem task is configured on the state machine
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB PutItem task is configured on the state machine then a DynamoDB table is created
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When a DynamoDB PutItem task is configured on the state machine
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB PutItem task is configured on the state machine then an execution of the state machine is started
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When a DynamoDB PutItem task is configured on the state machine
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB PutItem task is configured on the state machine then a running execution writes an item to the DynamoDB table and succeeds
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When a DynamoDB PutItem task is configured on the state machine
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then an execution of the state machine is started then a DynamoDB table is created
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When an execution of the state machine is started
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then an execution of the state machine is started then a DynamoDB PutItem task is configured on the state machine
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When an execution of the state machine is started
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then an execution of the state machine is started then a running execution writes an item to the DynamoDB table and succeeds
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When an execution of the state machine is started
    When a running execution writes an item to the DynamoDB table and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a running execution writes an item to the DynamoDB table and succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When a running execution writes an item to the DynamoDB table and succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB table is created
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When a running execution writes an item to the DynamoDB table and succeeds
    When a DynamoDB table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB PutItem task is configured on the state machine
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When a running execution writes an item to the DynamoDB table and succeeds
    When a DynamoDB PutItem task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @exhaustive @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a running execution writes an item to the DynamoDB table and succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution attempts to get an item that does not exist and the execution fails
    When a running execution writes an item to the DynamoDB table and succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table
