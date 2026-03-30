@stepfunctionss3tables @generated
Feature: StepfunctionsS3tables - Action Sequences

  # Generated from FizzBee spec: stepfunctions_s3tables.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledATable

  Background:
    Given the system is initialized

  @sequence
  Scenario: a Step Functions state machine is created then an S3 Tables table is created
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an S3 Tables table is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a Step Functions state machine is created then a table deletion is initiated
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a table deletion is initiated
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a Step Functions state machine is created then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a Step Functions state machine is created then a running execution fails because the S3 Tables table is being deleted
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution fails because the S3 Tables table is being deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: an S3 Tables table is created then a Step Functions state machine is created
    Given tid not in table_status
    Given an S3 Tables table has been created
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: an S3 Tables table is created then a table deletion is initiated
    Given tid not in table_status
    Given an S3 Tables table has been created
    When a table deletion is initiated
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: an S3 Tables table is created then an execution of the state machine is started
    Given tid not in table_status
    Given an S3 Tables table has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: an S3 Tables table is created then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given tid not in table_status
    Given an S3 Tables table has been created
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: an S3 Tables table is created then a running execution fails because the S3 Tables table is being deleted
    Given tid not in table_status
    Given an S3 Tables table has been created
    When a running execution fails because the S3 Tables table is being deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a table deletion is initiated then a Step Functions state machine is created
    Given tid in table_status
    Given a table deletion has been initiated
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a table deletion is initiated then an S3 Tables table is created
    Given tid in table_status
    Given a table deletion has been initiated
    When an S3 Tables table is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a table deletion is initiated then an execution of the state machine is started
    Given tid in table_status
    Given a table deletion has been initiated
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a table deletion is initiated then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given tid in table_status
    Given a table deletion has been initiated
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a table deletion is initiated then a running execution fails because the S3 Tables table is being deleted
    Given tid in table_status
    Given a table deletion has been initiated
    When a running execution fails because the S3 Tables table is being deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: an execution of the state machine is started then an S3 Tables table is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    When an S3 Tables table is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: an execution of the state machine is started then a table deletion is initiated
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a table deletion is initiated
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: an execution of the state machine is started then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: an execution of the state machine is started then a running execution fails because the S3 Tables table is being deleted
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution fails because the S3 Tables table is being deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" S3 Tables table and the task succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an S3 Tables table is created
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" S3 Tables table and the task succeeded
    When an S3 Tables table is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a table deletion is initiated
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" S3 Tables table and the task succeeded
    When a table deletion is initiated
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" S3 Tables table and the task succeeded
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a running execution fails because the S3 Tables table is being deleted
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" S3 Tables table and the task succeeded
    When a running execution fails because the S3 Tables table is being deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has failed because the S3 Tables table is being deleted
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then an S3 Tables table is created
    Given eid in exec_status
    Given a running execution has failed because the S3 Tables table is being deleted
    When an S3 Tables table is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then a table deletion is initiated
    Given eid in exec_status
    Given a running execution has failed because the S3 Tables table is being deleted
    When a table deletion is initiated
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has failed because the S3 Tables table is being deleted
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given eid in exec_status
    Given a running execution has failed because the S3 Tables table is being deleted
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a Step Functions state machine is created then an S3 Tables table is created then a table deletion is initiated
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an S3 Tables table has been created
    When a table deletion is initiated
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a Step Functions state machine is created then a table deletion is initiated then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a table deletion has been initiated
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an execution of the state machine has been started
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a Step Functions state machine is created then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a running execution fails because the S3 Tables table is being deleted
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has called an "ACTIVE" S3 Tables table and the task succeeded
    When a running execution fails because the S3 Tables table is being deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a Step Functions state machine is created then a running execution fails because the S3 Tables table is being deleted then an S3 Tables table is created
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has failed because the S3 Tables table is being deleted
    When an S3 Tables table is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: an S3 Tables table is created then a Step Functions state machine is created then an execution of the state machine is started
    Given tid not in table_status
    Given an S3 Tables table has been created
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: an S3 Tables table is created then a table deletion is initiated then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given tid not in table_status
    Given an S3 Tables table has been created
    Given a table deletion has been initiated
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: an S3 Tables table is created then an execution of the state machine is started then a running execution fails because the S3 Tables table is being deleted
    Given tid not in table_status
    Given an S3 Tables table has been created
    Given an execution of the state machine has been started
    When a running execution fails because the S3 Tables table is being deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: an S3 Tables table is created then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a Step Functions state machine is created
    Given tid not in table_status
    Given an S3 Tables table has been created
    Given a running execution has called an "ACTIVE" S3 Tables table and the task succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: an S3 Tables table is created then a running execution fails because the S3 Tables table is being deleted then a table deletion is initiated
    Given tid not in table_status
    Given an S3 Tables table has been created
    Given a running execution has failed because the S3 Tables table is being deleted
    When a table deletion is initiated
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a table deletion is initiated then a Step Functions state machine is created then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given tid in table_status
    Given a table deletion has been initiated
    Given a Step Functions state machine has been created
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a table deletion is initiated then an S3 Tables table is created then a running execution fails because the S3 Tables table is being deleted
    Given tid in table_status
    Given a table deletion has been initiated
    Given an S3 Tables table has been created
    When a running execution fails because the S3 Tables table is being deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a table deletion is initiated then an execution of the state machine is started then a Step Functions state machine is created
    Given tid in table_status
    Given a table deletion has been initiated
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a table deletion is initiated then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an S3 Tables table is created
    Given tid in table_status
    Given a table deletion has been initiated
    Given a running execution has called an "ACTIVE" S3 Tables table and the task succeeded
    When an S3 Tables table is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a table deletion is initiated then a running execution fails because the S3 Tables table is being deleted then an execution of the state machine is started
    Given tid in table_status
    Given a table deletion has been initiated
    Given a running execution has failed because the S3 Tables table is being deleted
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution fails because the S3 Tables table is being deleted
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a Step Functions state machine has been created
    When a running execution fails because the S3 Tables table is being deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: an execution of the state machine is started then an S3 Tables table is created then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given an S3 Tables table has been created
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: an execution of the state machine is started then a table deletion is initiated then an S3 Tables table is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a table deletion has been initiated
    When an S3 Tables table is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: an execution of the state machine is started then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a table deletion is initiated
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has called an "ACTIVE" S3 Tables table and the task succeeded
    When a table deletion is initiated
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: an execution of the state machine is started then a running execution fails because the S3 Tables table is being deleted then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has failed because the S3 Tables table is being deleted
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a Step Functions state machine is created then an S3 Tables table is created
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" S3 Tables table and the task succeeded
    Given a Step Functions state machine has been created
    When an S3 Tables table is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an S3 Tables table is created then a table deletion is initiated
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" S3 Tables table and the task succeeded
    Given an S3 Tables table has been created
    When a table deletion is initiated
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a table deletion is initiated then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" S3 Tables table and the task succeeded
    Given a table deletion has been initiated
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an execution of the state machine is started then a running execution fails because the S3 Tables table is being deleted
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" S3 Tables table and the task succeeded
    Given an execution of the state machine has been started
    When a running execution fails because the S3 Tables table is being deleted
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a running execution fails because the S3 Tables table is being deleted then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" S3 Tables table and the task succeeded
    Given a running execution has failed because the S3 Tables table is being deleted
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then a Step Functions state machine is created then a table deletion is initiated
    Given eid in exec_status
    Given a running execution has failed because the S3 Tables table is being deleted
    Given a Step Functions state machine has been created
    When a table deletion is initiated
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then an S3 Tables table is created then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has failed because the S3 Tables table is being deleted
    Given an S3 Tables table has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then a table deletion is initiated then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given eid in exec_status
    Given a running execution has failed because the S3 Tables table is being deleted
    Given a table deletion has been initiated
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has failed because the S3 Tables table is being deleted
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an S3 Tables table is created
    Given eid in exec_status
    Given a running execution has failed because the S3 Tables table is being deleted
    Given a running execution has called an "ACTIVE" S3 Tables table and the task succeeded
    When an S3 Tables table is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called
