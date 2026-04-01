@lambdaelasticache @generated
Feature: LambdaElasticache - An "Elasticache" "Cluster" Is Created

  # Generated from FizzBee spec: lambda_elasticache.fizz
  # Safety invariants: InvocationRequiresActiveFunction, CachedEntryRequiresAvailableCluster

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: an "elasticache" "cluster" is created
    Given the "elasticache" "cluster" did not already exist
    When an "elasticache" "cluster" is created
    Then the "elasticache" "cluster" will be "AVAILABLE"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @guard @negative @create_cluster
  Scenario: an "elasticache" "cluster" is created fails when the "elasticache" "cluster" already existed
    Given the "elasticache" "cluster" already existed
    When an "elasticache" "cluster" is created
    Then the operation is rejected
