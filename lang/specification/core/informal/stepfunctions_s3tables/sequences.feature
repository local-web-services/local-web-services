@stepfunctionss3tables @generated
Feature: StepfunctionsS3tables - Action Sequences

  # Generated from FizzBee spec: stepfunctions_s3tables.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledATable

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an S3 Tables table is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a table deletion is initiated
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails because the S3 Tables table is being deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then a Step Functions state machine is created
    Given tid not in table_status
    When an S3 Tables table is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then a table deletion is initiated
    Given tid not in table_status
    When an S3 Tables table is created
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then an execution of the state machine is started
    Given tid not in table_status
    When an S3 Tables table is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given tid not in table_status
    When an S3 Tables table is created
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then a running execution fails because the S3 Tables table is being deleted
    Given tid not in table_status
    When an S3 Tables table is created
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a Step Functions state machine is created
    Given tid in table_status
    When a table deletion is initiated
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an S3 Tables table is created
    Given tid in table_status
    When a table deletion is initiated
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an execution of the state machine is started
    Given tid in table_status
    When a table deletion is initiated
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given tid in table_status
    When a table deletion is initiated
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a running execution fails because the S3 Tables table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an S3 Tables table is created
    Given smid in sm_status
    When an execution of the state machine is started
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a table deletion is initiated
    Given smid in sm_status
    When an execution of the state machine is started
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails because the S3 Tables table is being deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an S3 Tables table is created
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a table deletion is initiated
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a running execution fails because the S3 Tables table is being deleted
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then an S3 Tables table is created
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then a table deletion is initiated
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an S3 Tables table is created then a table deletion is initiated
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an S3 Tables table is created
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an S3 Tables table is created then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an S3 Tables table is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an S3 Tables table is created then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an S3 Tables table is created
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an S3 Tables table is created then a running execution fails because the S3 Tables table is being deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an S3 Tables table is created
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a table deletion is initiated then an S3 Tables table is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a table deletion is initiated
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a table deletion is initiated then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a table deletion is initiated
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a table deletion is initiated then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a table deletion is initiated
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a table deletion is initiated then a running execution fails because the S3 Tables table is being deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a table deletion is initiated
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then an S3 Tables table is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a table deletion is initiated
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution fails because the S3 Tables table is being deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an S3 Tables table is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a table deletion is initiated
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a running execution fails because the S3 Tables table is being deleted
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails because the S3 Tables table is being deleted then an S3 Tables table is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails because the S3 Tables table is being deleted
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails because the S3 Tables table is being deleted then a table deletion is initiated
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails because the S3 Tables table is being deleted
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails because the S3 Tables table is being deleted then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails because the S3 Tables table is being deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails because the S3 Tables table is being deleted then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails because the S3 Tables table is being deleted
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then a Step Functions state machine is created then a table deletion is initiated
    Given tid not in table_status
    When an S3 Tables table is created
    When a Step Functions state machine is created
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then a Step Functions state machine is created then an execution of the state machine is started
    Given tid not in table_status
    When an S3 Tables table is created
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then a Step Functions state machine is created then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given tid not in table_status
    When an S3 Tables table is created
    When a Step Functions state machine is created
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then a Step Functions state machine is created then a running execution fails because the S3 Tables table is being deleted
    Given tid not in table_status
    When an S3 Tables table is created
    When a Step Functions state machine is created
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then a table deletion is initiated then a Step Functions state machine is created
    Given tid not in table_status
    When an S3 Tables table is created
    When a table deletion is initiated
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then a table deletion is initiated then an execution of the state machine is started
    Given tid not in table_status
    When an S3 Tables table is created
    When a table deletion is initiated
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then a table deletion is initiated then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given tid not in table_status
    When an S3 Tables table is created
    When a table deletion is initiated
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then a table deletion is initiated then a running execution fails because the S3 Tables table is being deleted
    Given tid not in table_status
    When an S3 Tables table is created
    When a table deletion is initiated
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then an execution of the state machine is started then a Step Functions state machine is created
    Given tid not in table_status
    When an S3 Tables table is created
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then an execution of the state machine is started then a table deletion is initiated
    Given tid not in table_status
    When an S3 Tables table is created
    When an execution of the state machine is started
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then an execution of the state machine is started then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given tid not in table_status
    When an S3 Tables table is created
    When an execution of the state machine is started
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then an execution of the state machine is started then a running execution fails because the S3 Tables table is being deleted
    Given tid not in table_status
    When an S3 Tables table is created
    When an execution of the state machine is started
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a Step Functions state machine is created
    Given tid not in table_status
    When an S3 Tables table is created
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a table deletion is initiated
    Given tid not in table_status
    When an S3 Tables table is created
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an execution of the state machine is started
    Given tid not in table_status
    When an S3 Tables table is created
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a running execution fails because the S3 Tables table is being deleted
    Given tid not in table_status
    When an S3 Tables table is created
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then a running execution fails because the S3 Tables table is being deleted then a Step Functions state machine is created
    Given tid not in table_status
    When an S3 Tables table is created
    When a running execution fails because the S3 Tables table is being deleted
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then a running execution fails because the S3 Tables table is being deleted then a table deletion is initiated
    Given tid not in table_status
    When an S3 Tables table is created
    When a running execution fails because the S3 Tables table is being deleted
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then a running execution fails because the S3 Tables table is being deleted then an execution of the state machine is started
    Given tid not in table_status
    When an S3 Tables table is created
    When a running execution fails because the S3 Tables table is being deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an S3 Tables table is created then a running execution fails because the S3 Tables table is being deleted then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given tid not in table_status
    When an S3 Tables table is created
    When a running execution fails because the S3 Tables table is being deleted
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a Step Functions state machine is created then an S3 Tables table is created
    Given tid in table_status
    When a table deletion is initiated
    When a Step Functions state machine is created
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a Step Functions state machine is created then an execution of the state machine is started
    Given tid in table_status
    When a table deletion is initiated
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a Step Functions state machine is created then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given tid in table_status
    When a table deletion is initiated
    When a Step Functions state machine is created
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a Step Functions state machine is created then a running execution fails because the S3 Tables table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When a Step Functions state machine is created
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an S3 Tables table is created then a Step Functions state machine is created
    Given tid in table_status
    When a table deletion is initiated
    When an S3 Tables table is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an S3 Tables table is created then an execution of the state machine is started
    Given tid in table_status
    When a table deletion is initiated
    When an S3 Tables table is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an S3 Tables table is created then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given tid in table_status
    When a table deletion is initiated
    When an S3 Tables table is created
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an S3 Tables table is created then a running execution fails because the S3 Tables table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When an S3 Tables table is created
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an execution of the state machine is started then a Step Functions state machine is created
    Given tid in table_status
    When a table deletion is initiated
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an execution of the state machine is started then an S3 Tables table is created
    Given tid in table_status
    When a table deletion is initiated
    When an execution of the state machine is started
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an execution of the state machine is started then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given tid in table_status
    When a table deletion is initiated
    When an execution of the state machine is started
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an execution of the state machine is started then a running execution fails because the S3 Tables table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When an execution of the state machine is started
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a Step Functions state machine is created
    Given tid in table_status
    When a table deletion is initiated
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an S3 Tables table is created
    Given tid in table_status
    When a table deletion is initiated
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an execution of the state machine is started
    Given tid in table_status
    When a table deletion is initiated
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a running execution fails because the S3 Tables table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a running execution fails because the S3 Tables table is being deleted then a Step Functions state machine is created
    Given tid in table_status
    When a table deletion is initiated
    When a running execution fails because the S3 Tables table is being deleted
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a running execution fails because the S3 Tables table is being deleted then an S3 Tables table is created
    Given tid in table_status
    When a table deletion is initiated
    When a running execution fails because the S3 Tables table is being deleted
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a running execution fails because the S3 Tables table is being deleted then an execution of the state machine is started
    Given tid in table_status
    When a table deletion is initiated
    When a running execution fails because the S3 Tables table is being deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a running execution fails because the S3 Tables table is being deleted then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given tid in table_status
    When a table deletion is initiated
    When a running execution fails because the S3 Tables table is being deleted
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then an S3 Tables table is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a table deletion is initiated
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution fails because the S3 Tables table is being deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an S3 Tables table is created then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When an S3 Tables table is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an S3 Tables table is created then a table deletion is initiated
    Given smid in sm_status
    When an execution of the state machine is started
    When an S3 Tables table is created
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an S3 Tables table is created then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When an S3 Tables table is created
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an S3 Tables table is created then a running execution fails because the S3 Tables table is being deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When an S3 Tables table is created
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a table deletion is initiated then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a table deletion is initiated
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a table deletion is initiated then an S3 Tables table is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a table deletion is initiated
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a table deletion is initiated then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a table deletion is initiated
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a table deletion is initiated then a running execution fails because the S3 Tables table is being deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When a table deletion is initiated
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an S3 Tables table is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a table deletion is initiated
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a running execution fails because the S3 Tables table is being deleted
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails because the S3 Tables table is being deleted then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails because the S3 Tables table is being deleted
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails because the S3 Tables table is being deleted then an S3 Tables table is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails because the S3 Tables table is being deleted
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails because the S3 Tables table is being deleted then a table deletion is initiated
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails because the S3 Tables table is being deleted
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails because the S3 Tables table is being deleted then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails because the S3 Tables table is being deleted
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a Step Functions state machine is created then an S3 Tables table is created
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a Step Functions state machine is created
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a Step Functions state machine is created then a table deletion is initiated
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a Step Functions state machine is created
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a Step Functions state machine is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a Step Functions state machine is created then a running execution fails because the S3 Tables table is being deleted
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a Step Functions state machine is created
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an S3 Tables table is created then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When an S3 Tables table is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an S3 Tables table is created then a table deletion is initiated
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When an S3 Tables table is created
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an S3 Tables table is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When an S3 Tables table is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an S3 Tables table is created then a running execution fails because the S3 Tables table is being deleted
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When an S3 Tables table is created
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a table deletion is initiated then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a table deletion is initiated
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a table deletion is initiated then an S3 Tables table is created
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a table deletion is initiated
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a table deletion is initiated then an execution of the state machine is started
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a table deletion is initiated
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a table deletion is initiated then a running execution fails because the S3 Tables table is being deleted
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a table deletion is initiated
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an execution of the state machine is started then an S3 Tables table is created
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When an execution of the state machine is started
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an execution of the state machine is started then a table deletion is initiated
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When an execution of the state machine is started
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an execution of the state machine is started then a running execution fails because the S3 Tables table is being deleted
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When an execution of the state machine is started
    When a running execution fails because the S3 Tables table is being deleted
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a running execution fails because the S3 Tables table is being deleted then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a running execution fails because the S3 Tables table is being deleted
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a running execution fails because the S3 Tables table is being deleted then an S3 Tables table is created
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a running execution fails because the S3 Tables table is being deleted
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a running execution fails because the S3 Tables table is being deleted then a table deletion is initiated
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a running execution fails because the S3 Tables table is being deleted
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a running execution fails because the S3 Tables table is being deleted then an execution of the state machine is started
    Given eid in exec_status
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a running execution fails because the S3 Tables table is being deleted
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then a Step Functions state machine is created then an S3 Tables table is created
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When a Step Functions state machine is created
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then a Step Functions state machine is created then a table deletion is initiated
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When a Step Functions state machine is created
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then a Step Functions state machine is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then a Step Functions state machine is created then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When a Step Functions state machine is created
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then an S3 Tables table is created then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When an S3 Tables table is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then an S3 Tables table is created then a table deletion is initiated
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When an S3 Tables table is created
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then an S3 Tables table is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When an S3 Tables table is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then an S3 Tables table is created then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When an S3 Tables table is created
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then a table deletion is initiated then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When a table deletion is initiated
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then a table deletion is initiated then an S3 Tables table is created
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When a table deletion is initiated
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then a table deletion is initiated then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When a table deletion is initiated
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then a table deletion is initiated then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When a table deletion is initiated
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then an execution of the state machine is started then an S3 Tables table is created
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When an execution of the state machine is started
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then an execution of the state machine is started then a table deletion is initiated
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When an execution of the state machine is started
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then an execution of the state machine is started then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When an execution of the state machine is started
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an S3 Tables table is created
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When an S3 Tables table is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then a table deletion is initiated
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When a table deletion is initiated
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @exhaustive @sequence
  Scenario: a running execution fails because the S3 Tables table is being deleted then a running execution calls an "ACTIVE" S3 Tables table and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails because the S3 Tables table is being deleted
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called
