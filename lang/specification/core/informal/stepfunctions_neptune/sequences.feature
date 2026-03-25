@stepfunctionsneptune @generated
Feature: StepfunctionsNeptune - Action Sequences

  # Generated from FizzBee spec: stepfunctions_neptune.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedACluster

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Neptune cluster is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Neptune cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Neptune cluster is stopped
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Neptune cluster is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the Neptune cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to query because the Neptune cluster is stopped
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to query because the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then a Step Functions state machine is created
    Given cid not in cluster_status
    When a Neptune cluster is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is stopped
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is started
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Neptune cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then an execution of the state machine is started
    Given cid not in cluster_status
    When a Neptune cluster is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given cid not in cluster_status
    When a Neptune cluster is created
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then a running execution fails to query because the Neptune cluster is stopped
    Given cid not in cluster_status
    When a Neptune cluster is created
    When a running execution fails to query because the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a Step Functions state machine is created
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a Neptune cluster is created
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When a Neptune cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Neptune cluster is started
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Neptune cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then an execution of the state machine is started
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a running execution fails to query because the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When a running execution fails to query because the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a Step Functions state machine is created
    Given cid in cluster_status
    When the Neptune cluster is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a Neptune cluster is created
    Given cid in cluster_status
    When the Neptune cluster is started
    When a Neptune cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then an execution of the state machine is started
    Given cid in cluster_status
    When the Neptune cluster is started
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given cid in cluster_status
    When the Neptune cluster is started
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a running execution fails to query because the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is started
    When a running execution fails to query because the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Neptune cluster is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Neptune cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the Neptune cluster is stopped
    Given smid in sm_status
    When an execution of the state machine is started
    When the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the Neptune cluster is started
    Given smid in sm_status
    When an execution of the state machine is started
    When the Neptune cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to query because the Neptune cluster is stopped
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to query because the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then a Neptune cluster is created
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    When a Neptune cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then the Neptune cluster is stopped
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    When the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then the Neptune cluster is started
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    When the Neptune cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then a running execution fails to query because the Neptune cluster is stopped
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    When a running execution fails to query because the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to query because the Neptune cluster is stopped
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then a Neptune cluster is created
    Given eid in exec_status
    When a running execution fails to query because the Neptune cluster is stopped
    When a Neptune cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then the Neptune cluster is stopped
    Given eid in exec_status
    When a running execution fails to query because the Neptune cluster is stopped
    When the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then the Neptune cluster is started
    Given eid in exec_status
    When a running execution fails to query because the Neptune cluster is stopped
    When the Neptune cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to query because the Neptune cluster is stopped
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given eid in exec_status
    When a running execution fails to query because the Neptune cluster is stopped
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Neptune cluster is created then the Neptune cluster is stopped
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a Neptune cluster is created
    When the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Neptune cluster is stopped then the Neptune cluster is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the Neptune cluster is stopped
    When the Neptune cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Neptune cluster is started then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the Neptune cluster is started
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then a running execution fails to query because the Neptune cluster is stopped
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    When a running execution fails to query because the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to query because the Neptune cluster is stopped then a Neptune cluster is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to query because the Neptune cluster is stopped
    When a Neptune cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then a Step Functions state machine is created then the Neptune cluster is started
    Given cid not in cluster_status
    When a Neptune cluster is created
    When a Step Functions state machine is created
    When the Neptune cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is stopped then an execution of the state machine is started
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Neptune cluster is stopped
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is started then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Neptune cluster is started
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then an execution of the state machine is started then a running execution fails to query because the Neptune cluster is stopped
    Given cid not in cluster_status
    When a Neptune cluster is created
    When an execution of the state machine is started
    When a running execution fails to query because the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then a Step Functions state machine is created
    Given cid not in cluster_status
    When a Neptune cluster is created
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then a running execution fails to query because the Neptune cluster is stopped then the Neptune cluster is stopped
    Given cid not in cluster_status
    When a Neptune cluster is created
    When a running execution fails to query because the Neptune cluster is stopped
    When the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a Step Functions state machine is created then an execution of the state machine is started
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a Neptune cluster is created then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When a Neptune cluster is created
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Neptune cluster is started then a running execution fails to query because the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Neptune cluster is started
    When a running execution fails to query because the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then an execution of the state machine is started then a Step Functions state machine is created
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then a Neptune cluster is created
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    When a Neptune cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a running execution fails to query because the Neptune cluster is stopped then the Neptune cluster is started
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When a running execution fails to query because the Neptune cluster is stopped
    When the Neptune cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a Step Functions state machine is created then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given cid in cluster_status
    When the Neptune cluster is started
    When a Step Functions state machine is created
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a Neptune cluster is created then a running execution fails to query because the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is started
    When a Neptune cluster is created
    When a running execution fails to query because the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Neptune cluster is stopped then a Step Functions state machine is created
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Neptune cluster is stopped
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then an execution of the state machine is started then a Neptune cluster is created
    Given cid in cluster_status
    When the Neptune cluster is started
    When an execution of the state machine is started
    When a Neptune cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is started
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    When the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a running execution fails to query because the Neptune cluster is stopped then an execution of the state machine is started
    Given cid in cluster_status
    When the Neptune cluster is started
    When a running execution fails to query because the Neptune cluster is stopped
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution fails to query because the Neptune cluster is stopped
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a running execution fails to query because the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Neptune cluster is created then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Neptune cluster is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the Neptune cluster is stopped then a Neptune cluster is created
    Given smid in sm_status
    When an execution of the state machine is started
    When the Neptune cluster is stopped
    When a Neptune cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the Neptune cluster is started then the Neptune cluster is stopped
    Given smid in sm_status
    When an execution of the state machine is started
    When the Neptune cluster is started
    When the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then the Neptune cluster is started
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    When the Neptune cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to query because the Neptune cluster is stopped then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to query because the Neptune cluster is stopped
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then a Step Functions state machine is created then a Neptune cluster is created
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    When a Step Functions state machine is created
    When a Neptune cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then a Neptune cluster is created then the Neptune cluster is stopped
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    When a Neptune cluster is created
    When the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then the Neptune cluster is stopped then the Neptune cluster is started
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    When the Neptune cluster is stopped
    When the Neptune cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then the Neptune cluster is started then an execution of the state machine is started
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    When the Neptune cluster is started
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then an execution of the state machine is started then a running execution fails to query because the Neptune cluster is stopped
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    When an execution of the state machine is started
    When a running execution fails to query because the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then a running execution fails to query because the Neptune cluster is stopped then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    When a running execution fails to query because the Neptune cluster is stopped
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then a Step Functions state machine is created then the Neptune cluster is stopped
    Given eid in exec_status
    When a running execution fails to query because the Neptune cluster is stopped
    When a Step Functions state machine is created
    When the Neptune cluster is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then a Neptune cluster is created then the Neptune cluster is started
    Given eid in exec_status
    When a running execution fails to query because the Neptune cluster is stopped
    When a Neptune cluster is created
    When the Neptune cluster is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then the Neptune cluster is stopped then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to query because the Neptune cluster is stopped
    When the Neptune cluster is stopped
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then the Neptune cluster is started then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given eid in exec_status
    When a running execution fails to query because the Neptune cluster is stopped
    When the Neptune cluster is started
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to query because the Neptune cluster is stopped
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then a Neptune cluster is created
    Given eid in exec_status
    When a running execution fails to query because the Neptune cluster is stopped
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    When a Neptune cluster is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried
