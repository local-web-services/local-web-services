@lambdaelasticache @generated
Feature: LambdaElasticache - Elasticache Evicts A Cache Entry Due To Memory Pressure Or Ttl Expiry

  # Generated from FizzBee spec: lambda_elasticache.fizz
  # Safety invariants: InvocationRequiresActiveFunction, CachedEntryRequiresAvailableCluster

  Background:
    Given the system is initialized

  @minimal @happy @cache_evict @internal
  Scenario: ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Given a "CACHED" entry exists
    When ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Then the cache entry is "EVICTED"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @standard @negative @cache_evict @internal
  Scenario: ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry fails when no "CACHED" entry exists
    Given no "CACHED" entry exists
    When ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Then the operation is rejected
