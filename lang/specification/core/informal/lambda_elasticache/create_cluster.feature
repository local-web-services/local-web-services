@lambdaelasticache @generated
Feature: LambdaElasticache - An "Elasticache" "Cluster" Is Created

  # Generated from FizzBee spec: lambda_elasticache.fizz
  # Safety invariants: InvocationRequiresActiveFunction, CachedEntryRequiresAvailableCluster

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: an "elasticache" "cluster" is created
    Given the cluster did not already exist
    When an "elasticache" "cluster" is created
    Then the "elasticache" "cluster" will be "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @guard @negative @create_cluster
  Scenario: an "elasticache" "cluster" is created fails when the cluster already existed
    Given the cluster already existed
    When an "elasticache" "cluster" is created
    Then the operation is rejected
