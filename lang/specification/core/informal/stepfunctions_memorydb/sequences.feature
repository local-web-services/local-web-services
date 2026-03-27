@stepfunctionsmemorydb @generated
Feature: StepfunctionsMemorydb - Action Sequences

  # Generated from FizzBee spec: stepfunctions_memorydb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a MemoryDB cluster is created
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a MemoryDB cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a MemoryDB cluster update begins
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a MemoryDB cluster update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the MemoryDB cluster update completes
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When the MemoryDB cluster update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to connect because the MemoryDB cluster is updating
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution fails to connect because the MemoryDB cluster is updating
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a Step Functions state machine is created
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a MemoryDB cluster update begins
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    When a MemoryDB cluster update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then the MemoryDB cluster update completes
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    When the MemoryDB cluster update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then an execution of the state machine is started
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a running execution fails to connect because the MemoryDB cluster is updating
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    When a running execution fails to connect because the MemoryDB cluster is updating
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a Step Functions state machine is created
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a MemoryDB cluster is created
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    When a MemoryDB cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then the MemoryDB cluster update completes
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    When the MemoryDB cluster update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then an execution of the state machine is started
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a running execution fails to connect because the MemoryDB cluster is updating
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    When a running execution fails to connect because the MemoryDB cluster is updating
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a Step Functions state machine is created
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a MemoryDB cluster is created
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    When a MemoryDB cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a MemoryDB cluster update begins
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    When a MemoryDB cluster update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then an execution of the state machine is started
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a running execution fails to connect because the MemoryDB cluster is updating
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    When a running execution fails to connect because the MemoryDB cluster is updating
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a MemoryDB cluster is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a MemoryDB cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a MemoryDB cluster update begins
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a MemoryDB cluster update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the MemoryDB cluster update completes
    Given smid in sm_status
    Given an execution of the state machine has been started
    When the MemoryDB cluster update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to connect because the MemoryDB cluster is updating
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution fails to connect because the MemoryDB cluster is updating
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" MemoryDB cluster and the task succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a MemoryDB cluster is created
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" MemoryDB cluster and the task succeeded
    When a MemoryDB cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a MemoryDB cluster update begins
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" MemoryDB cluster and the task succeeded
    When a MemoryDB cluster update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then the MemoryDB cluster update completes
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" MemoryDB cluster and the task succeeded
    When the MemoryDB cluster update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" MemoryDB cluster and the task succeeded
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a running execution fails to connect because the MemoryDB cluster is updating
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" MemoryDB cluster and the task succeeded
    When a running execution fails to connect because the MemoryDB cluster is updating
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has failed to connect because the MemoryDB cluster is updating
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then a MemoryDB cluster is created
    Given eid in exec_status
    Given a running execution has failed to connect because the MemoryDB cluster is updating
    When a MemoryDB cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then a MemoryDB cluster update begins
    Given eid in exec_status
    Given a running execution has failed to connect because the MemoryDB cluster is updating
    When a MemoryDB cluster update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then the MemoryDB cluster update completes
    Given eid in exec_status
    Given a running execution has failed to connect because the MemoryDB cluster is updating
    When the MemoryDB cluster update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has failed to connect because the MemoryDB cluster is updating
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given eid in exec_status
    Given a running execution has failed to connect because the MemoryDB cluster is updating
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a MemoryDB cluster is created then a MemoryDB cluster update begins
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a MemoryDB cluster has been created
    When a MemoryDB cluster update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a MemoryDB cluster update begins then the MemoryDB cluster update completes
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a MemoryDB cluster update has begun
    When the MemoryDB cluster update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the MemoryDB cluster update completes then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given the MemoryDB cluster update has completed
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an execution of the state machine has been started
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a running execution fails to connect because the MemoryDB cluster is updating
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has connected to the "AVAILABLE" MemoryDB cluster and the task succeeded
    When a running execution fails to connect because the MemoryDB cluster is updating
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to connect because the MemoryDB cluster is updating then a MemoryDB cluster is created
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has failed to connect because the MemoryDB cluster is updating
    When a MemoryDB cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a Step Functions state machine is created then the MemoryDB cluster update completes
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    Given a Step Functions state machine has been created
    When the MemoryDB cluster update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a MemoryDB cluster update begins then an execution of the state machine is started
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    Given a MemoryDB cluster update has begun
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then the MemoryDB cluster update completes then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    Given the MemoryDB cluster update has completed
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then an execution of the state machine is started then a running execution fails to connect because the MemoryDB cluster is updating
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    Given an execution of the state machine has been started
    When a running execution fails to connect because the MemoryDB cluster is updating
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a Step Functions state machine is created
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    Given a running execution has connected to the "AVAILABLE" MemoryDB cluster and the task succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a running execution fails to connect because the MemoryDB cluster is updating then a MemoryDB cluster update begins
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    Given a running execution has failed to connect because the MemoryDB cluster is updating
    When a MemoryDB cluster update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a Step Functions state machine is created then an execution of the state machine is started
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a MemoryDB cluster is created then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    Given a MemoryDB cluster has been created
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then the MemoryDB cluster update completes then a running execution fails to connect because the MemoryDB cluster is updating
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    Given the MemoryDB cluster update has completed
    When a running execution fails to connect because the MemoryDB cluster is updating
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then an execution of the state machine is started then a Step Functions state machine is created
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a MemoryDB cluster is created
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    Given a running execution has connected to the "AVAILABLE" MemoryDB cluster and the task succeeded
    When a MemoryDB cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a running execution fails to connect because the MemoryDB cluster is updating then the MemoryDB cluster update completes
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    Given a running execution has failed to connect because the MemoryDB cluster is updating
    When the MemoryDB cluster update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a Step Functions state machine is created then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    Given a Step Functions state machine has been created
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a MemoryDB cluster is created then a running execution fails to connect because the MemoryDB cluster is updating
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    Given a MemoryDB cluster has been created
    When a running execution fails to connect because the MemoryDB cluster is updating
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a MemoryDB cluster update begins then a Step Functions state machine is created
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    Given a MemoryDB cluster update has begun
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then an execution of the state machine is started then a MemoryDB cluster is created
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    Given an execution of the state machine has been started
    When a MemoryDB cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a MemoryDB cluster update begins
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    Given a running execution has connected to the "AVAILABLE" MemoryDB cluster and the task succeeded
    When a MemoryDB cluster update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a running execution fails to connect because the MemoryDB cluster is updating then an execution of the state machine is started
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    Given a running execution has failed to connect because the MemoryDB cluster is updating
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution fails to connect because the MemoryDB cluster is updating
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a Step Functions state machine has been created
    When a running execution fails to connect because the MemoryDB cluster is updating
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a MemoryDB cluster is created then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a MemoryDB cluster has been created
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a MemoryDB cluster update begins then a MemoryDB cluster is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a MemoryDB cluster update has begun
    When a MemoryDB cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the MemoryDB cluster update completes then a MemoryDB cluster update begins
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given the MemoryDB cluster update has completed
    When a MemoryDB cluster update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then the MemoryDB cluster update completes
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has connected to the "AVAILABLE" MemoryDB cluster and the task succeeded
    When the MemoryDB cluster update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to connect because the MemoryDB cluster is updating then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has failed to connect because the MemoryDB cluster is updating
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a Step Functions state machine is created then a MemoryDB cluster is created
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" MemoryDB cluster and the task succeeded
    Given a Step Functions state machine has been created
    When a MemoryDB cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a MemoryDB cluster is created then a MemoryDB cluster update begins
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" MemoryDB cluster and the task succeeded
    Given a MemoryDB cluster has been created
    When a MemoryDB cluster update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a MemoryDB cluster update begins then the MemoryDB cluster update completes
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" MemoryDB cluster and the task succeeded
    Given a MemoryDB cluster update has begun
    When the MemoryDB cluster update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then the MemoryDB cluster update completes then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" MemoryDB cluster and the task succeeded
    Given the MemoryDB cluster update has completed
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then an execution of the state machine is started then a running execution fails to connect because the MemoryDB cluster is updating
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" MemoryDB cluster and the task succeeded
    Given an execution of the state machine has been started
    When a running execution fails to connect because the MemoryDB cluster is updating
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a running execution fails to connect because the MemoryDB cluster is updating then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" MemoryDB cluster and the task succeeded
    Given a running execution has failed to connect because the MemoryDB cluster is updating
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then a Step Functions state machine is created then a MemoryDB cluster update begins
    Given eid in exec_status
    Given a running execution has failed to connect because the MemoryDB cluster is updating
    Given a Step Functions state machine has been created
    When a MemoryDB cluster update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then a MemoryDB cluster is created then the MemoryDB cluster update completes
    Given eid in exec_status
    Given a running execution has failed to connect because the MemoryDB cluster is updating
    Given a MemoryDB cluster has been created
    When the MemoryDB cluster update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then a MemoryDB cluster update begins then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has failed to connect because the MemoryDB cluster is updating
    Given a MemoryDB cluster update has begun
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then the MemoryDB cluster update completes then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given eid in exec_status
    Given a running execution has failed to connect because the MemoryDB cluster is updating
    Given the MemoryDB cluster update has completed
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has failed to connect because the MemoryDB cluster is updating
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a MemoryDB cluster is created
    Given eid in exec_status
    Given a running execution has failed to connect because the MemoryDB cluster is updating
    Given a running execution has connected to the "AVAILABLE" MemoryDB cluster and the task succeeded
    When a MemoryDB cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to
