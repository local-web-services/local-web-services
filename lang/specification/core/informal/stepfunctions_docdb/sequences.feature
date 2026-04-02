@stepfunctionsdocdb @generated
Feature: StepfunctionsDocdb - Action Sequences

  # Generated from FizzBee spec: stepfunctions_docdb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "step functions" "state machine" is created then a "documentdb" "cluster" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "documentdb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a "step functions" "state machine" is created then the "documentdb" "cluster" is stopped
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a "step functions" "state machine" is created then the "documentdb" "cluster" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "documentdb" "cluster" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "step functions" "state machine" is created
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a "documentdb" "cluster" is created then the "documentdb" "cluster" is stopped
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a "documentdb" "cluster" is created then the "documentdb" "cluster" is started
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When the "documentdb" "cluster" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a "documentdb" "cluster" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a "documentdb" "cluster" is created then a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a "documentdb" "cluster" is created then a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then a "step functions" "state machine" is created
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When a "documentdb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then the "documentdb" "cluster" is started
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When the "documentdb" "cluster" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is started then a "step functions" "state machine" is created
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is started then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When a "documentdb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is started then the "documentdb" "cluster" is stopped
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is started then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is started then a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is started then a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "documentdb" "cluster" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "documentdb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the "documentdb" "cluster" is stopped
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the "documentdb" "cluster" is started
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "documentdb" "cluster" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds then a "documentdb" "cluster" is created
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    When a "documentdb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds then the "documentdb" "cluster" is stopped
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    When the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds then the "documentdb" "cluster" is started
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    When the "documentdb" "cluster" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds then a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped then a "documentdb" "cluster" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    When a "documentdb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped then the "documentdb" "cluster" is stopped
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    When the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped then the "documentdb" "cluster" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    When the "documentdb" "cluster" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped then a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a "step functions" "state machine" is created then a "documentdb" "cluster" is created then the "documentdb" "cluster" is stopped
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "documentdb" "cluster" is created
    When the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a "step functions" "state machine" is created then the "documentdb" "cluster" is stopped then the "documentdb" "cluster" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "documentdb" "cluster" is stopped
    When the "documentdb" "cluster" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a "step functions" "state machine" is created then the "documentdb" "cluster" is started then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "documentdb" "cluster" is started
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds then a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped then a "documentdb" "cluster" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    When a "documentdb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "step functions" "state machine" is created then the "documentdb" "cluster" is started
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "step functions" "state machine" is created
    When the "documentdb" "cluster" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a "documentdb" "cluster" is created then the "documentdb" "cluster" is stopped then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When the "documentdb" "cluster" is stopped
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a "documentdb" "cluster" is created then the "documentdb" "cluster" is started then a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When the "documentdb" "cluster" is started
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a "documentdb" "cluster" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a "documentdb" "cluster" is created then a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds then a "step functions" "state machine" is created
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a "documentdb" "cluster" is created then a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped then the "documentdb" "cluster" is stopped
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    When the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then a "documentdb" "cluster" is created then a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When a "documentdb" "cluster" is created
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then the "documentdb" "cluster" is started then a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When the "documentdb" "cluster" is started
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    When a "documentdb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped then the "documentdb" "cluster" is started
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    When the "documentdb" "cluster" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is started then a "step functions" "state machine" is created then a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is started then a "documentdb" "cluster" is created then a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When a "documentdb" "cluster" is created
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is started then the "documentdb" "cluster" is stopped then a "step functions" "state machine" is created
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When the "documentdb" "cluster" is stopped
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is started then an "step functions" "execution" of the "step functions" "state machine" is started then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "documentdb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is started then a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds then the "documentdb" "cluster" is stopped
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    When the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: the "documentdb" "cluster" is started then a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created then a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "documentdb" "cluster" is created then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "documentdb" "cluster" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the "documentdb" "cluster" is stopped then a "documentdb" "cluster" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "documentdb" "cluster" is stopped
    When a "documentdb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the "documentdb" "cluster" is started then the "documentdb" "cluster" is stopped
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "documentdb" "cluster" is started
    When the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds then the "documentdb" "cluster" is started
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    When the "documentdb" "cluster" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped then a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds then a "step functions" "state machine" is created then a "documentdb" "cluster" is created
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    When a "step functions" "state machine" is created
    When a "documentdb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds then a "documentdb" "cluster" is created then the "documentdb" "cluster" is stopped
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    When a "documentdb" "cluster" is created
    When the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds then the "documentdb" "cluster" is stopped then the "documentdb" "cluster" is started
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    When the "documentdb" "cluster" is stopped
    When the "documentdb" "cluster" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds then the "documentdb" "cluster" is started then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    When the "documentdb" "cluster" is started
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds then a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped then a "step functions" "state machine" is created then the "documentdb" "cluster" is stopped
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    When a "step functions" "state machine" is created
    When the "documentdb" "cluster" is stopped
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped then a "documentdb" "cluster" is created then the "documentdb" "cluster" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    When a "documentdb" "cluster" is created
    When the "documentdb" "cluster" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped then the "documentdb" "cluster" is stopped then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    When the "documentdb" "cluster" is stopped
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped then the "documentdb" "cluster" is started then a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    When the "documentdb" "cluster" is started
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped then a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds then a "documentdb" "cluster" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the "documentdb" "cluster" is stopped
    When a running "step functions" "execution" connects to the "documentdb" "cluster" that was "AVAILABLE" and the task succeeds
    When a "documentdb" "cluster" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "documentdb" "cluster" it connected to
