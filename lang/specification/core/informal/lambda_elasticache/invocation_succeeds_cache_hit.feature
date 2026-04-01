@lambdaelasticache @generated
Feature: LambdaElasticache - The Lambda Invocation Reads An Existing Cache Entry And Completes Successfully

  # Generated from FizzBee spec: lambda_elasticache.fizz
  # Safety invariants: InvocationRequiresActiveFunction, CachedEntryRequiresAvailableCluster

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds_cache_hit @internal
  Scenario: the Lambda invocation reads an existing cache entry and completes successfully
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And a "CACHED" entry existed in the cluster
    When the Lambda invocation reads an existing cache entry and completes successfully
    Then the invocation will be "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @guard @negative @invocation_succeeds_cache_hit @internal
  Scenario: the Lambda invocation reads an existing cache entry and completes successfully fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the Lambda invocation reads an existing cache entry and completes successfully
    Then the operation is rejected

  @guard @negative @invocation_succeeds_cache_hit @internal
  Scenario: the Lambda invocation reads an existing cache entry and completes successfully fails when no "CACHED" entry existed in the cluster
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And no "CACHED" entry existed in the cluster
    When the Lambda invocation reads an existing cache entry and completes successfully
    Then the operation is rejected
