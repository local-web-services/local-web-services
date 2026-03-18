@lambdaelasticache @generated
Feature: LambdaElasticache - The Lambda Function Writes A Value To The Elasticache Cluster During Invocation

  # Generated from FizzBee spec: lambda_elasticache.fizz
  # Safety invariants: InvocationRequiresActiveFunction, CachedEntryRequiresAvailableCluster

  Background:
    Given the system is initialized

  @minimal @happy @cache_write
  Scenario: the Lambda function writes a value to the ElastiCache cluster during invocation
    Given an invocation is "IN_PROGRESS"
    And the cluster exists
    And the cluster is "AVAILABLE"
    And a key slot is available
    When the Lambda function writes a value to the ElastiCache cluster during invocation
    Then the cache entry is "CACHED" in the cluster
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @standard @negative @cache_write @lifecycle
  Scenario: the Lambda function writes a value to the ElastiCache cluster during invocation fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function writes a value to the ElastiCache cluster during invocation
    Then the operation is rejected

  @standard @negative @cache_write
  Scenario: the Lambda function writes a value to the ElastiCache cluster during invocation fails when the cluster does not exist
    Given an invocation is "IN_PROGRESS"
    And the cluster does not exist
    When the Lambda function writes a value to the ElastiCache cluster during invocation
    Then the operation is rejected

  @standard @negative @cache_write @lifecycle
  Scenario: the Lambda function writes a value to the ElastiCache cluster during invocation fails when the cluster is not "AVAILABLE"
    Given an invocation is "IN_PROGRESS"
    And the cluster exists
    And the cluster is not "AVAILABLE"
    When the Lambda function writes a value to the ElastiCache cluster during invocation
    Then the operation is rejected

  @standard @negative @cache_write @capacity
  Scenario: the Lambda function writes a value to the ElastiCache cluster during invocation fails when no key slot is available
    Given an invocation is "IN_PROGRESS"
    And the cluster exists
    And the cluster is "AVAILABLE"
    And no key slot is available
    When the Lambda function writes a value to the ElastiCache cluster during invocation
    Then the operation is rejected
