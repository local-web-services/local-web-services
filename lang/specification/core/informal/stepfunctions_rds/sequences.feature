@stepfunctionsrds @generated
Feature: StepfunctionsRds - Action Sequences

  # Generated from FizzBee spec: stepfunctions_rds.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedADB

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an "RDS" "DB" instance is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Multi-"AZ" failover begins on the "DB" instance
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the "DB" instance failover completes
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to query the "DB" because it is failing over
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a Step Functions state machine is created
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a Multi-"AZ" failover begins on the "DB" instance
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then the "DB" instance failover completes
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then an execution of the state machine is started
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a running execution fails to query the "DB" because it is failing over
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a Step Functions state machine is created
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then an "RDS" "DB" instance is created
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then the "DB" instance failover completes
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then an execution of the state machine is started
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a running execution fails to query the "DB" because it is failing over
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a Step Functions state machine is created
    Given dbid in db_status
    When the "DB" instance failover completes
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then an "RDS" "DB" instance is created
    Given dbid in db_status
    When the "DB" instance failover completes
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a Multi-"AZ" failover begins on the "DB" instance
    Given dbid in db_status
    When the "DB" instance failover completes
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then an execution of the state machine is started
    Given dbid in db_status
    When the "DB" instance failover completes
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid in db_status
    When the "DB" instance failover completes
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a running execution fails to query the "DB" because it is failing over
    Given dbid in db_status
    When the "DB" instance failover completes
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an "RDS" "DB" instance is created
    Given smid in sm_status
    When an execution of the state machine is started
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Multi-"AZ" failover begins on the "DB" instance
    Given smid in sm_status
    When an execution of the state machine is started
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the "DB" instance failover completes
    Given smid in sm_status
    When an execution of the state machine is started
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to query the "DB" because it is failing over
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an "RDS" "DB" instance is created
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Multi-"AZ" failover begins on the "DB" instance
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then the "DB" instance failover completes
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a running execution fails to query the "DB" because it is failing over
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then an "RDS" "DB" instance is created
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a Multi-"AZ" failover begins on the "DB" instance
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then the "DB" instance failover completes
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an "RDS" "DB" instance is created then a Multi-"AZ" failover begins on the "DB" instance
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an "RDS" "DB" instance is created
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an "RDS" "DB" instance is created then the "DB" instance failover completes
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an "RDS" "DB" instance is created
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an "RDS" "DB" instance is created then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an "RDS" "DB" instance is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an "RDS" "DB" instance is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an "RDS" "DB" instance is created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an "RDS" "DB" instance is created then a running execution fails to query the "DB" because it is failing over
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an "RDS" "DB" instance is created
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Multi-"AZ" failover begins on the "DB" instance then an "RDS" "DB" instance is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Multi-"AZ" failover begins on the "DB" instance
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Multi-"AZ" failover begins on the "DB" instance then the "DB" instance failover completes
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Multi-"AZ" failover begins on the "DB" instance
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Multi-"AZ" failover begins on the "DB" instance then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Multi-"AZ" failover begins on the "DB" instance
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Multi-"AZ" failover begins on the "DB" instance then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Multi-"AZ" failover begins on the "DB" instance then a running execution fails to query the "DB" because it is failing over
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the "DB" instance failover completes then an "RDS" "DB" instance is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the "DB" instance failover completes
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the "DB" instance failover completes then a Multi-"AZ" failover begins on the "DB" instance
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the "DB" instance failover completes
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the "DB" instance failover completes then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the "DB" instance failover completes
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the "DB" instance failover completes then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the "DB" instance failover completes
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the "DB" instance failover completes then a running execution fails to query the "DB" because it is failing over
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the "DB" instance failover completes
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then an "RDS" "DB" instance is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a Multi-"AZ" failover begins on the "DB" instance
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then the "DB" instance failover completes
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution fails to query the "DB" because it is failing over
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an "RDS" "DB" instance is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Multi-"AZ" failover begins on the "DB" instance
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then the "DB" instance failover completes
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a running execution fails to query the "DB" because it is failing over
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to query the "DB" because it is failing over then an "RDS" "DB" instance is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to query the "DB" because it is failing over
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to query the "DB" because it is failing over then a Multi-"AZ" failover begins on the "DB" instance
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to query the "DB" because it is failing over
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to query the "DB" because it is failing over then the "DB" instance failover completes
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to query the "DB" because it is failing over
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to query the "DB" because it is failing over then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to query the "DB" because it is failing over
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to query the "DB" because it is failing over then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to query the "DB" because it is failing over
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a Step Functions state machine is created then a Multi-"AZ" failover begins on the "DB" instance
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a Step Functions state machine is created
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a Step Functions state machine is created then the "DB" instance failover completes
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a Step Functions state machine is created
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a Step Functions state machine is created then an execution of the state machine is started
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a Step Functions state machine is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a Step Functions state machine is created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a Step Functions state machine is created then a running execution fails to query the "DB" because it is failing over
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a Step Functions state machine is created
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a Multi-"AZ" failover begins on the "DB" instance then a Step Functions state machine is created
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a Multi-"AZ" failover begins on the "DB" instance
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a Multi-"AZ" failover begins on the "DB" instance then the "DB" instance failover completes
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a Multi-"AZ" failover begins on the "DB" instance
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a Multi-"AZ" failover begins on the "DB" instance then an execution of the state machine is started
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a Multi-"AZ" failover begins on the "DB" instance
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a Multi-"AZ" failover begins on the "DB" instance then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a Multi-"AZ" failover begins on the "DB" instance then a running execution fails to query the "DB" because it is failing over
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then the "DB" instance failover completes then a Step Functions state machine is created
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When the "DB" instance failover completes
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then the "DB" instance failover completes then a Multi-"AZ" failover begins on the "DB" instance
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When the "DB" instance failover completes
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then the "DB" instance failover completes then an execution of the state machine is started
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When the "DB" instance failover completes
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then the "DB" instance failover completes then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When the "DB" instance failover completes
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then the "DB" instance failover completes then a running execution fails to query the "DB" because it is failing over
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When the "DB" instance failover completes
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then an execution of the state machine is started then a Step Functions state machine is created
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then an execution of the state machine is started then a Multi-"AZ" failover begins on the "DB" instance
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When an execution of the state machine is started
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then an execution of the state machine is started then the "DB" instance failover completes
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When an execution of the state machine is started
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then an execution of the state machine is started then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When an execution of the state machine is started
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then an execution of the state machine is started then a running execution fails to query the "DB" because it is failing over
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When an execution of the state machine is started
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Step Functions state machine is created
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Multi-"AZ" failover begins on the "DB" instance
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then the "DB" instance failover completes
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an execution of the state machine is started
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a running execution fails to query the "DB" because it is failing over
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a running execution fails to query the "DB" because it is failing over then a Step Functions state machine is created
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a running execution fails to query the "DB" because it is failing over
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a running execution fails to query the "DB" because it is failing over then a Multi-"AZ" failover begins on the "DB" instance
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a running execution fails to query the "DB" because it is failing over
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a running execution fails to query the "DB" because it is failing over then the "DB" instance failover completes
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a running execution fails to query the "DB" because it is failing over
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a running execution fails to query the "DB" because it is failing over then an execution of the state machine is started
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a running execution fails to query the "DB" because it is failing over
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a running execution fails to query the "DB" because it is failing over then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid not in db_status
    When an "RDS" "DB" instance is created
    When a running execution fails to query the "DB" because it is failing over
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a Step Functions state machine is created then an "RDS" "DB" instance is created
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a Step Functions state machine is created
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a Step Functions state machine is created then the "DB" instance failover completes
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a Step Functions state machine is created
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a Step Functions state machine is created then an execution of the state machine is started
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a Step Functions state machine is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a Step Functions state machine is created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a Step Functions state machine is created then a running execution fails to query the "DB" because it is failing over
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a Step Functions state machine is created
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then an "RDS" "DB" instance is created then a Step Functions state machine is created
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When an "RDS" "DB" instance is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then an "RDS" "DB" instance is created then the "DB" instance failover completes
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When an "RDS" "DB" instance is created
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then an "RDS" "DB" instance is created then an execution of the state machine is started
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When an "RDS" "DB" instance is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then an "RDS" "DB" instance is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When an "RDS" "DB" instance is created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then an "RDS" "DB" instance is created then a running execution fails to query the "DB" because it is failing over
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When an "RDS" "DB" instance is created
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then the "DB" instance failover completes then a Step Functions state machine is created
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When the "DB" instance failover completes
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then the "DB" instance failover completes then an "RDS" "DB" instance is created
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When the "DB" instance failover completes
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then the "DB" instance failover completes then an execution of the state machine is started
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When the "DB" instance failover completes
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then the "DB" instance failover completes then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When the "DB" instance failover completes
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then the "DB" instance failover completes then a running execution fails to query the "DB" because it is failing over
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When the "DB" instance failover completes
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then an execution of the state machine is started then a Step Functions state machine is created
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then an execution of the state machine is started then an "RDS" "DB" instance is created
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When an execution of the state machine is started
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then an execution of the state machine is started then the "DB" instance failover completes
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When an execution of the state machine is started
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then an execution of the state machine is started then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When an execution of the state machine is started
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then an execution of the state machine is started then a running execution fails to query the "DB" because it is failing over
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When an execution of the state machine is started
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Step Functions state machine is created
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an "RDS" "DB" instance is created
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then the "DB" instance failover completes
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an execution of the state machine is started
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a running execution fails to query the "DB" because it is failing over
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a running execution fails to query the "DB" because it is failing over then a Step Functions state machine is created
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running execution fails to query the "DB" because it is failing over
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a running execution fails to query the "DB" because it is failing over then an "RDS" "DB" instance is created
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running execution fails to query the "DB" because it is failing over
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a running execution fails to query the "DB" because it is failing over then the "DB" instance failover completes
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running execution fails to query the "DB" because it is failing over
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a running execution fails to query the "DB" because it is failing over then an execution of the state machine is started
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running execution fails to query the "DB" because it is failing over
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a running execution fails to query the "DB" because it is failing over then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid in db_status
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running execution fails to query the "DB" because it is failing over
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a Step Functions state machine is created then an "RDS" "DB" instance is created
    Given dbid in db_status
    When the "DB" instance failover completes
    When a Step Functions state machine is created
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a Step Functions state machine is created then a Multi-"AZ" failover begins on the "DB" instance
    Given dbid in db_status
    When the "DB" instance failover completes
    When a Step Functions state machine is created
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a Step Functions state machine is created then an execution of the state machine is started
    Given dbid in db_status
    When the "DB" instance failover completes
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a Step Functions state machine is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid in db_status
    When the "DB" instance failover completes
    When a Step Functions state machine is created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a Step Functions state machine is created then a running execution fails to query the "DB" because it is failing over
    Given dbid in db_status
    When the "DB" instance failover completes
    When a Step Functions state machine is created
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then an "RDS" "DB" instance is created then a Step Functions state machine is created
    Given dbid in db_status
    When the "DB" instance failover completes
    When an "RDS" "DB" instance is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then an "RDS" "DB" instance is created then a Multi-"AZ" failover begins on the "DB" instance
    Given dbid in db_status
    When the "DB" instance failover completes
    When an "RDS" "DB" instance is created
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then an "RDS" "DB" instance is created then an execution of the state machine is started
    Given dbid in db_status
    When the "DB" instance failover completes
    When an "RDS" "DB" instance is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then an "RDS" "DB" instance is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid in db_status
    When the "DB" instance failover completes
    When an "RDS" "DB" instance is created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then an "RDS" "DB" instance is created then a running execution fails to query the "DB" because it is failing over
    Given dbid in db_status
    When the "DB" instance failover completes
    When an "RDS" "DB" instance is created
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a Multi-"AZ" failover begins on the "DB" instance then a Step Functions state machine is created
    Given dbid in db_status
    When the "DB" instance failover completes
    When a Multi-"AZ" failover begins on the "DB" instance
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a Multi-"AZ" failover begins on the "DB" instance then an "RDS" "DB" instance is created
    Given dbid in db_status
    When the "DB" instance failover completes
    When a Multi-"AZ" failover begins on the "DB" instance
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a Multi-"AZ" failover begins on the "DB" instance then an execution of the state machine is started
    Given dbid in db_status
    When the "DB" instance failover completes
    When a Multi-"AZ" failover begins on the "DB" instance
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a Multi-"AZ" failover begins on the "DB" instance then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid in db_status
    When the "DB" instance failover completes
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a Multi-"AZ" failover begins on the "DB" instance then a running execution fails to query the "DB" because it is failing over
    Given dbid in db_status
    When the "DB" instance failover completes
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then an execution of the state machine is started then a Step Functions state machine is created
    Given dbid in db_status
    When the "DB" instance failover completes
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then an execution of the state machine is started then an "RDS" "DB" instance is created
    Given dbid in db_status
    When the "DB" instance failover completes
    When an execution of the state machine is started
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then an execution of the state machine is started then a Multi-"AZ" failover begins on the "DB" instance
    Given dbid in db_status
    When the "DB" instance failover completes
    When an execution of the state machine is started
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then an execution of the state machine is started then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid in db_status
    When the "DB" instance failover completes
    When an execution of the state machine is started
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then an execution of the state machine is started then a running execution fails to query the "DB" because it is failing over
    Given dbid in db_status
    When the "DB" instance failover completes
    When an execution of the state machine is started
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Step Functions state machine is created
    Given dbid in db_status
    When the "DB" instance failover completes
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an "RDS" "DB" instance is created
    Given dbid in db_status
    When the "DB" instance failover completes
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Multi-"AZ" failover begins on the "DB" instance
    Given dbid in db_status
    When the "DB" instance failover completes
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an execution of the state machine is started
    Given dbid in db_status
    When the "DB" instance failover completes
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a running execution fails to query the "DB" because it is failing over
    Given dbid in db_status
    When the "DB" instance failover completes
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a running execution fails to query the "DB" because it is failing over then a Step Functions state machine is created
    Given dbid in db_status
    When the "DB" instance failover completes
    When a running execution fails to query the "DB" because it is failing over
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a running execution fails to query the "DB" because it is failing over then an "RDS" "DB" instance is created
    Given dbid in db_status
    When the "DB" instance failover completes
    When a running execution fails to query the "DB" because it is failing over
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a running execution fails to query the "DB" because it is failing over then a Multi-"AZ" failover begins on the "DB" instance
    Given dbid in db_status
    When the "DB" instance failover completes
    When a running execution fails to query the "DB" because it is failing over
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a running execution fails to query the "DB" because it is failing over then an execution of the state machine is started
    Given dbid in db_status
    When the "DB" instance failover completes
    When a running execution fails to query the "DB" because it is failing over
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: the "DB" instance failover completes then a running execution fails to query the "DB" because it is failing over then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid in db_status
    When the "DB" instance failover completes
    When a running execution fails to query the "DB" because it is failing over
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then an "RDS" "DB" instance is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a Multi-"AZ" failover begins on the "DB" instance
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then the "DB" instance failover completes
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution fails to query the "DB" because it is failing over
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an "RDS" "DB" instance is created then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When an "RDS" "DB" instance is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an "RDS" "DB" instance is created then a Multi-"AZ" failover begins on the "DB" instance
    Given smid in sm_status
    When an execution of the state machine is started
    When an "RDS" "DB" instance is created
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an "RDS" "DB" instance is created then the "DB" instance failover completes
    Given smid in sm_status
    When an execution of the state machine is started
    When an "RDS" "DB" instance is created
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an "RDS" "DB" instance is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When an "RDS" "DB" instance is created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an "RDS" "DB" instance is created then a running execution fails to query the "DB" because it is failing over
    Given smid in sm_status
    When an execution of the state machine is started
    When an "RDS" "DB" instance is created
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Multi-"AZ" failover begins on the "DB" instance then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Multi-"AZ" failover begins on the "DB" instance
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Multi-"AZ" failover begins on the "DB" instance then an "RDS" "DB" instance is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Multi-"AZ" failover begins on the "DB" instance
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Multi-"AZ" failover begins on the "DB" instance then the "DB" instance failover completes
    Given smid in sm_status
    When an execution of the state machine is started
    When a Multi-"AZ" failover begins on the "DB" instance
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Multi-"AZ" failover begins on the "DB" instance then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Multi-"AZ" failover begins on the "DB" instance then a running execution fails to query the "DB" because it is failing over
    Given smid in sm_status
    When an execution of the state machine is started
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the "DB" instance failover completes then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When the "DB" instance failover completes
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the "DB" instance failover completes then an "RDS" "DB" instance is created
    Given smid in sm_status
    When an execution of the state machine is started
    When the "DB" instance failover completes
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the "DB" instance failover completes then a Multi-"AZ" failover begins on the "DB" instance
    Given smid in sm_status
    When an execution of the state machine is started
    When the "DB" instance failover completes
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the "DB" instance failover completes then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When the "DB" instance failover completes
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the "DB" instance failover completes then a running execution fails to query the "DB" because it is failing over
    Given smid in sm_status
    When an execution of the state machine is started
    When the "DB" instance failover completes
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an "RDS" "DB" instance is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Multi-"AZ" failover begins on the "DB" instance
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then the "DB" instance failover completes
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a running execution fails to query the "DB" because it is failing over
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to query the "DB" because it is failing over then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to query the "DB" because it is failing over
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to query the "DB" because it is failing over then an "RDS" "DB" instance is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to query the "DB" because it is failing over
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to query the "DB" because it is failing over then a Multi-"AZ" failover begins on the "DB" instance
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to query the "DB" because it is failing over
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to query the "DB" because it is failing over then the "DB" instance failover completes
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to query the "DB" because it is failing over
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to query the "DB" because it is failing over then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to query the "DB" because it is failing over
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Step Functions state machine is created then an "RDS" "DB" instance is created
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Step Functions state machine is created
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Step Functions state machine is created then a Multi-"AZ" failover begins on the "DB" instance
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Step Functions state machine is created
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Step Functions state machine is created then the "DB" instance failover completes
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Step Functions state machine is created
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Step Functions state machine is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Step Functions state machine is created then a running execution fails to query the "DB" because it is failing over
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Step Functions state machine is created
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an "RDS" "DB" instance is created then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When an "RDS" "DB" instance is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an "RDS" "DB" instance is created then a Multi-"AZ" failover begins on the "DB" instance
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When an "RDS" "DB" instance is created
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an "RDS" "DB" instance is created then the "DB" instance failover completes
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When an "RDS" "DB" instance is created
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an "RDS" "DB" instance is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When an "RDS" "DB" instance is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an "RDS" "DB" instance is created then a running execution fails to query the "DB" because it is failing over
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When an "RDS" "DB" instance is created
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Multi-"AZ" failover begins on the "DB" instance then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Multi-"AZ" failover begins on the "DB" instance
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Multi-"AZ" failover begins on the "DB" instance then an "RDS" "DB" instance is created
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Multi-"AZ" failover begins on the "DB" instance
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Multi-"AZ" failover begins on the "DB" instance then the "DB" instance failover completes
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Multi-"AZ" failover begins on the "DB" instance
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Multi-"AZ" failover begins on the "DB" instance then an execution of the state machine is started
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Multi-"AZ" failover begins on the "DB" instance
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Multi-"AZ" failover begins on the "DB" instance then a running execution fails to query the "DB" because it is failing over
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then the "DB" instance failover completes then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When the "DB" instance failover completes
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then the "DB" instance failover completes then an "RDS" "DB" instance is created
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When the "DB" instance failover completes
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then the "DB" instance failover completes then a Multi-"AZ" failover begins on the "DB" instance
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When the "DB" instance failover completes
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then the "DB" instance failover completes then an execution of the state machine is started
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When the "DB" instance failover completes
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then the "DB" instance failover completes then a running execution fails to query the "DB" because it is failing over
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When the "DB" instance failover completes
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an execution of the state machine is started then an "RDS" "DB" instance is created
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When an execution of the state machine is started
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an execution of the state machine is started then a Multi-"AZ" failover begins on the "DB" instance
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When an execution of the state machine is started
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an execution of the state machine is started then the "DB" instance failover completes
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When an execution of the state machine is started
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an execution of the state machine is started then a running execution fails to query the "DB" because it is failing over
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When an execution of the state machine is started
    When a running execution fails to query the "DB" because it is failing over
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a running execution fails to query the "DB" because it is failing over then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a running execution fails to query the "DB" because it is failing over
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a running execution fails to query the "DB" because it is failing over then an "RDS" "DB" instance is created
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a running execution fails to query the "DB" because it is failing over
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a running execution fails to query the "DB" because it is failing over then a Multi-"AZ" failover begins on the "DB" instance
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a running execution fails to query the "DB" because it is failing over
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a running execution fails to query the "DB" because it is failing over then the "DB" instance failover completes
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a running execution fails to query the "DB" because it is failing over
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a running execution fails to query the "DB" because it is failing over then an execution of the state machine is started
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a running execution fails to query the "DB" because it is failing over
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a Step Functions state machine is created then an "RDS" "DB" instance is created
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When a Step Functions state machine is created
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a Step Functions state machine is created then a Multi-"AZ" failover begins on the "DB" instance
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When a Step Functions state machine is created
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a Step Functions state machine is created then the "DB" instance failover completes
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When a Step Functions state machine is created
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a Step Functions state machine is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a Step Functions state machine is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When a Step Functions state machine is created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then an "RDS" "DB" instance is created then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When an "RDS" "DB" instance is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then an "RDS" "DB" instance is created then a Multi-"AZ" failover begins on the "DB" instance
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When an "RDS" "DB" instance is created
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then an "RDS" "DB" instance is created then the "DB" instance failover completes
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When an "RDS" "DB" instance is created
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then an "RDS" "DB" instance is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When an "RDS" "DB" instance is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then an "RDS" "DB" instance is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When an "RDS" "DB" instance is created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a Multi-"AZ" failover begins on the "DB" instance then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When a Multi-"AZ" failover begins on the "DB" instance
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a Multi-"AZ" failover begins on the "DB" instance then an "RDS" "DB" instance is created
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When a Multi-"AZ" failover begins on the "DB" instance
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a Multi-"AZ" failover begins on the "DB" instance then the "DB" instance failover completes
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When a Multi-"AZ" failover begins on the "DB" instance
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a Multi-"AZ" failover begins on the "DB" instance then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When a Multi-"AZ" failover begins on the "DB" instance
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a Multi-"AZ" failover begins on the "DB" instance then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When a Multi-"AZ" failover begins on the "DB" instance
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then the "DB" instance failover completes then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When the "DB" instance failover completes
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then the "DB" instance failover completes then an "RDS" "DB" instance is created
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When the "DB" instance failover completes
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then the "DB" instance failover completes then a Multi-"AZ" failover begins on the "DB" instance
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When the "DB" instance failover completes
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then the "DB" instance failover completes then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When the "DB" instance failover completes
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then the "DB" instance failover completes then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When the "DB" instance failover completes
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then an execution of the state machine is started then an "RDS" "DB" instance is created
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When an execution of the state machine is started
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then an execution of the state machine is started then a Multi-"AZ" failover begins on the "DB" instance
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When an execution of the state machine is started
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then an execution of the state machine is started then the "DB" instance failover completes
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When an execution of the state machine is started
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then an execution of the state machine is started then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When an execution of the state machine is started
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an "RDS" "DB" instance is created
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When an "RDS" "DB" instance is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Multi-"AZ" failover begins on the "DB" instance
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When a Multi-"AZ" failover begins on the "DB" instance
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then the "DB" instance failover completes
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When the "DB" instance failover completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to query the "DB" because it is failing over
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried
