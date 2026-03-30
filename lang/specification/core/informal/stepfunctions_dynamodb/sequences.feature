@stepfunctionsdynamodb @generated
Feature: StepfunctionsDynamodb - Action Sequences

  # Generated from FizzBee spec: stepfunctions_dynamodb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ItemRequiresActiveTable

  Background:
    Given the system is initialized

  @sequence
  Scenario: a Step Functions state machine is created then a DynamoDB table is created
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a DynamoDB table is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a Step Functions state machine is created then a DynamoDB PutItem task is configured on the state machine
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a DynamoDB PutItem task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a Step Functions state machine is created then a running execution writes an item to the DynamoDB table and succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution writes an item to the DynamoDB table and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a Step Functions state machine is created then a running execution attempts to get an item that does not exist and the execution fails
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution attempts to get an item that does not exist and the execution fails
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a DynamoDB table is created then a Step Functions state machine is created
    Given tid not in table_status
    Given a DynamoDB table has been created
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a DynamoDB table is created then a DynamoDB PutItem task is configured on the state machine
    Given tid not in table_status
    Given a DynamoDB table has been created
    When a DynamoDB PutItem task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a DynamoDB table is created then an execution of the state machine is started
    Given tid not in table_status
    Given a DynamoDB table has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a DynamoDB table is created then a running execution writes an item to the DynamoDB table and succeeds
    Given tid not in table_status
    Given a DynamoDB table has been created
    When a running execution writes an item to the DynamoDB table and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a DynamoDB table is created then a running execution attempts to get an item that does not exist and the execution fails
    Given tid not in table_status
    Given a DynamoDB table has been created
    When a running execution attempts to get an item that does not exist and the execution fails
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a Step Functions state machine is created
    Given smid in sm_status
    Given a DynamoDB PutItem task has been configured on the state machine
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a DynamoDB table is created
    Given smid in sm_status
    Given a DynamoDB PutItem task has been configured on the state machine
    When a DynamoDB table is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then an execution of the state machine is started
    Given smid in sm_status
    Given a DynamoDB PutItem task has been configured on the state machine
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a running execution writes an item to the DynamoDB table and succeeds
    Given smid in sm_status
    Given a DynamoDB PutItem task has been configured on the state machine
    When a running execution writes an item to the DynamoDB table and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a running execution attempts to get an item that does not exist and the execution fails
    Given smid in sm_status
    Given a DynamoDB PutItem task has been configured on the state machine
    When a running execution attempts to get an item that does not exist and the execution fails
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: an execution of the state machine is started then a DynamoDB table is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a DynamoDB table is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: an execution of the state machine is started then a DynamoDB PutItem task is configured on the state machine
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a DynamoDB PutItem task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: an execution of the state machine is started then a running execution writes an item to the DynamoDB table and succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution writes an item to the DynamoDB table and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: an execution of the state machine is started then a running execution attempts to get an item that does not exist and the execution fails
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution attempts to get an item that does not exist and the execution fails
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has written an item to the DynamoDB table and succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB table is created
    Given eid in exec_status
    Given a running execution has written an item to the DynamoDB table and succeeded
    When a DynamoDB table is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB PutItem task is configured on the state machine
    Given eid in exec_status
    Given a running execution has written an item to the DynamoDB table and succeeded
    When a DynamoDB PutItem task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has written an item to the DynamoDB table and succeeded
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a running execution attempts to get an item that does not exist and the execution fails
    Given eid in exec_status
    Given a running execution has written an item to the DynamoDB table and succeeded
    When a running execution attempts to get an item that does not exist and the execution fails
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has attempted to get an item that does not exist and the execution failed
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB table is created
    Given eid in exec_status
    Given a running execution has attempted to get an item that does not exist and the execution failed
    When a DynamoDB table is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB PutItem task is configured on the state machine
    Given eid in exec_status
    Given a running execution has attempted to get an item that does not exist and the execution failed
    When a DynamoDB PutItem task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has attempted to get an item that does not exist and the execution failed
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a running execution writes an item to the DynamoDB table and succeeds
    Given eid in exec_status
    Given a running execution has attempted to get an item that does not exist and the execution failed
    When a running execution writes an item to the DynamoDB table and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a Step Functions state machine is created then a DynamoDB table is created then a DynamoDB PutItem task is configured on the state machine
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a DynamoDB table has been created
    When a DynamoDB PutItem task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a Step Functions state machine is created then a DynamoDB PutItem task is configured on the state machine then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a DynamoDB PutItem task has been configured on the state machine
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution writes an item to the DynamoDB table and succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an execution of the state machine has been started
    When a running execution writes an item to the DynamoDB table and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a Step Functions state machine is created then a running execution writes an item to the DynamoDB table and succeeds then a running execution attempts to get an item that does not exist and the execution fails
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has written an item to the DynamoDB table and succeeded
    When a running execution attempts to get an item that does not exist and the execution fails
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a Step Functions state machine is created then a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB table is created
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has attempted to get an item that does not exist and the execution failed
    When a DynamoDB table is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a DynamoDB table is created then a Step Functions state machine is created then an execution of the state machine is started
    Given tid not in table_status
    Given a DynamoDB table has been created
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a DynamoDB table is created then a DynamoDB PutItem task is configured on the state machine then a running execution writes an item to the DynamoDB table and succeeds
    Given tid not in table_status
    Given a DynamoDB table has been created
    Given a DynamoDB PutItem task has been configured on the state machine
    When a running execution writes an item to the DynamoDB table and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a DynamoDB table is created then an execution of the state machine is started then a running execution attempts to get an item that does not exist and the execution fails
    Given tid not in table_status
    Given a DynamoDB table has been created
    Given an execution of the state machine has been started
    When a running execution attempts to get an item that does not exist and the execution fails
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a DynamoDB table is created then a running execution writes an item to the DynamoDB table and succeeds then a Step Functions state machine is created
    Given tid not in table_status
    Given a DynamoDB table has been created
    Given a running execution has written an item to the DynamoDB table and succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a DynamoDB table is created then a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB PutItem task is configured on the state machine
    Given tid not in table_status
    Given a DynamoDB table has been created
    Given a running execution has attempted to get an item that does not exist and the execution failed
    When a DynamoDB PutItem task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a Step Functions state machine is created then a running execution writes an item to the DynamoDB table and succeeds
    Given smid in sm_status
    Given a DynamoDB PutItem task has been configured on the state machine
    Given a Step Functions state machine has been created
    When a running execution writes an item to the DynamoDB table and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a DynamoDB table is created then a running execution attempts to get an item that does not exist and the execution fails
    Given smid in sm_status
    Given a DynamoDB PutItem task has been configured on the state machine
    Given a DynamoDB table has been created
    When a running execution attempts to get an item that does not exist and the execution fails
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    Given a DynamoDB PutItem task has been configured on the state machine
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB table is created
    Given smid in sm_status
    Given a DynamoDB PutItem task has been configured on the state machine
    Given a running execution has written an item to the DynamoDB table and succeeded
    When a DynamoDB table is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a DynamoDB PutItem task is configured on the state machine then a running execution attempts to get an item that does not exist and the execution fails then an execution of the state machine is started
    Given smid in sm_status
    Given a DynamoDB PutItem task has been configured on the state machine
    Given a running execution has attempted to get an item that does not exist and the execution failed
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution attempts to get an item that does not exist and the execution fails
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a Step Functions state machine has been created
    When a running execution attempts to get an item that does not exist and the execution fails
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: an execution of the state machine is started then a DynamoDB table is created then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a DynamoDB table has been created
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: an execution of the state machine is started then a DynamoDB PutItem task is configured on the state machine then a DynamoDB table is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a DynamoDB PutItem task has been configured on the state machine
    When a DynamoDB table is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: an execution of the state machine is started then a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB PutItem task is configured on the state machine
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has written an item to the DynamoDB table and succeeded
    When a DynamoDB PutItem task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: an execution of the state machine is started then a running execution attempts to get an item that does not exist and the execution fails then a running execution writes an item to the DynamoDB table and succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has attempted to get an item that does not exist and the execution failed
    When a running execution writes an item to the DynamoDB table and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a Step Functions state machine is created then a DynamoDB table is created
    Given eid in exec_status
    Given a running execution has written an item to the DynamoDB table and succeeded
    Given a Step Functions state machine has been created
    When a DynamoDB table is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB table is created then a DynamoDB PutItem task is configured on the state machine
    Given eid in exec_status
    Given a running execution has written an item to the DynamoDB table and succeeded
    Given a DynamoDB table has been created
    When a DynamoDB PutItem task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB PutItem task is configured on the state machine then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has written an item to the DynamoDB table and succeeded
    Given a DynamoDB PutItem task has been configured on the state machine
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then an execution of the state machine is started then a running execution attempts to get an item that does not exist and the execution fails
    Given eid in exec_status
    Given a running execution has written an item to the DynamoDB table and succeeded
    Given an execution of the state machine has been started
    When a running execution attempts to get an item that does not exist and the execution fails
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a running execution writes an item to the DynamoDB table and succeeds then a running execution attempts to get an item that does not exist and the execution fails then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has written an item to the DynamoDB table and succeeded
    Given a running execution has attempted to get an item that does not exist and the execution failed
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a Step Functions state machine is created then a DynamoDB PutItem task is configured on the state machine
    Given eid in exec_status
    Given a running execution has attempted to get an item that does not exist and the execution failed
    Given a Step Functions state machine has been created
    When a DynamoDB PutItem task is configured on the state machine
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB table is created then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has attempted to get an item that does not exist and the execution failed
    Given a DynamoDB table has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a DynamoDB PutItem task is configured on the state machine then a running execution writes an item to the DynamoDB table and succeeds
    Given eid in exec_status
    Given a running execution has attempted to get an item that does not exist and the execution failed
    Given a DynamoDB PutItem task has been configured on the state machine
    When a running execution writes an item to the DynamoDB table and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has attempted to get an item that does not exist and the execution failed
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table

  @sequence
  Scenario: a running execution attempts to get an item that does not exist and the execution fails then a running execution writes an item to the DynamoDB table and succeeds then a DynamoDB table is created
    Given eid in exec_status
    Given a running execution has attempted to get an item that does not exist and the execution failed
    Given a running execution has written an item to the DynamoDB table and succeeded
    When a DynamoDB table is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every existing item belongs to an "ACTIVE" table
