@lambdaelasticache @generated
Feature: LambdaElasticache - The Lambda Invocation Reads An Existing Cache Entry And Completes Successfully

  # Generated from FizzBee spec: lambda_elasticache.fizz
  # Safety invariants: InvocationRequiresActiveFunction, CachedEntryRequiresAvailableCluster

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds_cache_hit @internal
  Scenario: the Lambda invocation reads an existing cache entry and completes successfully
    Given an invocation is "IN_PROGRESS"
    And a "CACHED" entry exists in the cluster
    When the Lambda invocation reads an existing cache entry and completes successfully
    Then the invocation is "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @guard @negative @invocation_succeeds_cache_hit @internal
  Scenario: the Lambda invocation reads an existing cache entry and completes successfully fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda invocation reads an existing cache entry and completes successfully
    Then the operation is rejected

  @guard @negative @invocation_succeeds_cache_hit @internal
  Scenario: the Lambda invocation reads an existing cache entry and completes successfully fails when no "CACHED" entry exists in the cluster
    Given an invocation is "IN_PROGRESS"
    And no "CACHED" entry exists in the cluster
    When the Lambda invocation reads an existing cache entry and completes successfully
    Then the operation is rejected
