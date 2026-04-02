@stepfunctionss3tables @generated
Feature: StepfunctionsS3tables - Action Sequences

  # Generated from FizzBee spec: stepfunctions_s3tables.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledATable

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "step functions" "state machine" is created then a "s3 tables" "table" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "s3 tables" "table" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a "s3 tables" "table" deletion is initiated
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "s3 tables" "table" deletion is initiated
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails because the S3 Tables table is being deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "s3 tables" "table" is created then a "step functions" "state machine" is created
    Given tid not in table_status
    When a "s3 tables" "table" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "s3 tables" "table" is created then a "s3 tables" "table" deletion is initiated
    Given tid not in table_status
    When a "s3 tables" "table" is created
    When a "s3 tables" "table" deletion is initiated
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "s3 tables" "table" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given tid not in table_status
    When a "s3 tables" "table" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "s3 tables" "table" is created then a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    Given tid not in table_status
    When a "s3 tables" "table" is created
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "s3 tables" "table" is created then a running "step functions" "execution" fails because the S3 Tables table is being deleted
    Given tid not in table_status
    When a "s3 tables" "table" is created
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "s3 tables" "table" deletion is initiated then a "step functions" "state machine" is created
    Given tid in table_status
    When a "s3 tables" "table" deletion is initiated
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "s3 tables" "table" deletion is initiated then a "s3 tables" "table" is created
    Given tid in table_status
    When a "s3 tables" "table" deletion is initiated
    When a "s3 tables" "table" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "s3 tables" "table" deletion is initiated then an "step functions" "execution" of the "step functions" "state machine" is started
    Given tid in table_status
    When a "s3 tables" "table" deletion is initiated
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "s3 tables" "table" deletion is initiated then a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    Given tid in table_status
    When a "s3 tables" "table" deletion is initiated
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "s3 tables" "table" deletion is initiated then a running "step functions" "execution" fails because the S3 Tables table is being deleted
    Given tid in table_status
    When a "s3 tables" "table" deletion is initiated
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "s3 tables" "table" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "s3 tables" "table" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "s3 tables" "table" deletion is initiated
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "s3 tables" "table" deletion is initiated
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails because the S3 Tables table is being deleted
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds then a "s3 tables" "table" is created
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    When a "s3 tables" "table" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds then a "s3 tables" "table" deletion is initiated
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    When a "s3 tables" "table" deletion is initiated
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds then a running "step functions" "execution" fails because the S3 Tables table is being deleted
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the S3 Tables table is being deleted then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the S3 Tables table is being deleted then a "s3 tables" "table" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    When a "s3 tables" "table" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the S3 Tables table is being deleted then a "s3 tables" "table" deletion is initiated
    Given eid in exec_status
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    When a "s3 tables" "table" deletion is initiated
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the S3 Tables table is being deleted then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the S3 Tables table is being deleted then a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a "s3 tables" "table" is created then a "s3 tables" "table" deletion is initiated
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "s3 tables" "table" is created
    When a "s3 tables" "table" deletion is initiated
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a "s3 tables" "table" deletion is initiated then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "s3 tables" "table" deletion is initiated
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds then a running "step functions" "execution" fails because the S3 Tables table is being deleted
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails because the S3 Tables table is being deleted then a "s3 tables" "table" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    When a "s3 tables" "table" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "s3 tables" "table" is created then a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given tid not in table_status
    When a "s3 tables" "table" is created
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "s3 tables" "table" is created then a "s3 tables" "table" deletion is initiated then a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    Given tid not in table_status
    When a "s3 tables" "table" is created
    When a "s3 tables" "table" deletion is initiated
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "s3 tables" "table" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails because the S3 Tables table is being deleted
    Given tid not in table_status
    When a "s3 tables" "table" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "s3 tables" "table" is created then a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds then a "step functions" "state machine" is created
    Given tid not in table_status
    When a "s3 tables" "table" is created
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "s3 tables" "table" is created then a running "step functions" "execution" fails because the S3 Tables table is being deleted then a "s3 tables" "table" deletion is initiated
    Given tid not in table_status
    When a "s3 tables" "table" is created
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    When a "s3 tables" "table" deletion is initiated
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "s3 tables" "table" deletion is initiated then a "step functions" "state machine" is created then a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    Given tid in table_status
    When a "s3 tables" "table" deletion is initiated
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "s3 tables" "table" deletion is initiated then a "s3 tables" "table" is created then a running "step functions" "execution" fails because the S3 Tables table is being deleted
    Given tid in table_status
    When a "s3 tables" "table" deletion is initiated
    When a "s3 tables" "table" is created
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "s3 tables" "table" deletion is initiated then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given tid in table_status
    When a "s3 tables" "table" deletion is initiated
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "s3 tables" "table" deletion is initiated then a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds then a "s3 tables" "table" is created
    Given tid in table_status
    When a "s3 tables" "table" deletion is initiated
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    When a "s3 tables" "table" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a "s3 tables" "table" deletion is initiated then a running "step functions" "execution" fails because the S3 Tables table is being deleted then an "step functions" "execution" of the "step functions" "state machine" is started
    Given tid in table_status
    When a "s3 tables" "table" deletion is initiated
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created then a running "step functions" "execution" fails because the S3 Tables table is being deleted
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "s3 tables" "table" is created then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "s3 tables" "table" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "s3 tables" "table" deletion is initiated then a "s3 tables" "table" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "s3 tables" "table" deletion is initiated
    When a "s3 tables" "table" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds then a "s3 tables" "table" deletion is initiated
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    When a "s3 tables" "table" deletion is initiated
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails because the S3 Tables table is being deleted then a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds then a "step functions" "state machine" is created then a "s3 tables" "table" is created
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    When a "step functions" "state machine" is created
    When a "s3 tables" "table" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds then a "s3 tables" "table" is created then a "s3 tables" "table" deletion is initiated
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    When a "s3 tables" "table" is created
    When a "s3 tables" "table" deletion is initiated
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds then a "s3 tables" "table" deletion is initiated then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    When a "s3 tables" "table" deletion is initiated
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails because the S3 Tables table is being deleted
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds then a running "step functions" "execution" fails because the S3 Tables table is being deleted then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the S3 Tables table is being deleted then a "step functions" "state machine" is created then a "s3 tables" "table" deletion is initiated
    Given eid in exec_status
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    When a "step functions" "state machine" is created
    When a "s3 tables" "table" deletion is initiated
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the S3 Tables table is being deleted then a "s3 tables" "table" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    When a "s3 tables" "table" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the S3 Tables table is being deleted then a "s3 tables" "table" deletion is initiated then a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    When a "s3 tables" "table" deletion is initiated
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the S3 Tables table is being deleted then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the S3 Tables table is being deleted then a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds then a "s3 tables" "table" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    When a "s3 tables" "table" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called
