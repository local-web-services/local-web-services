@stepfunctionselasticache @generated
Feature: StepfunctionsElasticache - The Cluster Modification Completes

  # Generated from FizzBee spec: stepfunctions_elasticache.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadACluster

  Background:
    Given the system is initialized

  @minimal @happy @cluster_modification_complete @internal
  Scenario: the cluster modification completes
    Given the "elasticache" "cluster" was "MODIFYING"
    When the cluster modification completes
    Then the "elasticache" "cluster" will be "AVAILABLE" again
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @guard @negative @cluster_modification_complete @internal
  Scenario: the cluster modification completes fails when the "elasticache" "cluster" was not "MODIFYING"
    Given the "elasticache" "cluster" was not "MODIFYING"
    When the cluster modification completes
    Then the operation is rejected
