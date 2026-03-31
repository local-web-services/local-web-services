@stepfunctionsneptune @generated
Feature: StepfunctionsNeptune - Action Sequences

  # Generated from FizzBee spec: stepfunctions_neptune.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionQueriedACluster

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "step functions" "state machine" is created then a "neptune" "cluster" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "neptune" "cluster" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a "step functions" "state machine" is created then the "neptune" "cluster" is stopped
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a "step functions" "state machine" is created then the "neptune" "cluster" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "neptune" "cluster" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then a "step functions" "state machine" is created
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then the "neptune" "cluster" is stopped
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then the "neptune" "cluster" is started
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When the "neptune" "cluster" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then a "step functions" "state machine" is created
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then a "neptune" "cluster" is created
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When a "neptune" "cluster" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then the "neptune" "cluster" is started
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When the "neptune" "cluster" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then a "step functions" "state machine" is created
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then a "neptune" "cluster" is created
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When a "neptune" "cluster" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then the "neptune" "cluster" is stopped
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "neptune" "cluster" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "neptune" "cluster" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the "neptune" "cluster" is stopped
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the "neptune" "cluster" is started
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "neptune" "cluster" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds then a "neptune" "cluster" is created
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    When a "neptune" "cluster" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds then the "neptune" "cluster" is stopped
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    When the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds then the "neptune" "cluster" is started
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    When the "neptune" "cluster" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds then a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped then a "neptune" "cluster" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    When a "neptune" "cluster" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped then the "neptune" "cluster" is stopped
    Given eid in exec_status
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    When the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped then the "neptune" "cluster" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    When the "neptune" "cluster" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped then a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a "step functions" "state machine" is created then a "neptune" "cluster" is created then the "neptune" "cluster" is stopped
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "neptune" "cluster" is created
    When the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a "step functions" "state machine" is created then the "neptune" "cluster" is stopped then the "neptune" "cluster" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "neptune" "cluster" is stopped
    When the "neptune" "cluster" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a "step functions" "state machine" is created then the "neptune" "cluster" is started then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "neptune" "cluster" is started
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds then a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped then a "neptune" "cluster" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    When a "neptune" "cluster" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then a "step functions" "state machine" is created then the "neptune" "cluster" is started
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When a "step functions" "state machine" is created
    When the "neptune" "cluster" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then the "neptune" "cluster" is stopped then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When the "neptune" "cluster" is stopped
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then the "neptune" "cluster" is started then a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When the "neptune" "cluster" is started
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds then a "step functions" "state machine" is created
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped then the "neptune" "cluster" is stopped
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    When the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then a "neptune" "cluster" is created then a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When a "neptune" "cluster" is created
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then the "neptune" "cluster" is started then a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When the "neptune" "cluster" is started
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds then a "neptune" "cluster" is created
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    When a "neptune" "cluster" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped then the "neptune" "cluster" is started
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    When the "neptune" "cluster" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then a "step functions" "state machine" is created then a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then a "neptune" "cluster" is created then a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When a "neptune" "cluster" is created
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then the "neptune" "cluster" is stopped then a "step functions" "state machine" is created
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When the "neptune" "cluster" is stopped
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then an "step functions" "execution" of the "step functions" "state machine" is started then a "neptune" "cluster" is created
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "neptune" "cluster" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds then the "neptune" "cluster" is stopped
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    When the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created then a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "neptune" "cluster" is created then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "neptune" "cluster" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the "neptune" "cluster" is stopped then a "neptune" "cluster" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "neptune" "cluster" is stopped
    When a "neptune" "cluster" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the "neptune" "cluster" is started then the "neptune" "cluster" is stopped
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "neptune" "cluster" is started
    When the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds then the "neptune" "cluster" is started
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    When the "neptune" "cluster" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped then a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds then a "step functions" "state machine" is created then a "neptune" "cluster" is created
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    When a "step functions" "state machine" is created
    When a "neptune" "cluster" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds then a "neptune" "cluster" is created then the "neptune" "cluster" is stopped
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    When a "neptune" "cluster" is created
    When the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds then the "neptune" "cluster" is stopped then the "neptune" "cluster" is started
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    When the "neptune" "cluster" is stopped
    When the "neptune" "cluster" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds then the "neptune" "cluster" is started then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    When the "neptune" "cluster" is started
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds then a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped then a "step functions" "state machine" is created then the "neptune" "cluster" is stopped
    Given eid in exec_status
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    When a "step functions" "state machine" is created
    When the "neptune" "cluster" is stopped
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped then a "neptune" "cluster" is created then the "neptune" "cluster" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    When a "neptune" "cluster" is created
    When the "neptune" "cluster" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped then the "neptune" "cluster" is stopped then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    When the "neptune" "cluster" is stopped
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped then the "neptune" "cluster" is started then a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    When the "neptune" "cluster" is started
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried

  @sequence
  Scenario: a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped then a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds then a "neptune" "cluster" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to query because the "neptune" "cluster" is stopped
    When a running "step functions" "execution" queries the "AVAILABLE" Neptune cluster and the task succeeds
    When a "neptune" "cluster" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it queried
