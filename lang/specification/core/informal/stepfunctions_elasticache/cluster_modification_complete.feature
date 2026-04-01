@stepfunctionselasticache @generated
Feature: StepfunctionsElasticache - The "Elasticache" "Cluster" Modification Completes

  # Generated from FizzBee spec: stepfunctions_elasticache.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadACluster

  Background:
    Given the system is initialized

  @minimal @happy @cluster_modification_complete @internal
  Scenario: the "elasticache" "cluster" modification completes
    Given the "elasticache" "cluster" was "MODIFYING"
    When the "elasticache" "cluster" modification completes
    Then the "elasticache" "cluster" will be "AVAILABLE" again
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @guard @negative @cluster_modification_complete @internal
  Scenario: the "elasticache" "cluster" modification completes fails when the "elasticache" "cluster" was not "MODIFYING"
    Given the "elasticache" "cluster" was not "MODIFYING"
    When the "elasticache" "cluster" modification completes
    Then the operation is rejected
