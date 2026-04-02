@stepfunctionselasticache @generated
Feature: StepfunctionsElasticache - A Running "Step Functions" "Execution" Reads From The Available Elasticache Cluster And Succeeds

  # Generated from FizzBee spec: stepfunctions_elasticache.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadACluster

  Background:
    Given the system is initialized

  @minimal @happy @read_cache_task_succeeds @internal
  Scenario: a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Given a "step functions" "execution" was "RUNNING"
    And the "elasticache" "cluster" was "AVAILABLE"
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Then the "step functions" "execution" will be "SUCCEEDED"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "elasticache" "cluster" it read

  @guard @negative @read_cache_task_succeeds @internal
  Scenario: a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Then the operation is rejected

  @guard @negative @read_cache_task_succeeds @internal
  Scenario: a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds fails when the "elasticache" "cluster" was not "AVAILABLE"
    Given a "step functions" "execution" was "RUNNING"
    And the "elasticache" "cluster" was not "AVAILABLE"
    When a running "step functions" "execution" reads from the "AVAILABLE" ElastiCache cluster and succeeds
    Then the operation is rejected
