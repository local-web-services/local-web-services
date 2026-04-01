@lambdaelasticache @generated
Feature: LambdaElasticache - The "Lambda" "Function" Invocation Fails Because All Cache Entries Have Been Evicted

  # Generated from FizzBee spec: lambda_elasticache.fizz
  # Safety invariants: InvocationRequiresActiveFunction, CachedEntryRequiresAvailableCluster

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_cache_miss @internal
  Scenario: the "lambda" "function" invocation fails because all cache entries have been evicted
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And no "CACHED" "elasticache" "entries" existed in the "elasticache" "cluster"
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    Then the "lambda" "invocation" will be "FAILED"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @guard @negative @invocation_fails_cache_miss @internal
  Scenario: the "lambda" "function" invocation fails because all cache entries have been evicted fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    Then the operation is rejected

  @guard @negative @invocation_fails_cache_miss @internal
  Scenario: the "lambda" "function" invocation fails because all cache entries have been evicted fails when a "CACHED" "elasticache" "entry" existed in the "elasticache" "cluster"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And a "CACHED" "elasticache" "entry" existed in the "elasticache" "cluster"
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    Then the operation is rejected
