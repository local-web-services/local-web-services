@stepfunctionsmemorydb @generated
Feature: StepfunctionsMemorydb - Action Sequences

  # Generated from FizzBee spec: stepfunctions_memorydb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "step functions" "state machine" is created then a "memorydb" "cluster" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "memorydb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "step functions" "state machine" is created then a "memorydb" "cluster" update begins
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "memorydb" "cluster" update begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "step functions" "state machine" is created then the "memorydb" "cluster" update completes
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "memorydb" "cluster" update completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" is created then a "step functions" "state machine" is created
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" is created then a "memorydb" "cluster" update begins
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When a "memorydb" "cluster" update begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" is created then the "memorydb" "cluster" update completes
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When the "memorydb" "cluster" update completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" is created then a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" is created then a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" update begins then a "step functions" "state machine" is created
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" update begins then a "memorydb" "cluster" is created
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When a "memorydb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" update begins then the "memorydb" "cluster" update completes
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When the "memorydb" "cluster" update completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" update begins then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" update begins then a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" update begins then a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: the "memorydb" "cluster" update completes then a "step functions" "state machine" is created
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: the "memorydb" "cluster" update completes then a "memorydb" "cluster" is created
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When a "memorydb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: the "memorydb" "cluster" update completes then a "memorydb" "cluster" update begins
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When a "memorydb" "cluster" update begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: the "memorydb" "cluster" update completes then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: the "memorydb" "cluster" update completes then a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: the "memorydb" "cluster" update completes then a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "memorydb" "cluster" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "memorydb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "memorydb" "cluster" update begins
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "memorydb" "cluster" update begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the "memorydb" "cluster" update completes
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "memorydb" "cluster" update completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a "memorydb" "cluster" is created
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a "memorydb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a "memorydb" "cluster" update begins
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a "memorydb" "cluster" update begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then the "memorydb" "cluster" update completes
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When the "memorydb" "cluster" update completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating then a "memorydb" "cluster" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    When a "memorydb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating then a "memorydb" "cluster" update begins
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    When a "memorydb" "cluster" update begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating then the "memorydb" "cluster" update completes
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    When the "memorydb" "cluster" update completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating then a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "step functions" "state machine" is created then a "memorydb" "cluster" is created then a "memorydb" "cluster" update begins
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "memorydb" "cluster" is created
    When a "memorydb" "cluster" update begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "step functions" "state machine" is created then a "memorydb" "cluster" update begins then the "memorydb" "cluster" update completes
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "memorydb" "cluster" update begins
    When the "memorydb" "cluster" update completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "step functions" "state machine" is created then the "memorydb" "cluster" update completes then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "memorydb" "cluster" update completes
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating then a "memorydb" "cluster" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    When a "memorydb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" is created then a "step functions" "state machine" is created then the "memorydb" "cluster" update completes
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When a "step functions" "state machine" is created
    When the "memorydb" "cluster" update completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" is created then a "memorydb" "cluster" update begins then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When a "memorydb" "cluster" update begins
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" is created then the "memorydb" "cluster" update completes then a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When the "memorydb" "cluster" update completes
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" is created then a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a "step functions" "state machine" is created
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" is created then a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating then a "memorydb" "cluster" update begins
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    When a "memorydb" "cluster" update begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" update begins then a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" update begins then a "memorydb" "cluster" is created then a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When a "memorydb" "cluster" is created
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" update begins then the "memorydb" "cluster" update completes then a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When the "memorydb" "cluster" update completes
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" update begins then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" update begins then a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a "memorydb" "cluster" is created
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a "memorydb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a "memorydb" "cluster" update begins then a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating then the "memorydb" "cluster" update completes
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    When the "memorydb" "cluster" update completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: the "memorydb" "cluster" update completes then a "step functions" "state machine" is created then a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: the "memorydb" "cluster" update completes then a "memorydb" "cluster" is created then a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When a "memorydb" "cluster" is created
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: the "memorydb" "cluster" update completes then a "memorydb" "cluster" update begins then a "step functions" "state machine" is created
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When a "memorydb" "cluster" update begins
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: the "memorydb" "cluster" update completes then an "step functions" "execution" of the "step functions" "state machine" is started then a "memorydb" "cluster" is created
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "memorydb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: the "memorydb" "cluster" update completes then a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a "memorydb" "cluster" update begins
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a "memorydb" "cluster" update begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: the "memorydb" "cluster" update completes then a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created then a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "memorydb" "cluster" is created then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "memorydb" "cluster" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "memorydb" "cluster" update begins then a "memorydb" "cluster" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "memorydb" "cluster" update begins
    When a "memorydb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the "memorydb" "cluster" update completes then a "memorydb" "cluster" update begins
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "memorydb" "cluster" update completes
    When a "memorydb" "cluster" update begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then the "memorydb" "cluster" update completes
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When the "memorydb" "cluster" update completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating then a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a "step functions" "state machine" is created then a "memorydb" "cluster" is created
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a "step functions" "state machine" is created
    When a "memorydb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a "memorydb" "cluster" is created then a "memorydb" "cluster" update begins
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a "memorydb" "cluster" is created
    When a "memorydb" "cluster" update begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a "memorydb" "cluster" update begins then the "memorydb" "cluster" update completes
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a "memorydb" "cluster" update begins
    When the "memorydb" "cluster" update completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then the "memorydb" "cluster" update completes then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When the "memorydb" "cluster" update completes
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating then a "step functions" "state machine" is created then a "memorydb" "cluster" update begins
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    When a "step functions" "state machine" is created
    When a "memorydb" "cluster" update begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating then a "memorydb" "cluster" is created then the "memorydb" "cluster" update completes
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    When a "memorydb" "cluster" is created
    When the "memorydb" "cluster" update completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating then a "memorydb" "cluster" update begins then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    When a "memorydb" "cluster" update begins
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating then the "memorydb" "cluster" update completes then a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    When the "memorydb" "cluster" update completes
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating then a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds then a "memorydb" "cluster" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "memorydb" "cluster" is updating
    When a running "step functions" "execution" connects to the "AVAILABLE" MemoryDB cluster and the task succeeds
    When a "memorydb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "memorydb" "cluster" it connected to
