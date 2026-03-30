@stepfunctionselasticache @generated
Feature: StepfunctionsElasticache - An Elasticache Cluster Is Created And Becomes Available

  # Generated from FizzBee spec: stepfunctions_elasticache.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadACluster

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE"
    Given the cluster does not already exist
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    Then the cluster is "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @guard @negative @create_cluster
  Scenario: an ElastiCache cluster is created and becomes "AVAILABLE" fails when the cluster already exists
    Given the cluster already exists
    When an ElastiCache cluster is created and becomes "AVAILABLE"
    Then the operation is rejected
