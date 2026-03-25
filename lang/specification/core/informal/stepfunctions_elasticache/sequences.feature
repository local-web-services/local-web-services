@stepfunctionselasticache @generated
Feature: StepfunctionsElasticache - Action Sequences

  # Generated from FizzBee spec: stepfunctions_elasticache.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadACluster

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a cluster modification begins
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a cluster modification begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the cluster modification completes
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the cluster modification completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to connect because the cluster is being modified
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to connect because the cluster is being modified
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then a Step Functions state machine is created
    Given cid not in cluster_status
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then a cluster modification begins
    Given cid not in cluster_status
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    When a cluster modification begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then the cluster modification completes
    Given cid not in cluster_status
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    When the cluster modification completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then an execution of the state machine is started
    Given cid not in cluster_status
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given cid not in cluster_status
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then a running execution fails to connect because the cluster is being modified
    Given cid not in cluster_status
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    When a running execution fails to connect because the cluster is being modified
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a cluster modification begins then a Step Functions state machine is created
    Given cid in cluster_status
    When a cluster modification begins
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a cluster modification begins then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When a cluster modification begins
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a cluster modification begins then the cluster modification completes
    Given cid in cluster_status
    When a cluster modification begins
    When the cluster modification completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a cluster modification begins then an execution of the state machine is started
    Given cid in cluster_status
    When a cluster modification begins
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a cluster modification begins then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given cid in cluster_status
    When a cluster modification begins
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a cluster modification begins then a running execution fails to connect because the cluster is being modified
    Given cid in cluster_status
    When a cluster modification begins
    When a running execution fails to connect because the cluster is being modified
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: the cluster modification completes then a Step Functions state machine is created
    Given cid in cluster_status
    When the cluster modification completes
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: the cluster modification completes then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When the cluster modification completes
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: the cluster modification completes then a cluster modification begins
    Given cid in cluster_status
    When the cluster modification completes
    When a cluster modification begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: the cluster modification completes then an execution of the state machine is started
    Given cid in cluster_status
    When the cluster modification completes
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: the cluster modification completes then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given cid in cluster_status
    When the cluster modification completes
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: the cluster modification completes then a running execution fails to connect because the cluster is being modified
    Given cid in cluster_status
    When the cluster modification completes
    When a running execution fails to connect because the cluster is being modified
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given smid in sm_status
    When an execution of the state machine is started
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a cluster modification begins
    Given smid in sm_status
    When an execution of the state machine is started
    When a cluster modification begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the cluster modification completes
    Given smid in sm_status
    When an execution of the state machine is started
    When the cluster modification completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to connect because the cluster is being modified
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to connect because the cluster is being modified
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given eid in exec_status
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then a cluster modification begins
    Given eid in exec_status
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When a cluster modification begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then the cluster modification completes
    Given eid in exec_status
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When the cluster modification completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then a running execution fails to connect because the cluster is being modified
    Given eid in exec_status
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When a running execution fails to connect because the cluster is being modified
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to connect because the cluster is being modified
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given eid in exec_status
    When a running execution fails to connect because the cluster is being modified
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then a cluster modification begins
    Given eid in exec_status
    When a running execution fails to connect because the cluster is being modified
    When a cluster modification begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then the cluster modification completes
    Given eid in exec_status
    When a running execution fails to connect because the cluster is being modified
    When the cluster modification completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to connect because the cluster is being modified
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given eid in exec_status
    When a running execution fails to connect because the cluster is being modified
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an ElastiCache cluster is created and becomes "AVAILABLE" then a cluster modification begins
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    When a cluster modification begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a cluster modification begins then the cluster modification completes
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a cluster modification begins
    When the cluster modification completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the cluster modification completes then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the cluster modification completes
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then a running execution fails to connect because the cluster is being modified
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When a running execution fails to connect because the cluster is being modified
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to connect because the cluster is being modified then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to connect because the cluster is being modified
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then a Step Functions state machine is created then the cluster modification completes
    Given cid not in cluster_status
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    When a Step Functions state machine is created
    When the cluster modification completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then a cluster modification begins then an execution of the state machine is started
    Given cid not in cluster_status
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    When a cluster modification begins
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then the cluster modification completes then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given cid not in cluster_status
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    When the cluster modification completes
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then an execution of the state machine is started then a running execution fails to connect because the cluster is being modified
    Given cid not in cluster_status
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    When an execution of the state machine is started
    When a running execution fails to connect because the cluster is being modified
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then a Step Functions state machine is created
    Given cid not in cluster_status
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then a running execution fails to connect because the cluster is being modified then a cluster modification begins
    Given cid not in cluster_status
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    When a running execution fails to connect because the cluster is being modified
    When a cluster modification begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a cluster modification begins then a Step Functions state machine is created then an execution of the state machine is started
    Given cid in cluster_status
    When a cluster modification begins
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a cluster modification begins then an ElastiCache cluster is created and becomes "AVAILABLE" then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given cid in cluster_status
    When a cluster modification begins
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a cluster modification begins then the cluster modification completes then a running execution fails to connect because the cluster is being modified
    Given cid in cluster_status
    When a cluster modification begins
    When the cluster modification completes
    When a running execution fails to connect because the cluster is being modified
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a cluster modification begins then an execution of the state machine is started then a Step Functions state machine is created
    Given cid in cluster_status
    When a cluster modification begins
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a cluster modification begins then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When a cluster modification begins
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a cluster modification begins then a running execution fails to connect because the cluster is being modified then the cluster modification completes
    Given cid in cluster_status
    When a cluster modification begins
    When a running execution fails to connect because the cluster is being modified
    When the cluster modification completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: the cluster modification completes then a Step Functions state machine is created then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given cid in cluster_status
    When the cluster modification completes
    When a Step Functions state machine is created
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: the cluster modification completes then an ElastiCache cluster is created and becomes "AVAILABLE" then a running execution fails to connect because the cluster is being modified
    Given cid in cluster_status
    When the cluster modification completes
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    When a running execution fails to connect because the cluster is being modified
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: the cluster modification completes then a cluster modification begins then a Step Functions state machine is created
    Given cid in cluster_status
    When the cluster modification completes
    When a cluster modification begins
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: the cluster modification completes then an execution of the state machine is started then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When the cluster modification completes
    When an execution of the state machine is started
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: the cluster modification completes then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then a cluster modification begins
    Given cid in cluster_status
    When the cluster modification completes
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When a cluster modification begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: the cluster modification completes then a running execution fails to connect because the cluster is being modified then an execution of the state machine is started
    Given cid in cluster_status
    When the cluster modification completes
    When a running execution fails to connect because the cluster is being modified
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution fails to connect because the cluster is being modified
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a running execution fails to connect because the cluster is being modified
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an ElastiCache cluster is created and becomes "AVAILABLE" then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a cluster modification begins then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given smid in sm_status
    When an execution of the state machine is started
    When a cluster modification begins
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the cluster modification completes then a cluster modification begins
    Given smid in sm_status
    When an execution of the state machine is started
    When the cluster modification completes
    When a cluster modification begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then the cluster modification completes
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When the cluster modification completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to connect because the cluster is being modified then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to connect because the cluster is being modified
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then a Step Functions state machine is created then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given eid in exec_status
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When a Step Functions state machine is created
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then an ElastiCache cluster is created and becomes "AVAILABLE" then a cluster modification begins
    Given eid in exec_status
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    When a cluster modification begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then a cluster modification begins then the cluster modification completes
    Given eid in exec_status
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When a cluster modification begins
    When the cluster modification completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then the cluster modification completes then an execution of the state machine is started
    Given eid in exec_status
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When the cluster modification completes
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then an execution of the state machine is started then a running execution fails to connect because the cluster is being modified
    Given eid in exec_status
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When an execution of the state machine is started
    When a running execution fails to connect because the cluster is being modified
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then a running execution fails to connect because the cluster is being modified then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When a running execution fails to connect because the cluster is being modified
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then a Step Functions state machine is created then a cluster modification begins
    Given eid in exec_status
    When a running execution fails to connect because the cluster is being modified
    When a Step Functions state machine is created
    When a cluster modification begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then an ElastiCache cluster is created and becomes "AVAILABLE" then the cluster modification completes
    Given eid in exec_status
    When a running execution fails to connect because the cluster is being modified
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    When the cluster modification completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then a cluster modification begins then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to connect because the cluster is being modified
    When a cluster modification begins
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then the cluster modification completes then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given eid in exec_status
    When a running execution fails to connect because the cluster is being modified
    When the cluster modification completes
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to connect because the cluster is being modified
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @exhaustive @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given eid in exec_status
    When a running execution fails to connect because the cluster is being modified
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read
