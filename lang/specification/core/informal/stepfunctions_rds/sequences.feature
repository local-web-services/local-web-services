@stepfunctionsrds @generated
Feature: StepfunctionsRds - Action Sequences

  # Generated from FizzBee spec: stepfunctions_rds.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedADB

  Background:
    Given the system is initialized

  @sequence
  Scenario: a Step Functions state machine is created then an "RDS" "DB" instance is created
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an "RDS" "DB" instance is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Step Functions state machine is created then a Multi-"AZ" failover begins on the "DB" instance
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a Multi-"AZ" failover begins on the "DB" instance
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Step Functions state machine is created then the "DB" instance failover completes
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When the "DB" instance failover completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Step Functions state machine is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to query the "DB" because it is failing over
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution fails to query the "DB" because it is failing over
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "RDS" "DB" instance is created then a Step Functions state machine is created
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "RDS" "DB" instance is created then a Multi-"AZ" failover begins on the "DB" instance
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created
    When a Multi-"AZ" failover begins on the "DB" instance
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "RDS" "DB" instance is created then the "DB" instance failover completes
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created
    When the "DB" instance failover completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "RDS" "DB" instance is created then an execution of the state machine is started
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "RDS" "DB" instance is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "RDS" "DB" instance is created then a running execution fails to query the "DB" because it is failing over
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created
    When a running execution fails to query the "DB" because it is failing over
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a Step Functions state machine is created
    Given dbid in db_status
    Given a Multi-"AZ" failover has begun on the "DB" instance
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then an "RDS" "DB" instance is created
    Given dbid in db_status
    Given a Multi-"AZ" failover has begun on the "DB" instance
    When an "RDS" "DB" instance is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then the "DB" instance failover completes
    Given dbid in db_status
    Given a Multi-"AZ" failover has begun on the "DB" instance
    When the "DB" instance failover completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then an execution of the state machine is started
    Given dbid in db_status
    Given a Multi-"AZ" failover has begun on the "DB" instance
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid in db_status
    Given a Multi-"AZ" failover has begun on the "DB" instance
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a running execution fails to query the "DB" because it is failing over
    Given dbid in db_status
    Given a Multi-"AZ" failover has begun on the "DB" instance
    When a running execution fails to query the "DB" because it is failing over
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then a Step Functions state machine is created
    Given dbid in db_status
    Given the "DB" instance failover has completed
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then an "RDS" "DB" instance is created
    Given dbid in db_status
    Given the "DB" instance failover has completed
    When an "RDS" "DB" instance is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then a Multi-"AZ" failover begins on the "DB" instance
    Given dbid in db_status
    Given the "DB" instance failover has completed
    When a Multi-"AZ" failover begins on the "DB" instance
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then an execution of the state machine is started
    Given dbid in db_status
    Given the "DB" instance failover has completed
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid in db_status
    Given the "DB" instance failover has completed
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then a running execution fails to query the "DB" because it is failing over
    Given dbid in db_status
    Given the "DB" instance failover has completed
    When a running execution fails to query the "DB" because it is failing over
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an execution of the state machine is started then an "RDS" "DB" instance is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    When an "RDS" "DB" instance is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an execution of the state machine is started then a Multi-"AZ" failover begins on the "DB" instance
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a Multi-"AZ" failover begins on the "DB" instance
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an execution of the state machine is started then the "DB" instance failover completes
    Given smid in sm_status
    Given an execution of the state machine has been started
    When the "DB" instance failover completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an execution of the state machine is started then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an execution of the state machine is started then a running execution fails to query the "DB" because it is failing over
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution fails to query the "DB" because it is failing over
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" "DB" instance and the task succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an "RDS" "DB" instance is created
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" "DB" instance and the task succeeded
    When an "RDS" "DB" instance is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Multi-"AZ" failover begins on the "DB" instance
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" "DB" instance and the task succeeded
    When a Multi-"AZ" failover begins on the "DB" instance
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then the "DB" instance failover completes
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" "DB" instance and the task succeeded
    When the "DB" instance failover completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" "DB" instance and the task succeeded
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a running execution fails to query the "DB" because it is failing over
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" "DB" instance and the task succeeded
    When a running execution fails to query the "DB" because it is failing over
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has failed to query the "DB" because it is failing over
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then an "RDS" "DB" instance is created
    Given eid in exec_status
    Given a running execution has failed to query the "DB" because it is failing over
    When an "RDS" "DB" instance is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a Multi-"AZ" failover begins on the "DB" instance
    Given eid in exec_status
    Given a running execution has failed to query the "DB" because it is failing over
    When a Multi-"AZ" failover begins on the "DB" instance
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then the "DB" instance failover completes
    Given eid in exec_status
    Given a running execution has failed to query the "DB" because it is failing over
    When the "DB" instance failover completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has failed to query the "DB" because it is failing over
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given eid in exec_status
    Given a running execution has failed to query the "DB" because it is failing over
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Step Functions state machine is created then an "RDS" "DB" instance is created then a Multi-"AZ" failover begins on the "DB" instance
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an "RDS" "DB" instance has been created
    When a Multi-"AZ" failover begins on the "DB" instance
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Step Functions state machine is created then a Multi-"AZ" failover begins on the "DB" instance then the "DB" instance failover completes
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a Multi-"AZ" failover has begun on the "DB" instance
    When the "DB" instance failover completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Step Functions state machine is created then the "DB" instance failover completes then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given the "DB" instance failover has completed
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an execution of the state machine has been started
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Step Functions state machine is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a running execution fails to query the "DB" because it is failing over
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has queried the "AVAILABLE" "DB" instance and the task succeeded
    When a running execution fails to query the "DB" because it is failing over
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to query the "DB" because it is failing over then an "RDS" "DB" instance is created
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has failed to query the "DB" because it is failing over
    When an "RDS" "DB" instance is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "RDS" "DB" instance is created then a Step Functions state machine is created then the "DB" instance failover completes
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created
    Given a Step Functions state machine has been created
    When the "DB" instance failover completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "RDS" "DB" instance is created then a Multi-"AZ" failover begins on the "DB" instance then an execution of the state machine is started
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created
    Given a Multi-"AZ" failover has begun on the "DB" instance
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "RDS" "DB" instance is created then the "DB" instance failover completes then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created
    Given the "DB" instance failover has completed
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "RDS" "DB" instance is created then an execution of the state machine is started then a running execution fails to query the "DB" because it is failing over
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created
    Given an execution of the state machine has been started
    When a running execution fails to query the "DB" because it is failing over
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "RDS" "DB" instance is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Step Functions state machine is created
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created
    Given a running execution has queried the "AVAILABLE" "DB" instance and the task succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an "RDS" "DB" instance is created then a running execution fails to query the "DB" because it is failing over then a Multi-"AZ" failover begins on the "DB" instance
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created
    Given a running execution has failed to query the "DB" because it is failing over
    When a Multi-"AZ" failover begins on the "DB" instance
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a Step Functions state machine is created then an execution of the state machine is started
    Given dbid in db_status
    Given a Multi-"AZ" failover has begun on the "DB" instance
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then an "RDS" "DB" instance is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid in db_status
    Given a Multi-"AZ" failover has begun on the "DB" instance
    Given an "RDS" "DB" instance has been created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then the "DB" instance failover completes then a running execution fails to query the "DB" because it is failing over
    Given dbid in db_status
    Given a Multi-"AZ" failover has begun on the "DB" instance
    Given the "DB" instance failover has completed
    When a running execution fails to query the "DB" because it is failing over
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then an execution of the state machine is started then a Step Functions state machine is created
    Given dbid in db_status
    Given a Multi-"AZ" failover has begun on the "DB" instance
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an "RDS" "DB" instance is created
    Given dbid in db_status
    Given a Multi-"AZ" failover has begun on the "DB" instance
    Given a running execution has queried the "AVAILABLE" "DB" instance and the task succeeded
    When an "RDS" "DB" instance is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "DB" instance then a running execution fails to query the "DB" because it is failing over then the "DB" instance failover completes
    Given dbid in db_status
    Given a Multi-"AZ" failover has begun on the "DB" instance
    Given a running execution has failed to query the "DB" because it is failing over
    When the "DB" instance failover completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then a Step Functions state machine is created then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given dbid in db_status
    Given the "DB" instance failover has completed
    Given a Step Functions state machine has been created
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then an "RDS" "DB" instance is created then a running execution fails to query the "DB" because it is failing over
    Given dbid in db_status
    Given the "DB" instance failover has completed
    Given an "RDS" "DB" instance has been created
    When a running execution fails to query the "DB" because it is failing over
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then a Multi-"AZ" failover begins on the "DB" instance then a Step Functions state machine is created
    Given dbid in db_status
    Given the "DB" instance failover has completed
    Given a Multi-"AZ" failover has begun on the "DB" instance
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then an execution of the state machine is started then an "RDS" "DB" instance is created
    Given dbid in db_status
    Given the "DB" instance failover has completed
    Given an execution of the state machine has been started
    When an "RDS" "DB" instance is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Multi-"AZ" failover begins on the "DB" instance
    Given dbid in db_status
    Given the "DB" instance failover has completed
    Given a running execution has queried the "AVAILABLE" "DB" instance and the task succeeded
    When a Multi-"AZ" failover begins on the "DB" instance
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: the "DB" instance failover completes then a running execution fails to query the "DB" because it is failing over then an execution of the state machine is started
    Given dbid in db_status
    Given the "DB" instance failover has completed
    Given a running execution has failed to query the "DB" because it is failing over
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution fails to query the "DB" because it is failing over
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a Step Functions state machine has been created
    When a running execution fails to query the "DB" because it is failing over
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an execution of the state machine is started then an "RDS" "DB" instance is created then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given an "RDS" "DB" instance has been created
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an execution of the state machine is started then a Multi-"AZ" failover begins on the "DB" instance then an "RDS" "DB" instance is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a Multi-"AZ" failover has begun on the "DB" instance
    When an "RDS" "DB" instance is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an execution of the state machine is started then the "DB" instance failover completes then a Multi-"AZ" failover begins on the "DB" instance
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given the "DB" instance failover has completed
    When a Multi-"AZ" failover begins on the "DB" instance
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an execution of the state machine is started then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then the "DB" instance failover completes
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has queried the "AVAILABLE" "DB" instance and the task succeeded
    When the "DB" instance failover completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: an execution of the state machine is started then a running execution fails to query the "DB" because it is failing over then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has failed to query the "DB" because it is failing over
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Step Functions state machine is created then an "RDS" "DB" instance is created
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" "DB" instance and the task succeeded
    Given a Step Functions state machine has been created
    When an "RDS" "DB" instance is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an "RDS" "DB" instance is created then a Multi-"AZ" failover begins on the "DB" instance
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" "DB" instance and the task succeeded
    Given an "RDS" "DB" instance has been created
    When a Multi-"AZ" failover begins on the "DB" instance
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a Multi-"AZ" failover begins on the "DB" instance then the "DB" instance failover completes
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" "DB" instance and the task succeeded
    Given a Multi-"AZ" failover has begun on the "DB" instance
    When the "DB" instance failover completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then the "DB" instance failover completes then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" "DB" instance and the task succeeded
    Given the "DB" instance failover has completed
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an execution of the state machine is started then a running execution fails to query the "DB" because it is failing over
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" "DB" instance and the task succeeded
    Given an execution of the state machine has been started
    When a running execution fails to query the "DB" because it is failing over
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then a running execution fails to query the "DB" because it is failing over then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" "DB" instance and the task succeeded
    Given a running execution has failed to query the "DB" because it is failing over
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a Step Functions state machine is created then a Multi-"AZ" failover begins on the "DB" instance
    Given eid in exec_status
    Given a running execution has failed to query the "DB" because it is failing over
    Given a Step Functions state machine has been created
    When a Multi-"AZ" failover begins on the "DB" instance
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then an "RDS" "DB" instance is created then the "DB" instance failover completes
    Given eid in exec_status
    Given a running execution has failed to query the "DB" because it is failing over
    Given an "RDS" "DB" instance has been created
    When the "DB" instance failover completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a Multi-"AZ" failover begins on the "DB" instance then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has failed to query the "DB" because it is failing over
    Given a Multi-"AZ" failover has begun on the "DB" instance
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then the "DB" instance failover completes then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Given eid in exec_status
    Given a running execution has failed to query the "DB" because it is failing over
    Given the "DB" instance failover has completed
    When a running execution queries the "AVAILABLE" "DB" instance and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has failed to query the "DB" because it is failing over
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried

  @sequence
  Scenario: a running execution fails to query the "DB" because it is failing over then a running execution queries the "AVAILABLE" "DB" instance and the task succeeds then an "RDS" "DB" instance is created
    Given eid in exec_status
    Given a running execution has failed to query the "DB" because it is failing over
    Given a running execution has queried the "AVAILABLE" "DB" instance and the task succeeded
    When an "RDS" "DB" instance is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which "DB" instance it queried
