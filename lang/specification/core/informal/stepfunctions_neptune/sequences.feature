@stepfunctionsneptune @generated
Feature: StepfunctionsNeptune - Action Sequences

  # Generated from FizzBee spec: stepfunctions_neptune.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedACluster

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Neptune cluster is created
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a Neptune cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Neptune cluster is stopped
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Neptune cluster is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When the Neptune cluster is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to query because the Neptune cluster is stopped
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution fails to query because the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then a Step Functions state machine is created
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is stopped
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    When the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is started
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    When the Neptune cluster is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then an execution of the state machine is started
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then a running execution fails to query because the Neptune cluster is stopped
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    When a running execution fails to query because the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a Step Functions state machine is created
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a Neptune cluster is created
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    When a Neptune cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Neptune cluster is started
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    When the Neptune cluster is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then an execution of the state machine is started
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a running execution fails to query because the Neptune cluster is stopped
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    When a running execution fails to query because the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a Step Functions state machine is created
    Given cid in cluster_status
    Given the Neptune cluster has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a Neptune cluster is created
    Given cid in cluster_status
    Given the Neptune cluster has been started
    When a Neptune cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Neptune cluster is stopped
    Given cid in cluster_status
    Given the Neptune cluster has been started
    When the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then an execution of the state machine is started
    Given cid in cluster_status
    Given the Neptune cluster has been started
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given cid in cluster_status
    Given the Neptune cluster has been started
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a running execution fails to query because the Neptune cluster is stopped
    Given cid in cluster_status
    Given the Neptune cluster has been started
    When a running execution fails to query because the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Neptune cluster is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a Neptune cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the Neptune cluster is stopped
    Given smid in sm_status
    Given an execution of the state machine has been started
    When the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the Neptune cluster is started
    Given smid in sm_status
    Given an execution of the state machine has been started
    When the Neptune cluster is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to query because the Neptune cluster is stopped
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution fails to query because the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" Neptune cluster and the task succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then a Neptune cluster is created
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" Neptune cluster and the task succeeded
    When a Neptune cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then the Neptune cluster is stopped
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" Neptune cluster and the task succeeded
    When the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then the Neptune cluster is started
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" Neptune cluster and the task succeeded
    When the Neptune cluster is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" Neptune cluster and the task succeeded
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then a running execution fails to query because the Neptune cluster is stopped
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" Neptune cluster and the task succeeded
    When a running execution fails to query because the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has failed to query because the Neptune cluster is stopped
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then a Neptune cluster is created
    Given eid in exec_status
    Given a running execution has failed to query because the Neptune cluster is stopped
    When a Neptune cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then the Neptune cluster is stopped
    Given eid in exec_status
    Given a running execution has failed to query because the Neptune cluster is stopped
    When the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then the Neptune cluster is started
    Given eid in exec_status
    Given a running execution has failed to query because the Neptune cluster is stopped
    When the Neptune cluster is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has failed to query because the Neptune cluster is stopped
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given eid in exec_status
    Given a running execution has failed to query because the Neptune cluster is stopped
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a Neptune cluster is created then the Neptune cluster is stopped
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a Neptune cluster has been created
    When the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Neptune cluster is stopped then the Neptune cluster is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given the Neptune cluster has been stopped
    When the Neptune cluster is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the Neptune cluster is started then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given the Neptune cluster has been started
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an execution of the state machine has been started
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then a running execution fails to query because the Neptune cluster is stopped
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has queried the "AVAILABLE" Neptune cluster and the task succeeded
    When a running execution fails to query because the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to query because the Neptune cluster is stopped then a Neptune cluster is created
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has failed to query because the Neptune cluster is stopped
    When a Neptune cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then a Step Functions state machine is created then the Neptune cluster is started
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    Given a Step Functions state machine has been created
    When the Neptune cluster is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is stopped then an execution of the state machine is started
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    Given the Neptune cluster has been stopped
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is started then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    Given the Neptune cluster has been started
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then an execution of the state machine is started then a running execution fails to query because the Neptune cluster is stopped
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    Given an execution of the state machine has been started
    When a running execution fails to query because the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then a Step Functions state machine is created
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    Given a running execution has queried the "AVAILABLE" Neptune cluster and the task succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then a running execution fails to query because the Neptune cluster is stopped then the Neptune cluster is stopped
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    Given a running execution has failed to query because the Neptune cluster is stopped
    When the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a Step Functions state machine is created then an execution of the state machine is started
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a Neptune cluster is created then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    Given a Neptune cluster has been created
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Neptune cluster is started then a running execution fails to query because the Neptune cluster is stopped
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    Given the Neptune cluster has been started
    When a running execution fails to query because the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then an execution of the state machine is started then a Step Functions state machine is created
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then a Neptune cluster is created
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    Given a running execution has queried the "AVAILABLE" Neptune cluster and the task succeeded
    When a Neptune cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a running execution fails to query because the Neptune cluster is stopped then the Neptune cluster is started
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    Given a running execution has failed to query because the Neptune cluster is stopped
    When the Neptune cluster is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a Step Functions state machine is created then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given cid in cluster_status
    Given the Neptune cluster has been started
    Given a Step Functions state machine has been created
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a Neptune cluster is created then a running execution fails to query because the Neptune cluster is stopped
    Given cid in cluster_status
    Given the Neptune cluster has been started
    Given a Neptune cluster has been created
    When a running execution fails to query because the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Neptune cluster is stopped then a Step Functions state machine is created
    Given cid in cluster_status
    Given the Neptune cluster has been started
    Given the Neptune cluster has been stopped
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then an execution of the state machine is started then a Neptune cluster is created
    Given cid in cluster_status
    Given the Neptune cluster has been started
    Given an execution of the state machine has been started
    When a Neptune cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then the Neptune cluster is stopped
    Given cid in cluster_status
    Given the Neptune cluster has been started
    Given a running execution has queried the "AVAILABLE" Neptune cluster and the task succeeded
    When the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a running execution fails to query because the Neptune cluster is stopped then an execution of the state machine is started
    Given cid in cluster_status
    Given the Neptune cluster has been started
    Given a running execution has failed to query because the Neptune cluster is stopped
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution fails to query because the Neptune cluster is stopped
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a Step Functions state machine has been created
    When a running execution fails to query because the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Neptune cluster is created then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a Neptune cluster has been created
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the Neptune cluster is stopped then a Neptune cluster is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given the Neptune cluster has been stopped
    When a Neptune cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the Neptune cluster is started then the Neptune cluster is stopped
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given the Neptune cluster has been started
    When the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then the Neptune cluster is started
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has queried the "AVAILABLE" Neptune cluster and the task succeeded
    When the Neptune cluster is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to query because the Neptune cluster is stopped then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has failed to query because the Neptune cluster is stopped
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then a Step Functions state machine is created then a Neptune cluster is created
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" Neptune cluster and the task succeeded
    Given a Step Functions state machine has been created
    When a Neptune cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then a Neptune cluster is created then the Neptune cluster is stopped
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" Neptune cluster and the task succeeded
    Given a Neptune cluster has been created
    When the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then the Neptune cluster is stopped then the Neptune cluster is started
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" Neptune cluster and the task succeeded
    Given the Neptune cluster has been stopped
    When the Neptune cluster is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then the Neptune cluster is started then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" Neptune cluster and the task succeeded
    Given the Neptune cluster has been started
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then an execution of the state machine is started then a running execution fails to query because the Neptune cluster is stopped
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" Neptune cluster and the task succeeded
    Given an execution of the state machine has been started
    When a running execution fails to query because the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then a running execution fails to query because the Neptune cluster is stopped then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has queried the "AVAILABLE" Neptune cluster and the task succeeded
    Given a running execution has failed to query because the Neptune cluster is stopped
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then a Step Functions state machine is created then the Neptune cluster is stopped
    Given eid in exec_status
    Given a running execution has failed to query because the Neptune cluster is stopped
    Given a Step Functions state machine has been created
    When the Neptune cluster is stopped
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then a Neptune cluster is created then the Neptune cluster is started
    Given eid in exec_status
    Given a running execution has failed to query because the Neptune cluster is stopped
    Given a Neptune cluster has been created
    When the Neptune cluster is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then the Neptune cluster is stopped then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has failed to query because the Neptune cluster is stopped
    Given the Neptune cluster has been stopped
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then the Neptune cluster is started then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given eid in exec_status
    Given a running execution has failed to query because the Neptune cluster is stopped
    Given the Neptune cluster has been started
    When a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has failed to query because the Neptune cluster is stopped
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a running execution fails to query because the Neptune cluster is stopped then a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds then a Neptune cluster is created
    Given eid in exec_status
    Given a running execution has failed to query because the Neptune cluster is stopped
    Given a running execution has queried the "AVAILABLE" Neptune cluster and the task succeeded
    When a Neptune cluster is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried
