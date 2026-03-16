@stepfunctionselasticache @generated
Feature: StepfunctionsElasticache - The Cluster Modification Completes

  # Generated from FizzBee spec: stepfunctions_elasticache.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadACluster

  Background:
    Given the system is initialized

  @minimal @happy @cluster_modification_complete @internal
  Scenario: the cluster modification completes
    Given the cluster is "MODIFYING"
    When the cluster modification completes
    Then the cluster is "AVAILABLE" again
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which cluster it read

  @standard @negative @cluster_modification_complete @internal
  Scenario: the cluster modification completes fails when the cluster is not "MODIFYING"
    Given the cluster is not "MODIFYING"
    When the cluster modification completes
    Then the operation is rejected
