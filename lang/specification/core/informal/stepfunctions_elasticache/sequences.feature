@stepfunctionselasticache @generated
Feature: StepfunctionsElasticache - Action Sequences

  # Generated from FizzBee spec: stepfunctions_elasticache.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadACluster

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "step functions" "state machine" is created then an "elasticache" "cluster" is created and becomes "AVAILABLE"
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a "step functions" "state machine" is created then an "elasticache" "cluster" modification begins
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "elasticache" "cluster" modification begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a "step functions" "state machine" is created then the "elasticache" "cluster" modification completes
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "elasticache" "cluster" modification completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails to connect because the cluster is being modified
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" is created and becomes "AVAILABLE" then a "step functions" "state machine" is created
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" is created and becomes "AVAILABLE" then an "elasticache" "cluster" modification begins
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    When an "elasticache" "cluster" modification begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" is created and becomes "AVAILABLE" then the "elasticache" "cluster" modification completes
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    When the "elasticache" "cluster" modification completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" is created and becomes "AVAILABLE" then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" is created and becomes "AVAILABLE" then a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" is created and becomes "AVAILABLE" then a running "step functions" "execution" fails to connect because the cluster is being modified
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" modification begins then a "step functions" "state machine" is created
    Given cid in cluster_status
    When an "elasticache" "cluster" modification begins
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" modification begins then an "elasticache" "cluster" is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When an "elasticache" "cluster" modification begins
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" modification begins then the "elasticache" "cluster" modification completes
    Given cid in cluster_status
    When an "elasticache" "cluster" modification begins
    When the "elasticache" "cluster" modification completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" modification begins then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid in cluster_status
    When an "elasticache" "cluster" modification begins
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" modification begins then a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given cid in cluster_status
    When an "elasticache" "cluster" modification begins
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" modification begins then a running "step functions" "execution" fails to connect because the cluster is being modified
    Given cid in cluster_status
    When an "elasticache" "cluster" modification begins
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then a "step functions" "state machine" is created
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then an "elasticache" "cluster" is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then an "elasticache" "cluster" modification begins
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When an "elasticache" "cluster" modification begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then a running "step functions" "execution" fails to connect because the cluster is being modified
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then an "elasticache" "cluster" is created and becomes "AVAILABLE"
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then an "elasticache" "cluster" modification begins
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When an "elasticache" "cluster" modification begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the "elasticache" "cluster" modification completes
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "elasticache" "cluster" modification completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to connect because the cluster is being modified
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds then an "elasticache" "cluster" is created and becomes "AVAILABLE"
    Given eid in exec_status
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds then an "elasticache" "cluster" modification begins
    Given eid in exec_status
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When an "elasticache" "cluster" modification begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds then the "elasticache" "cluster" modification completes
    Given eid in exec_status
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When the "elasticache" "cluster" modification completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds then a running "step functions" "execution" fails to connect because the cluster is being modified
    Given eid in exec_status
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the cluster is being modified then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the cluster is being modified then an "elasticache" "cluster" is created and becomes "AVAILABLE"
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the cluster is being modified then an "elasticache" "cluster" modification begins
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    When an "elasticache" "cluster" modification begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the cluster is being modified then the "elasticache" "cluster" modification completes
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    When the "elasticache" "cluster" modification completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the cluster is being modified then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the cluster is being modified then a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a "step functions" "state machine" is created then an "elasticache" "cluster" is created and becomes "AVAILABLE" then an "elasticache" "cluster" modification begins
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    When an "elasticache" "cluster" modification begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a "step functions" "state machine" is created then an "elasticache" "cluster" modification begins then the "elasticache" "cluster" modification completes
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "elasticache" "cluster" modification begins
    When the "elasticache" "cluster" modification completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a "step functions" "state machine" is created then the "elasticache" "cluster" modification completes then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "elasticache" "cluster" modification completes
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds then a running "step functions" "execution" fails to connect because the cluster is being modified
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails to connect because the cluster is being modified then an "elasticache" "cluster" is created and becomes "AVAILABLE"
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" is created and becomes "AVAILABLE" then a "step functions" "state machine" is created then the "elasticache" "cluster" modification completes
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    When a "step functions" "state machine" is created
    When the "elasticache" "cluster" modification completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" is created and becomes "AVAILABLE" then an "elasticache" "cluster" modification begins then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    When an "elasticache" "cluster" modification begins
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" is created and becomes "AVAILABLE" then the "elasticache" "cluster" modification completes then a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    When the "elasticache" "cluster" modification completes
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" is created and becomes "AVAILABLE" then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to connect because the cluster is being modified
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" is created and becomes "AVAILABLE" then a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds then a "step functions" "state machine" is created
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" is created and becomes "AVAILABLE" then a running "step functions" "execution" fails to connect because the cluster is being modified then an "elasticache" "cluster" modification begins
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    When an "elasticache" "cluster" modification begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" modification begins then a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid in cluster_status
    When an "elasticache" "cluster" modification begins
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" modification begins then an "elasticache" "cluster" is created and becomes "AVAILABLE" then a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given cid in cluster_status
    When an "elasticache" "cluster" modification begins
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" modification begins then the "elasticache" "cluster" modification completes then a running "step functions" "execution" fails to connect because the cluster is being modified
    Given cid in cluster_status
    When an "elasticache" "cluster" modification begins
    When the "elasticache" "cluster" modification completes
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" modification begins then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given cid in cluster_status
    When an "elasticache" "cluster" modification begins
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" modification begins then a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds then an "elasticache" "cluster" is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When an "elasticache" "cluster" modification begins
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "elasticache" "cluster" modification begins then a running "step functions" "execution" fails to connect because the cluster is being modified then the "elasticache" "cluster" modification completes
    Given cid in cluster_status
    When an "elasticache" "cluster" modification begins
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    When the "elasticache" "cluster" modification completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then a "step functions" "state machine" is created then a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then an "elasticache" "cluster" is created and becomes "AVAILABLE" then a running "step functions" "execution" fails to connect because the cluster is being modified
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then an "elasticache" "cluster" modification begins then a "step functions" "state machine" is created
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When an "elasticache" "cluster" modification begins
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then an "step functions" "execution" of the "step functions" "state machine" is started then an "elasticache" "cluster" is created and becomes "AVAILABLE"
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds then an "elasticache" "cluster" modification begins
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When an "elasticache" "cluster" modification begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then a running "step functions" "execution" fails to connect because the cluster is being modified then an "step functions" "execution" of the "step functions" "state machine" is started
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created then a running "step functions" "execution" fails to connect because the cluster is being modified
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then an "elasticache" "cluster" is created and becomes "AVAILABLE" then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then an "elasticache" "cluster" modification begins then an "elasticache" "cluster" is created and becomes "AVAILABLE"
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When an "elasticache" "cluster" modification begins
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the "elasticache" "cluster" modification completes then an "elasticache" "cluster" modification begins
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "elasticache" "cluster" modification completes
    When an "elasticache" "cluster" modification begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds then the "elasticache" "cluster" modification completes
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When the "elasticache" "cluster" modification completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to connect because the cluster is being modified then a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds then a "step functions" "state machine" is created then an "elasticache" "cluster" is created and becomes "AVAILABLE"
    Given eid in exec_status
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When a "step functions" "state machine" is created
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds then an "elasticache" "cluster" is created and becomes "AVAILABLE" then an "elasticache" "cluster" modification begins
    Given eid in exec_status
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    When an "elasticache" "cluster" modification begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds then an "elasticache" "cluster" modification begins then the "elasticache" "cluster" modification completes
    Given eid in exec_status
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When an "elasticache" "cluster" modification begins
    When the "elasticache" "cluster" modification completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds then the "elasticache" "cluster" modification completes then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When the "elasticache" "cluster" modification completes
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to connect because the cluster is being modified
    Given eid in exec_status
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds then a running "step functions" "execution" fails to connect because the cluster is being modified then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the cluster is being modified then a "step functions" "state machine" is created then an "elasticache" "cluster" modification begins
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    When a "step functions" "state machine" is created
    When an "elasticache" "cluster" modification begins
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the cluster is being modified then an "elasticache" "cluster" is created and becomes "AVAILABLE" then the "elasticache" "cluster" modification completes
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    When the "elasticache" "cluster" modification completes
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the cluster is being modified then an "elasticache" "cluster" modification begins then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    When an "elasticache" "cluster" modification begins
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the cluster is being modified then the "elasticache" "cluster" modification completes then a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    When the "elasticache" "cluster" modification completes
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the cluster is being modified then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @sequence
  Scenario: a running "step functions" "execution" fails to connect because the cluster is being modified then a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds then an "elasticache" "cluster" is created and becomes "AVAILABLE"
    Given eid in exec_status
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read
