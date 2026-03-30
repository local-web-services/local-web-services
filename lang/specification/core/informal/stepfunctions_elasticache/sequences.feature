@stepfunctionselasticache @generated
Feature: StepfunctionsElasticache - Action Sequences

  # Generated from FizzBee spec: stepfunctions_elasticache.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadACluster

  Background:
    Given the system is initialized

  @sequence
  Scenario: a Step Functions state machine is created then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a Step Functions state machine is created then a cluster modification begins
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a cluster modification begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a Step Functions state machine is created then the cluster modification completes
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When the cluster modification completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a Step Functions state machine is created then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to connect because the cluster is being modified
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution fails to connect because the cluster is being modified
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then a Step Functions state machine is created
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created and is "AVAILABLE"
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then a cluster modification begins
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created and is "AVAILABLE"
    When a cluster modification begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then the cluster modification completes
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created and is "AVAILABLE"
    When the cluster modification completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then an execution of the state machine is started
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created and is "AVAILABLE"
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created and is "AVAILABLE"
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then a running execution fails to connect because the cluster is being modified
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created and is "AVAILABLE"
    When a running execution fails to connect because the cluster is being modified
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a cluster modification begins then a Step Functions state machine is created
    Given cid in cluster_status
    Given a cluster modification has begun
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a cluster modification begins then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    Given a cluster modification has begun
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a cluster modification begins then the cluster modification completes
    Given cid in cluster_status
    Given a cluster modification has begun
    When the cluster modification completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a cluster modification begins then an execution of the state machine is started
    Given cid in cluster_status
    Given a cluster modification has begun
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a cluster modification begins then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given cid in cluster_status
    Given a cluster modification has begun
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a cluster modification begins then a running execution fails to connect because the cluster is being modified
    Given cid in cluster_status
    Given a cluster modification has begun
    When a running execution fails to connect because the cluster is being modified
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: the cluster modification completes then a Step Functions state machine is created
    Given cid in cluster_status
    Given the cluster modification has completed
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: the cluster modification completes then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    Given the cluster modification has completed
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: the cluster modification completes then a cluster modification begins
    Given cid in cluster_status
    Given the cluster modification has completed
    When a cluster modification begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: the cluster modification completes then an execution of the state machine is started
    Given cid in cluster_status
    Given the cluster modification has completed
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: the cluster modification completes then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given cid in cluster_status
    Given the cluster modification has completed
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: the cluster modification completes then a running execution fails to connect because the cluster is being modified
    Given cid in cluster_status
    Given the cluster modification has completed
    When a running execution fails to connect because the cluster is being modified
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an execution of the state machine is started then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given smid in sm_status
    Given an execution of the state machine has been started
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an execution of the state machine is started then a cluster modification begins
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a cluster modification begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an execution of the state machine is started then the cluster modification completes
    Given smid in sm_status
    Given an execution of the state machine has been started
    When the cluster modification completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an execution of the state machine is started then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an execution of the state machine is started then a running execution fails to connect because the cluster is being modified
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution fails to connect because the cluster is being modified
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" cluster and the task succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" cluster and the task succeeded
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then a cluster modification begins
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" cluster and the task succeeded
    When a cluster modification begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then the cluster modification completes
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" cluster and the task succeeded
    When the cluster modification completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" cluster and the task succeeded
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then a running execution fails to connect because the cluster is being modified
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" cluster and the task succeeded
    When a running execution fails to connect because the cluster is being modified
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has failed to connect because the cluster is being modified
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given eid in exec_status
    Given a running execution has failed to connect because the cluster is being modified
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then a cluster modification begins
    Given eid in exec_status
    Given a running execution has failed to connect because the cluster is being modified
    When a cluster modification begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then the cluster modification completes
    Given eid in exec_status
    Given a running execution has failed to connect because the cluster is being modified
    When the cluster modification completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has failed to connect because the cluster is being modified
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given eid in exec_status
    Given a running execution has failed to connect because the cluster is being modified
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a Step Functions state machine is created then an ElastiCache cluster is created and becomes "AVAILABLE" then a cluster modification begins
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an ElastiCache cluster has been created and is "AVAILABLE"
    When a cluster modification begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a Step Functions state machine is created then a cluster modification begins then the cluster modification completes
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a cluster modification has begun
    When the cluster modification completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a Step Functions state machine is created then the cluster modification completes then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given the cluster modification has completed
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an execution of the state machine has been started
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a Step Functions state machine is created then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then a running execution fails to connect because the cluster is being modified
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has connected to the "AVAILABLE" cluster and the task succeeded
    When a running execution fails to connect because the cluster is being modified
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to connect because the cluster is being modified then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has failed to connect because the cluster is being modified
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then a Step Functions state machine is created then the cluster modification completes
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created and is "AVAILABLE"
    Given a Step Functions state machine has been created
    When the cluster modification completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then a cluster modification begins then an execution of the state machine is started
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created and is "AVAILABLE"
    Given a cluster modification has begun
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then the cluster modification completes then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created and is "AVAILABLE"
    Given the cluster modification has completed
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then an execution of the state machine is started then a running execution fails to connect because the cluster is being modified
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created and is "AVAILABLE"
    Given an execution of the state machine has been started
    When a running execution fails to connect because the cluster is being modified
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then a Step Functions state machine is created
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created and is "AVAILABLE"
    Given a running execution has connected to the "AVAILABLE" cluster and the task succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" then a running execution fails to connect because the cluster is being modified then a cluster modification begins
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created and is "AVAILABLE"
    Given a running execution has failed to connect because the cluster is being modified
    When a cluster modification begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a cluster modification begins then a Step Functions state machine is created then an execution of the state machine is started
    Given cid in cluster_status
    Given a cluster modification has begun
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a cluster modification begins then an ElastiCache cluster is created and becomes "AVAILABLE" then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given cid in cluster_status
    Given a cluster modification has begun
    Given an ElastiCache cluster has been created and is "AVAILABLE"
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a cluster modification begins then the cluster modification completes then a running execution fails to connect because the cluster is being modified
    Given cid in cluster_status
    Given a cluster modification has begun
    Given the cluster modification has completed
    When a running execution fails to connect because the cluster is being modified
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a cluster modification begins then an execution of the state machine is started then a Step Functions state machine is created
    Given cid in cluster_status
    Given a cluster modification has begun
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a cluster modification begins then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    Given a cluster modification has begun
    Given a running execution has connected to the "AVAILABLE" cluster and the task succeeded
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a cluster modification begins then a running execution fails to connect because the cluster is being modified then the cluster modification completes
    Given cid in cluster_status
    Given a cluster modification has begun
    Given a running execution has failed to connect because the cluster is being modified
    When the cluster modification completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: the cluster modification completes then a Step Functions state machine is created then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given cid in cluster_status
    Given the cluster modification has completed
    Given a Step Functions state machine has been created
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: the cluster modification completes then an ElastiCache cluster is created and becomes "AVAILABLE" then a running execution fails to connect because the cluster is being modified
    Given cid in cluster_status
    Given the cluster modification has completed
    Given an ElastiCache cluster has been created and is "AVAILABLE"
    When a running execution fails to connect because the cluster is being modified
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: the cluster modification completes then a cluster modification begins then a Step Functions state machine is created
    Given cid in cluster_status
    Given the cluster modification has completed
    Given a cluster modification has begun
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: the cluster modification completes then an execution of the state machine is started then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given cid in cluster_status
    Given the cluster modification has completed
    Given an execution of the state machine has been started
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: the cluster modification completes then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then a cluster modification begins
    Given cid in cluster_status
    Given the cluster modification has completed
    Given a running execution has connected to the "AVAILABLE" cluster and the task succeeded
    When a cluster modification begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: the cluster modification completes then a running execution fails to connect because the cluster is being modified then an execution of the state machine is started
    Given cid in cluster_status
    Given the cluster modification has completed
    Given a running execution has failed to connect because the cluster is being modified
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution fails to connect because the cluster is being modified
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a Step Functions state machine has been created
    When a running execution fails to connect because the cluster is being modified
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an execution of the state machine is started then an ElastiCache cluster is created and becomes "AVAILABLE" then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given an ElastiCache cluster has been created and is "AVAILABLE"
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an execution of the state machine is started then a cluster modification begins then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a cluster modification has begun
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an execution of the state machine is started then the cluster modification completes then a cluster modification begins
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given the cluster modification has completed
    When a cluster modification begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an execution of the state machine is started then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then the cluster modification completes
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has connected to the "AVAILABLE" cluster and the task succeeded
    When the cluster modification completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: an execution of the state machine is started then a running execution fails to connect because the cluster is being modified then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has failed to connect because the cluster is being modified
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then a Step Functions state machine is created then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" cluster and the task succeeded
    Given a Step Functions state machine has been created
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then an ElastiCache cluster is created and becomes "AVAILABLE" then a cluster modification begins
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" cluster and the task succeeded
    Given an ElastiCache cluster has been created and is "AVAILABLE"
    When a cluster modification begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then a cluster modification begins then the cluster modification completes
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" cluster and the task succeeded
    Given a cluster modification has begun
    When the cluster modification completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then the cluster modification completes then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" cluster and the task succeeded
    Given the cluster modification has completed
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then an execution of the state machine is started then a running execution fails to connect because the cluster is being modified
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" cluster and the task succeeded
    Given an execution of the state machine has been started
    When a running execution fails to connect because the cluster is being modified
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then a running execution fails to connect because the cluster is being modified then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has connected to the "AVAILABLE" cluster and the task succeeded
    Given a running execution has failed to connect because the cluster is being modified
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then a Step Functions state machine is created then a cluster modification begins
    Given eid in exec_status
    Given a running execution has failed to connect because the cluster is being modified
    Given a Step Functions state machine has been created
    When a cluster modification begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then an ElastiCache cluster is created and becomes "AVAILABLE" then the cluster modification completes
    Given eid in exec_status
    Given a running execution has failed to connect because the cluster is being modified
    Given an ElastiCache cluster has been created and is "AVAILABLE"
    When the cluster modification completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then a cluster modification begins then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has failed to connect because the cluster is being modified
    Given a cluster modification has begun
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then the cluster modification completes then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given eid in exec_status
    Given a running execution has failed to connect because the cluster is being modified
    Given the cluster modification has completed
    When a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has failed to connect because the cluster is being modified
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @sequence
  Scenario: a running execution fails to connect because the cluster is being modified then a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds then an ElastiCache cluster is created and becomes "AVAILABLE"
    Given eid in exec_status
    Given a running execution has failed to connect because the cluster is being modified
    Given a running execution has connected to the "AVAILABLE" cluster and the task succeeded
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read
