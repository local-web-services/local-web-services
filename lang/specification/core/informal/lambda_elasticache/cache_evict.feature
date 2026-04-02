@lambdaelasticache @generated
Feature: LambdaElasticache - The "Elasticache" "Cluster" Evicts A "Cache" "Entry" Due To Memory Pressure Or Ttl Expiry

  # Generated from FizzBee spec: lambda_elasticache.fizz
  # Safety invariants: InvocationRequiresActiveFunction, CachedEntryRequiresAvailableCluster

  Background:
    Given the system is initialized

  @minimal @happy @cache_evict @internal
  Scenario: the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    Given a "CACHED" "elasticache" "entry" existed
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    Then the "elasticache" "cache entry" will be "EVICTED"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @guard @negative @cache_evict @internal
  Scenario: the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry fails when no "CACHED" "elasticache" "entry" existed
    Given no "CACHED" "elasticache" "entry" existed
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    Then the operation is rejected
