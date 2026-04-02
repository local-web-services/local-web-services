@stepfunctionselasticache @generated
Feature: StepfunctionsElasticache - A Running "Step Functions" "Execution" Fails To Connect Because The Cluster Is Being Modified

  # Generated from FizzBee spec: stepfunctions_elasticache.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadACluster

  Background:
    Given the system is initialized

  @minimal @happy @read_cache_task_fails @internal
  Scenario: a running "step functions" "execution" fails to connect because the cluster is being modified
    Given a "step functions" "execution" was "RUNNING"
    And the "elasticache" "cluster" was "MODIFYING"
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    Then the "step functions" "execution" will be "FAILED" with a connection error
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @guard @negative @read_cache_task_fails @internal
  Scenario: a running "step functions" "execution" fails to connect because the cluster is being modified fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    Then the operation is rejected

  @guard @negative @read_cache_task_fails @internal
  Scenario: a running "step functions" "execution" fails to connect because the cluster is being modified fails when the "elasticache" "cluster" was not "MODIFYING"
    Given a "step functions" "execution" was "RUNNING"
    And the "elasticache" "cluster" was not "MODIFYING"
    When a running "step functions" "execution" fails to connect because the cluster is being modified
    Then the operation is rejected
