@stepfunctionsrds @generated
Feature: StepfunctionsRds - Action Sequences

  # Generated from FizzBee spec: stepfunctions_rds.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedADB

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "step functions" "state machine" is created then a "RDS" "DB" instance is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a "step functions" "state machine" is created then a Multi-"AZ" failover begins on the "DB" instance
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a "step functions" "state machine" is created then the "DB" instance failover completes
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails to query the "DB" because it is failing over
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a "RDS" "DB" instance is created then a "step functions" "state machine" is created
    Given dbid not in db_status
    When a "RDS" "DB" instance is created
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a "RDS" "DB" instance is created then a Multi-"AZ" failover begins on the "DB" instance
    Given dbid not in db_status
    When a "RDS" "DB" instance is created
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a "RDS" "DB" instance is created then the "DB" instance failover completes
    Given dbid not in db_status
    When a "RDS" "DB" instance is created
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a "RDS" "DB" instance is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given dbid not in db_status
    When a "RDS" "DB" instance is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a "RDS" "DB" instance is created then a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid not in db_status
    When a "RDS" "DB" instance is created
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a "RDS" "DB" instance is created then a running "step functions" "execution" fails to query the "DB" because it is failing over
    Given dbid not in db_status
    When a "RDS" "DB" instance is created
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a "step functions" "state machine" is created
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a "RDS" "DB" instance is created
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then the "DB" instance failover completes
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then an "step functions" "execution" of the "step functions" "state machine" is started
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a running "step functions" "execution" fails to query the "DB" because it is failing over
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then a "step functions" "state machine" is created
    Given dbid in db_status
    When the "DB" instance failover completes
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then a "RDS" "DB" instance is created
    Given dbid in db_status
    When the "DB" instance failover completes
    When a "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then a Multi-"AZ" failover begins on the "DB" instance
    Given dbid in db_status
    When the "DB" instance failover completes
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then an "step functions" "execution" of the "step functions" "state machine" is started
    Given dbid in db_status
    When the "DB" instance failover completes
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid in db_status
    When the "DB" instance failover completes
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then a running "step functions" "execution" fails to query the "DB" because it is failing over
    Given dbid in db_status
    When the "DB" instance failover completes
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "RDS" "DB" instance is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a Multi-"AZ" failover begins on the "DB" instance
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the "DB" instance failover completes
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to query the "DB" because it is failing over
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds then a "RDS" "DB" instance is created
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    When a "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds then a Multi-"AZ" failover begins on the "DB" instance
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds then the "DB" instance failover completes
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds then a running "step functions" "execution" fails to query the "DB" because it is failing over
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query the "DB" because it is failing over then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query the "DB" because it is failing over then a "RDS" "DB" instance is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    When a "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query the "DB" because it is failing over then a Multi-"AZ" failover begins on the "DB" instance
    Given eid in exec_status
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query the "DB" because it is failing over then the "DB" instance failover completes
    Given eid in exec_status
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query the "DB" because it is failing over then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query the "DB" because it is failing over then a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a "step functions" "state machine" is created then a "RDS" "DB" instance is created then a Multi-"AZ" failover begins on the "DB" instance
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "RDS" "DB" instance is created
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a "step functions" "state machine" is created then a Multi-"AZ" failover begins on the "DB" instance then the "DB" instance failover completes
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a Multi-"AZ" failover begins on the "DB" instance
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a "step functions" "state machine" is created then the "DB" instance failover completes then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "DB" instance failover completes
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds then a running "step functions" "execution" fails to query the "DB" because it is failing over
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails to query the "DB" because it is failing over then a "RDS" "DB" instance is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    When a "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a "RDS" "DB" instance is created then a "step functions" "state machine" is created then the "DB" instance failover completes
    Given dbid not in db_status
    When a "RDS" "DB" instance is created
    When a "step functions" "state machine" is created
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a "RDS" "DB" instance is created then a Multi-"AZ" failover begins on the "DB" instance then an "step functions" "execution" of the "step functions" "state machine" is started
    Given dbid not in db_status
    When a "RDS" "DB" instance is created
    When a Multi-"AZ" failover begins on the "DB" instance
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a "RDS" "DB" instance is created then the "DB" instance failover completes then a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid not in db_status
    When a "RDS" "DB" instance is created
    When the "DB" instance failover completes
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a "RDS" "DB" instance is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to query the "DB" because it is failing over
    Given dbid not in db_status
    When a "RDS" "DB" instance is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a "RDS" "DB" instance is created then a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds then a "step functions" "state machine" is created
    Given dbid not in db_status
    When a "RDS" "DB" instance is created
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a "RDS" "DB" instance is created then a running "step functions" "execution" fails to query the "DB" because it is failing over then a Multi-"AZ" failover begins on the "DB" instance
    Given dbid not in db_status
    When a "RDS" "DB" instance is created
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a "RDS" "DB" instance is created then a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a "RDS" "DB" instance is created
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then the "DB" instance failover completes then a running "step functions" "execution" fails to query the "DB" because it is failing over
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When the "DB" instance failover completes
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds then a "RDS" "DB" instance is created
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    When a "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a running "step functions" "execution" fails to query the "DB" because it is failing over then the "DB" instance failover completes
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then a "step functions" "state machine" is created then a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid in db_status
    When the "DB" instance failover completes
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then a "RDS" "DB" instance is created then a running "step functions" "execution" fails to query the "DB" because it is failing over
    Given dbid in db_status
    When the "DB" instance failover completes
    When a "RDS" "DB" instance is created
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then a Multi-"AZ" failover begins on the "DB" instance then a "step functions" "state machine" is created
    Given dbid in db_status
    When the "DB" instance failover completes
    When a Multi-"AZ" failover begins on the "DB" instance
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then an "step functions" "execution" of the "step functions" "state machine" is started then a "RDS" "DB" instance is created
    Given dbid in db_status
    When the "DB" instance failover completes
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds then a Multi-"AZ" failover begins on the "DB" instance
    Given dbid in db_status
    When the "DB" instance failover completes
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then a running "step functions" "execution" fails to query the "DB" because it is failing over then an "step functions" "execution" of the "step functions" "state machine" is started
    Given dbid in db_status
    When the "DB" instance failover completes
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created then a running "step functions" "execution" fails to query the "DB" because it is failing over
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "RDS" "DB" instance is created then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "RDS" "DB" instance is created
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a Multi-"AZ" failover begins on the "DB" instance then a "RDS" "DB" instance is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a Multi-"AZ" failover begins on the "DB" instance
    When a "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the "DB" instance failover completes then a Multi-"AZ" failover begins on the "DB" instance
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "DB" instance failover completes
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds then the "DB" instance failover completes
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to query the "DB" because it is failing over then a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds then a "step functions" "state machine" is created then a "RDS" "DB" instance is created
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    When a "step functions" "state machine" is created
    When a "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds then a "RDS" "DB" instance is created then a Multi-"AZ" failover begins on the "DB" instance
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    When a "RDS" "DB" instance is created
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds then a Multi-"AZ" failover begins on the "DB" instance then the "DB" instance failover completes
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Multi-"AZ" failover begins on the "DB" instance
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds then the "DB" instance failover completes then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    When the "DB" instance failover completes
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to query the "DB" because it is failing over
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds then a running "step functions" "execution" fails to query the "DB" because it is failing over then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query the "DB" because it is failing over then a "step functions" "state machine" is created then a Multi-"AZ" failover begins on the "DB" instance
    Given eid in exec_status
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    When a "step functions" "state machine" is created
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query the "DB" because it is failing over then a "RDS" "DB" instance is created then the "DB" instance failover completes
    Given eid in exec_status
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    When a "RDS" "DB" instance is created
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query the "DB" because it is failing over then a Multi-"AZ" failover begins on the "DB" instance then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    When a Multi-"AZ" failover begins on the "DB" instance
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query the "DB" because it is failing over then the "DB" instance failover completes then a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    When the "DB" instance failover completes
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query the "DB" because it is failing over then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query the "DB" because it is failing over then a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds then a "RDS" "DB" instance is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to query the "DB" because it is failing over
    When a running "step functions" "execution" queries the "AVAILABLE" "DB" instance and the task succeeds
    When a "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried
