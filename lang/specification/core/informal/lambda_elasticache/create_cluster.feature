@lambdaelasticache @generated
Feature: LambdaElasticache - An Elasticache Cluster Is Created

  # Generated from FizzBee spec: lambda_elasticache.fizz
  # Safety invariants: InvocationRequiresActiveFunction, CachedEntryRequiresAvailableCluster

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: an ElastiCache cluster is created
    Given the cluster does not already exist
    When an ElastiCache cluster is created
    Then the cluster is "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @standard @negative @create_cluster
  Scenario: an ElastiCache cluster is created fails when the cluster already exists
    Given the cluster already exists
    When an ElastiCache cluster is created
    Then the operation is rejected
