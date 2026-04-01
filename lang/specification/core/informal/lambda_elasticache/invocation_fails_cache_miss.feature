@lambdaelasticache @generated
Feature: LambdaElasticache - The Lambda Invocation Fails Because All Cache Entries Have Been Evicted

  # Generated from FizzBee spec: lambda_elasticache.fizz
  # Safety invariants: InvocationRequiresActiveFunction, CachedEntryRequiresAvailableCluster

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_cache_miss @internal
  Scenario: the Lambda invocation fails because all cache entries have been evicted
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And no "CACHED" entries exist in the cluster
    When the Lambda invocation fails because all cache entries have been evicted
    Then the invocation will be "FAILED"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @guard @negative @invocation_fails_cache_miss @internal
  Scenario: the Lambda invocation fails because all cache entries have been evicted fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the Lambda invocation fails because all cache entries have been evicted
    Then the operation is rejected

  @guard @negative @invocation_fails_cache_miss @internal
  Scenario: the Lambda invocation fails because all cache entries have been evicted fails when a "CACHED" entry existed in the cluster
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And a "CACHED" entry existed in the cluster
    When the Lambda invocation fails because all cache entries have been evicted
    Then the operation is rejected
