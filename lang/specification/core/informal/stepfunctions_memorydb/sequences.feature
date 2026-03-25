@stepfunctionsmemorydb @generated
Feature: StepfunctionsMemorydb - Action Sequences

  # Generated from FizzBee spec: stepfunctions_memorydb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a MemoryDB cluster is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a MemoryDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a MemoryDB cluster update begins
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a MemoryDB cluster update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the MemoryDB cluster update completes
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the MemoryDB cluster update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to connect because the MemoryDB cluster is updating
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to connect because the MemoryDB cluster is updating
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a Step Functions state machine is created
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a MemoryDB cluster update begins
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When a MemoryDB cluster update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then the MemoryDB cluster update completes
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When the MemoryDB cluster update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then an execution of the state machine is started
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a running execution fails to connect because the MemoryDB cluster is updating
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When a running execution fails to connect because the MemoryDB cluster is updating
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a Step Functions state machine is created
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a MemoryDB cluster is created
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When a MemoryDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then the MemoryDB cluster update completes
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When the MemoryDB cluster update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then an execution of the state machine is started
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a running execution fails to connect because the MemoryDB cluster is updating
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When a running execution fails to connect because the MemoryDB cluster is updating
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a Step Functions state machine is created
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a MemoryDB cluster is created
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When a MemoryDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a MemoryDB cluster update begins
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When a MemoryDB cluster update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then an execution of the state machine is started
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a running execution fails to connect because the MemoryDB cluster is updating
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When a running execution fails to connect because the MemoryDB cluster is updating
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a MemoryDB cluster is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a MemoryDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a MemoryDB cluster update begins
    Given smid in sm_status
    When an execution of the state machine is started
    When a MemoryDB cluster update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the MemoryDB cluster update completes
    Given smid in sm_status
    When an execution of the state machine is started
    When the MemoryDB cluster update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to connect because the MemoryDB cluster is updating
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to connect because the MemoryDB cluster is updating
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a MemoryDB cluster is created
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a MemoryDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a MemoryDB cluster update begins
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a MemoryDB cluster update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then the MemoryDB cluster update completes
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When the MemoryDB cluster update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a running execution fails to connect because the MemoryDB cluster is updating
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a running execution fails to connect because the MemoryDB cluster is updating
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to connect because the MemoryDB cluster is updating
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then a MemoryDB cluster is created
    Given eid in exec_status
    When a running execution fails to connect because the MemoryDB cluster is updating
    When a MemoryDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then a MemoryDB cluster update begins
    Given eid in exec_status
    When a running execution fails to connect because the MemoryDB cluster is updating
    When a MemoryDB cluster update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then the MemoryDB cluster update completes
    Given eid in exec_status
    When a running execution fails to connect because the MemoryDB cluster is updating
    When the MemoryDB cluster update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to connect because the MemoryDB cluster is updating
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given eid in exec_status
    When a running execution fails to connect because the MemoryDB cluster is updating
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a MemoryDB cluster is created then a MemoryDB cluster update begins
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a MemoryDB cluster is created
    When a MemoryDB cluster update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a MemoryDB cluster update begins then the MemoryDB cluster update completes
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a MemoryDB cluster update begins
    When the MemoryDB cluster update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the MemoryDB cluster update completes then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the MemoryDB cluster update completes
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a running execution fails to connect because the MemoryDB cluster is updating
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a running execution fails to connect because the MemoryDB cluster is updating
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to connect because the MemoryDB cluster is updating then a MemoryDB cluster is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to connect because the MemoryDB cluster is updating
    When a MemoryDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a Step Functions state machine is created then the MemoryDB cluster update completes
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When a Step Functions state machine is created
    When the MemoryDB cluster update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a MemoryDB cluster update begins then an execution of the state machine is started
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When a MemoryDB cluster update begins
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then the MemoryDB cluster update completes then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When the MemoryDB cluster update completes
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then an execution of the state machine is started then a running execution fails to connect because the MemoryDB cluster is updating
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When an execution of the state machine is started
    When a running execution fails to connect because the MemoryDB cluster is updating
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a Step Functions state machine is created
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a running execution fails to connect because the MemoryDB cluster is updating then a MemoryDB cluster update begins
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When a running execution fails to connect because the MemoryDB cluster is updating
    When a MemoryDB cluster update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a Step Functions state machine is created then an execution of the state machine is started
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a MemoryDB cluster is created then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When a MemoryDB cluster is created
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then the MemoryDB cluster update completes then a running execution fails to connect because the MemoryDB cluster is updating
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When the MemoryDB cluster update completes
    When a running execution fails to connect because the MemoryDB cluster is updating
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then an execution of the state machine is started then a Step Functions state machine is created
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a MemoryDB cluster is created
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a MemoryDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a running execution fails to connect because the MemoryDB cluster is updating then the MemoryDB cluster update completes
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When a running execution fails to connect because the MemoryDB cluster is updating
    When the MemoryDB cluster update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a Step Functions state machine is created then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When a Step Functions state machine is created
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a MemoryDB cluster is created then a running execution fails to connect because the MemoryDB cluster is updating
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When a MemoryDB cluster is created
    When a running execution fails to connect because the MemoryDB cluster is updating
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a MemoryDB cluster update begins then a Step Functions state machine is created
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When a MemoryDB cluster update begins
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then an execution of the state machine is started then a MemoryDB cluster is created
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When an execution of the state machine is started
    When a MemoryDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a MemoryDB cluster update begins
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a MemoryDB cluster update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a running execution fails to connect because the MemoryDB cluster is updating then an execution of the state machine is started
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When a running execution fails to connect because the MemoryDB cluster is updating
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution fails to connect because the MemoryDB cluster is updating
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a running execution fails to connect because the MemoryDB cluster is updating
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a MemoryDB cluster is created then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a MemoryDB cluster is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a MemoryDB cluster update begins then a MemoryDB cluster is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a MemoryDB cluster update begins
    When a MemoryDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the MemoryDB cluster update completes then a MemoryDB cluster update begins
    Given smid in sm_status
    When an execution of the state machine is started
    When the MemoryDB cluster update completes
    When a MemoryDB cluster update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then the MemoryDB cluster update completes
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When the MemoryDB cluster update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to connect because the MemoryDB cluster is updating then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to connect because the MemoryDB cluster is updating
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a Step Functions state machine is created then a MemoryDB cluster is created
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a Step Functions state machine is created
    When a MemoryDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a MemoryDB cluster is created then a MemoryDB cluster update begins
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a MemoryDB cluster is created
    When a MemoryDB cluster update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a MemoryDB cluster update begins then the MemoryDB cluster update completes
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a MemoryDB cluster update begins
    When the MemoryDB cluster update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then the MemoryDB cluster update completes then an execution of the state machine is started
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When the MemoryDB cluster update completes
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then an execution of the state machine is started then a running execution fails to connect because the MemoryDB cluster is updating
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When an execution of the state machine is started
    When a running execution fails to connect because the MemoryDB cluster is updating
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a running execution fails to connect because the MemoryDB cluster is updating then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a running execution fails to connect because the MemoryDB cluster is updating
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then a Step Functions state machine is created then a MemoryDB cluster update begins
    Given eid in exec_status
    When a running execution fails to connect because the MemoryDB cluster is updating
    When a Step Functions state machine is created
    When a MemoryDB cluster update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then a MemoryDB cluster is created then the MemoryDB cluster update completes
    Given eid in exec_status
    When a running execution fails to connect because the MemoryDB cluster is updating
    When a MemoryDB cluster is created
    When the MemoryDB cluster update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then a MemoryDB cluster update begins then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to connect because the MemoryDB cluster is updating
    When a MemoryDB cluster update begins
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then the MemoryDB cluster update completes then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given eid in exec_status
    When a running execution fails to connect because the MemoryDB cluster is updating
    When the MemoryDB cluster update completes
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to connect because the MemoryDB cluster is updating
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the MemoryDB cluster is updating then a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a MemoryDB cluster is created
    Given eid in exec_status
    When a running execution fails to connect because the MemoryDB cluster is updating
    When a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a MemoryDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to
