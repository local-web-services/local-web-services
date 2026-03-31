@stepfunctionselasticache @generated
Feature: StepfunctionsElasticache - An "Elasticache" "Cluster" Is Created And Becomes Available

  # Generated from FizzBee spec: stepfunctions_elasticache.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadACluster

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: an "elasticache" "cluster" is created and becomes "AVAILABLE"
    Given the cluster did not already exist
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    Then the "elasticache" "cluster" will be "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @guard @negative @create_cluster
  Scenario: an "elasticache" "cluster" is created and becomes "AVAILABLE" fails when the cluster already existed
    Given the cluster already existed
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    Then the operation is rejected
