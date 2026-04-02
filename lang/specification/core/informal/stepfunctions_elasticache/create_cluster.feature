@stepfunctionselasticache @generated
Feature: StepfunctionsElasticache - An "Elasticache" "Cluster" Is Created And Becomes Available

  # Generated from FizzBee spec: stepfunctions_elasticache.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadACluster

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: an "elasticache" "cluster" is created and becomes "AVAILABLE"
    Given the "elasticache" "cluster" did not already exist
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    Then the "elasticache" "cluster" will be "AVAILABLE"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @guard @negative @create_cluster
  Scenario: an "elasticache" "cluster" is created and becomes "AVAILABLE" fails when the "elasticache" "cluster" already existed
    Given the "elasticache" "cluster" already existed
    When an "elasticache" "cluster" is created and becomes "AVAILABLE"
    Then the operation is rejected
