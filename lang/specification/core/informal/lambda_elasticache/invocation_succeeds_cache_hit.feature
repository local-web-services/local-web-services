@lambdaelasticache @generated
Feature: LambdaElasticache - The "Lambda" "Function" Invocation Reads An Existing Cache Entry And Completes Successfully

  # Generated from FizzBee spec: lambda_elasticache.fizz
  # Safety invariants: InvocationRequiresActiveFunction, CachedEntryRequiresAvailableCluster

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds_cache_hit @internal
  Scenario: the "lambda" "function" invocation reads an existing cache entry and completes successfully
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And a "CACHED" "elasticache" "entry" existed in the "elasticache" "cluster"
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    Then the "lambda" "invocation" will be "SUCCESS"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @guard @negative @invocation_succeeds_cache_hit @internal
  Scenario: the "lambda" "function" invocation reads an existing cache entry and completes successfully fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    Then the operation is rejected

  @guard @negative @invocation_succeeds_cache_hit @internal
  Scenario: the "lambda" "function" invocation reads an existing cache entry and completes successfully fails when no "CACHED" "elasticache" "entry" existed in the "elasticache" "cluster"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And no "CACHED" "elasticache" "entry" existed in the "elasticache" "cluster"
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    Then the operation is rejected
