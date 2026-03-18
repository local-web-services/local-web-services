@stepfunctionsdocdb @generated
Feature: StepfunctionsDocdb - Action Sequences

  # Generated from FizzBee spec: stepfunctions_docdb.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionConnectedToACluster

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a DocumentDB cluster is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the DocumentDB cluster is stopped
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the DocumentDB cluster is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the DocumentDB cluster is started
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
  Scenario: a Step Functions state machine is created then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to connect because the DocumentDB cluster is stopped
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then a Step Functions state machine is created
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then the DocumentDB cluster is stopped
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then the DocumentDB cluster is started
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then an execution of the state machine is started
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then a running execution fails to connect because the DocumentDB cluster is stopped
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a Step Functions state machine is created
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a DocumentDB cluster is created
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then the DocumentDB cluster is started
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then an execution of the state machine is started
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a running execution fails to connect because the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a Step Functions state machine is created
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a DocumentDB cluster is created
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then an execution of the state machine is started
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a running execution fails to connect because the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a running execution fails to connect because the DocumentDB cluster is stopped
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
  Scenario: an execution of the state machine is started then a DocumentDB cluster is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the DocumentDB cluster is stopped
    Given smid in sm_status
    When an execution of the state machine is started
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the DocumentDB cluster is started
    Given smid in sm_status
    When an execution of the state machine is started
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to connect because the DocumentDB cluster is stopped
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a DocumentDB cluster is created
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then the DocumentDB cluster is stopped
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then the DocumentDB cluster is started
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a running execution fails to connect because the DocumentDB cluster is stopped
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then a DocumentDB cluster is created
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is stopped
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is started
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a DocumentDB cluster is created then the DocumentDB cluster is stopped
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a DocumentDB cluster is created
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a DocumentDB cluster is created then the DocumentDB cluster is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a DocumentDB cluster is created
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a DocumentDB cluster is created then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a DocumentDB cluster is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a DocumentDB cluster is created then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a DocumentDB cluster is created
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a DocumentDB cluster is created then a running execution fails to connect because the DocumentDB cluster is stopped
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a DocumentDB cluster is created
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the DocumentDB cluster is stopped then a DocumentDB cluster is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the DocumentDB cluster is stopped then the DocumentDB cluster is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the DocumentDB cluster is stopped then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the DocumentDB cluster is stopped
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the DocumentDB cluster is stopped then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the DocumentDB cluster is stopped
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the DocumentDB cluster is stopped then a running execution fails to connect because the DocumentDB cluster is stopped
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the DocumentDB cluster is stopped
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the DocumentDB cluster is started then a DocumentDB cluster is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the DocumentDB cluster is started
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the DocumentDB cluster is started then the DocumentDB cluster is stopped
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the DocumentDB cluster is started
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the DocumentDB cluster is started then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the DocumentDB cluster is started
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the DocumentDB cluster is started then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the DocumentDB cluster is started
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the DocumentDB cluster is started then a running execution fails to connect because the DocumentDB cluster is stopped
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the DocumentDB cluster is started
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a DocumentDB cluster is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then the DocumentDB cluster is stopped
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then the DocumentDB cluster is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution fails to connect because the DocumentDB cluster is stopped
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a DocumentDB cluster is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then the DocumentDB cluster is stopped
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then the DocumentDB cluster is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a running execution fails to connect because the DocumentDB cluster is stopped
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to connect because the DocumentDB cluster is stopped then a DocumentDB cluster is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is stopped
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to connect because the DocumentDB cluster is stopped then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to connect because the DocumentDB cluster is stopped then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then a Step Functions state machine is created then the DocumentDB cluster is stopped
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When a Step Functions state machine is created
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then a Step Functions state machine is created then the DocumentDB cluster is started
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When a Step Functions state machine is created
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then a Step Functions state machine is created then an execution of the state machine is started
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then a Step Functions state machine is created then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When a Step Functions state machine is created
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then a Step Functions state machine is created then a running execution fails to connect because the DocumentDB cluster is stopped
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When a Step Functions state machine is created
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then the DocumentDB cluster is stopped then a Step Functions state machine is created
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When the DocumentDB cluster is stopped
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then the DocumentDB cluster is stopped then the DocumentDB cluster is started
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then the DocumentDB cluster is stopped then an execution of the state machine is started
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When the DocumentDB cluster is stopped
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then the DocumentDB cluster is stopped then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When the DocumentDB cluster is stopped
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then the DocumentDB cluster is stopped then a running execution fails to connect because the DocumentDB cluster is stopped
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When the DocumentDB cluster is stopped
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then the DocumentDB cluster is started then a Step Functions state machine is created
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When the DocumentDB cluster is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then the DocumentDB cluster is started then the DocumentDB cluster is stopped
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When the DocumentDB cluster is started
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then the DocumentDB cluster is started then an execution of the state machine is started
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When the DocumentDB cluster is started
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then the DocumentDB cluster is started then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When the DocumentDB cluster is started
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then the DocumentDB cluster is started then a running execution fails to connect because the DocumentDB cluster is stopped
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When the DocumentDB cluster is started
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then an execution of the state machine is started then a Step Functions state machine is created
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then an execution of the state machine is started then the DocumentDB cluster is stopped
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When an execution of the state machine is started
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then an execution of the state machine is started then the DocumentDB cluster is started
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When an execution of the state machine is started
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then an execution of the state machine is started then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When an execution of the state machine is started
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then an execution of the state machine is started then a running execution fails to connect because the DocumentDB cluster is stopped
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When an execution of the state machine is started
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a Step Functions state machine is created
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then the DocumentDB cluster is stopped
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then the DocumentDB cluster is started
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then an execution of the state machine is started
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a running execution fails to connect because the DocumentDB cluster is stopped
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then a running execution fails to connect because the DocumentDB cluster is stopped then a Step Functions state machine is created
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then a running execution fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is stopped
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then a running execution fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is started
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then a running execution fails to connect because the DocumentDB cluster is stopped then an execution of the state machine is started
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then a running execution fails to connect because the DocumentDB cluster is stopped then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a Step Functions state machine is created then a DocumentDB cluster is created
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a Step Functions state machine is created
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a Step Functions state machine is created then the DocumentDB cluster is started
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a Step Functions state machine is created
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a Step Functions state machine is created then an execution of the state machine is started
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a Step Functions state machine is created then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a Step Functions state machine is created
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a Step Functions state machine is created then a running execution fails to connect because the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a Step Functions state machine is created
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a DocumentDB cluster is created then a Step Functions state machine is created
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a DocumentDB cluster is created then the DocumentDB cluster is started
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a DocumentDB cluster is created then an execution of the state machine is started
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a DocumentDB cluster is created then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a DocumentDB cluster is created then a running execution fails to connect because the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then the DocumentDB cluster is started then a Step Functions state machine is created
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then the DocumentDB cluster is started then a DocumentDB cluster is created
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then the DocumentDB cluster is started then an execution of the state machine is started
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then the DocumentDB cluster is started then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then the DocumentDB cluster is started then a running execution fails to connect because the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then an execution of the state machine is started then a Step Functions state machine is created
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then an execution of the state machine is started then a DocumentDB cluster is created
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When an execution of the state machine is started
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then an execution of the state machine is started then the DocumentDB cluster is started
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When an execution of the state machine is started
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then an execution of the state machine is started then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When an execution of the state machine is started
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then an execution of the state machine is started then a running execution fails to connect because the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When an execution of the state machine is started
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a Step Functions state machine is created
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a DocumentDB cluster is created
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then the DocumentDB cluster is started
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then an execution of the state machine is started
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a running execution fails to connect because the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a running execution fails to connect because the DocumentDB cluster is stopped then a Step Functions state machine is created
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a running execution fails to connect because the DocumentDB cluster is stopped then a DocumentDB cluster is created
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a running execution fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is started
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a running execution fails to connect because the DocumentDB cluster is stopped then an execution of the state machine is started
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a running execution fails to connect because the DocumentDB cluster is stopped then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a Step Functions state machine is created then a DocumentDB cluster is created
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a Step Functions state machine is created
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a Step Functions state machine is created then the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a Step Functions state machine is created
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a Step Functions state machine is created then an execution of the state machine is started
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a Step Functions state machine is created then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a Step Functions state machine is created
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a Step Functions state machine is created then a running execution fails to connect because the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a Step Functions state machine is created
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a DocumentDB cluster is created then a Step Functions state machine is created
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a DocumentDB cluster is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a DocumentDB cluster is created then the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a DocumentDB cluster is created
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a DocumentDB cluster is created then an execution of the state machine is started
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a DocumentDB cluster is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a DocumentDB cluster is created then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a DocumentDB cluster is created
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a DocumentDB cluster is created then a running execution fails to connect because the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a DocumentDB cluster is created
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then the DocumentDB cluster is stopped then a Step Functions state machine is created
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When the DocumentDB cluster is stopped
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then the DocumentDB cluster is stopped then a DocumentDB cluster is created
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then the DocumentDB cluster is stopped then an execution of the state machine is started
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When the DocumentDB cluster is stopped
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then the DocumentDB cluster is stopped then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When the DocumentDB cluster is stopped
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then the DocumentDB cluster is stopped then a running execution fails to connect because the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When the DocumentDB cluster is stopped
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then an execution of the state machine is started then a Step Functions state machine is created
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then an execution of the state machine is started then a DocumentDB cluster is created
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When an execution of the state machine is started
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then an execution of the state machine is started then the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When an execution of the state machine is started
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then an execution of the state machine is started then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When an execution of the state machine is started
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then an execution of the state machine is started then a running execution fails to connect because the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When an execution of the state machine is started
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a Step Functions state machine is created
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a DocumentDB cluster is created
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then an execution of the state machine is started
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a running execution fails to connect because the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a running execution fails to connect because the DocumentDB cluster is stopped then a Step Functions state machine is created
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a running execution fails to connect because the DocumentDB cluster is stopped then a DocumentDB cluster is created
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a running execution fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a running execution fails to connect because the DocumentDB cluster is stopped then an execution of the state machine is started
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a running execution fails to connect because the DocumentDB cluster is stopped then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a DocumentDB cluster is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then the DocumentDB cluster is stopped
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then the DocumentDB cluster is started
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution fails to connect because the DocumentDB cluster is stopped
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a DocumentDB cluster is created then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a DocumentDB cluster is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a DocumentDB cluster is created then the DocumentDB cluster is stopped
    Given smid in sm_status
    When an execution of the state machine is started
    When a DocumentDB cluster is created
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a DocumentDB cluster is created then the DocumentDB cluster is started
    Given smid in sm_status
    When an execution of the state machine is started
    When a DocumentDB cluster is created
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a DocumentDB cluster is created then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a DocumentDB cluster is created
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a DocumentDB cluster is created then a running execution fails to connect because the DocumentDB cluster is stopped
    Given smid in sm_status
    When an execution of the state machine is started
    When a DocumentDB cluster is created
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the DocumentDB cluster is stopped then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When the DocumentDB cluster is stopped
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the DocumentDB cluster is stopped then a DocumentDB cluster is created
    Given smid in sm_status
    When an execution of the state machine is started
    When the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the DocumentDB cluster is stopped then the DocumentDB cluster is started
    Given smid in sm_status
    When an execution of the state machine is started
    When the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the DocumentDB cluster is stopped then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When the DocumentDB cluster is stopped
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the DocumentDB cluster is stopped then a running execution fails to connect because the DocumentDB cluster is stopped
    Given smid in sm_status
    When an execution of the state machine is started
    When the DocumentDB cluster is stopped
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the DocumentDB cluster is started then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When the DocumentDB cluster is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the DocumentDB cluster is started then a DocumentDB cluster is created
    Given smid in sm_status
    When an execution of the state machine is started
    When the DocumentDB cluster is started
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the DocumentDB cluster is started then the DocumentDB cluster is stopped
    Given smid in sm_status
    When an execution of the state machine is started
    When the DocumentDB cluster is started
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the DocumentDB cluster is started then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When the DocumentDB cluster is started
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the DocumentDB cluster is started then a running execution fails to connect because the DocumentDB cluster is stopped
    Given smid in sm_status
    When an execution of the state machine is started
    When the DocumentDB cluster is started
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a DocumentDB cluster is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then the DocumentDB cluster is stopped
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then the DocumentDB cluster is started
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a running execution fails to connect because the DocumentDB cluster is stopped
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to connect because the DocumentDB cluster is stopped then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to connect because the DocumentDB cluster is stopped then a DocumentDB cluster is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is stopped
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is started
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to connect because the DocumentDB cluster is stopped then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a Step Functions state machine is created then a DocumentDB cluster is created
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a Step Functions state machine is created
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a Step Functions state machine is created then the DocumentDB cluster is stopped
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a Step Functions state machine is created
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a Step Functions state machine is created then the DocumentDB cluster is started
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a Step Functions state machine is created
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a Step Functions state machine is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a Step Functions state machine is created then a running execution fails to connect because the DocumentDB cluster is stopped
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a Step Functions state machine is created
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a DocumentDB cluster is created then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a DocumentDB cluster is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a DocumentDB cluster is created then the DocumentDB cluster is stopped
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a DocumentDB cluster is created
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a DocumentDB cluster is created then the DocumentDB cluster is started
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a DocumentDB cluster is created
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a DocumentDB cluster is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a DocumentDB cluster is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a DocumentDB cluster is created then a running execution fails to connect because the DocumentDB cluster is stopped
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a DocumentDB cluster is created
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then the DocumentDB cluster is stopped then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When the DocumentDB cluster is stopped
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then the DocumentDB cluster is stopped then a DocumentDB cluster is created
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then the DocumentDB cluster is stopped then the DocumentDB cluster is started
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then the DocumentDB cluster is stopped then an execution of the state machine is started
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When the DocumentDB cluster is stopped
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then the DocumentDB cluster is stopped then a running execution fails to connect because the DocumentDB cluster is stopped
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When the DocumentDB cluster is stopped
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then the DocumentDB cluster is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When the DocumentDB cluster is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then the DocumentDB cluster is started then a DocumentDB cluster is created
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When the DocumentDB cluster is started
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then the DocumentDB cluster is started then the DocumentDB cluster is stopped
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When the DocumentDB cluster is started
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then the DocumentDB cluster is started then an execution of the state machine is started
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When the DocumentDB cluster is started
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then the DocumentDB cluster is started then a running execution fails to connect because the DocumentDB cluster is stopped
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When the DocumentDB cluster is started
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then an execution of the state machine is started then a DocumentDB cluster is created
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When an execution of the state machine is started
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then an execution of the state machine is started then the DocumentDB cluster is stopped
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When an execution of the state machine is started
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then an execution of the state machine is started then the DocumentDB cluster is started
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When an execution of the state machine is started
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then an execution of the state machine is started then a running execution fails to connect because the DocumentDB cluster is stopped
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When an execution of the state machine is started
    When a running execution fails to connect because the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a running execution fails to connect because the DocumentDB cluster is stopped then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a running execution fails to connect because the DocumentDB cluster is stopped then a DocumentDB cluster is created
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a running execution fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is stopped
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a running execution fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is started
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a running execution fails to connect because the DocumentDB cluster is stopped then an execution of the state machine is started
    Given eid in exec_status
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then a Step Functions state machine is created then a DocumentDB cluster is created
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a Step Functions state machine is created
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then a Step Functions state machine is created then the DocumentDB cluster is stopped
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a Step Functions state machine is created
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then a Step Functions state machine is created then the DocumentDB cluster is started
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a Step Functions state machine is created
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then a Step Functions state machine is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then a Step Functions state machine is created then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a Step Functions state machine is created
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then a DocumentDB cluster is created then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then a DocumentDB cluster is created then the DocumentDB cluster is stopped
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then a DocumentDB cluster is created then the DocumentDB cluster is started
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then a DocumentDB cluster is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then a DocumentDB cluster is created then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is stopped then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is stopped
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is stopped then a DocumentDB cluster is created
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is stopped then the DocumentDB cluster is started
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is stopped then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is stopped
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is stopped then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is stopped
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is started then a DocumentDB cluster is created
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is started then the DocumentDB cluster is stopped
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is started then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is started then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then an execution of the state machine is started then a DocumentDB cluster is created
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When an execution of the state machine is started
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then an execution of the state machine is started then the DocumentDB cluster is stopped
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When an execution of the state machine is started
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then an execution of the state machine is started then the DocumentDB cluster is started
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When an execution of the state machine is started
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then an execution of the state machine is started then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When an execution of the state machine is started
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then a DocumentDB cluster is created
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When a DocumentDB cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then the DocumentDB cluster is stopped
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When the DocumentDB cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then the DocumentDB cluster is started
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When the DocumentDB cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the DocumentDB cluster is stopped then a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to connect because the DocumentDB cluster is stopped
    When a running execution connects to the "AVAILABLE" DocumentDB cluster and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it connected to
