@lambdaelasticache @generated
Feature: LambdaElasticache - Action Sequences

  # Generated from FizzBee spec: lambda_elasticache.fizz
  # Safety invariants: InvocationRequiresActiveFunction, CachedEntryRequiresAvailableCluster

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "lambda" "function" is deployed then an "elasticache" "cluster" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "elasticache" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation reads an existing cache entry and completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation fails because all cache entries have been evicted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: an "elasticache" "cluster" is created then a "lambda" "function" is deployed
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: an "elasticache" "cluster" is created then the "lambda" "function" is invoked
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: an "elasticache" "cluster" is created then the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: an "elasticache" "cluster" is created then the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: an "elasticache" "cluster" is created then the "lambda" "function" invocation reads an existing cache entry and completes successfully
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: an "elasticache" "cluster" is created then the "lambda" "function" invocation fails because all cache entries have been evicted
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" is invoked then an "elasticache" "cluster" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When an "elasticache" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" invocation reads an existing cache entry and completes successfully
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" invocation fails because all cache entries have been evicted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation then an "elasticache" "cluster" is created
    Given iid in inv_status
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    When an "elasticache" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation then the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    Given iid in inv_status
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation then the "lambda" "function" invocation reads an existing cache entry and completes successfully
    Given iid in inv_status
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation then the "lambda" "function" invocation fails because all cache entries have been evicted
    Given iid in inv_status
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry then a "lambda" "function" is deployed
    Given kid in key_status
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry then an "elasticache" "cluster" is created
    Given kid in key_status
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    When an "elasticache" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry then the "lambda" "function" is invoked
    Given kid in key_status
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry then the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Given kid in key_status
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry then the "lambda" "function" invocation reads an existing cache entry and completes successfully
    Given kid in key_status
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry then the "lambda" "function" invocation fails because all cache entries have been evicted
    Given kid in key_status
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation reads an existing cache entry and completes successfully then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation reads an existing cache entry and completes successfully then an "elasticache" "cluster" is created
    Given iid in inv_status
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    When an "elasticache" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation reads an existing cache entry and completes successfully then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation reads an existing cache entry and completes successfully then the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Given iid in inv_status
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation reads an existing cache entry and completes successfully then the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    Given iid in inv_status
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation reads an existing cache entry and completes successfully then the "lambda" "function" invocation fails because all cache entries have been evicted
    Given iid in inv_status
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation fails because all cache entries have been evicted then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation fails because all cache entries have been evicted then an "elasticache" "cluster" is created
    Given iid in inv_status
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    When an "elasticache" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation fails because all cache entries have been evicted then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation fails because all cache entries have been evicted then the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Given iid in inv_status
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation fails because all cache entries have been evicted then the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    Given iid in inv_status
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation fails because all cache entries have been evicted then the "lambda" "function" invocation reads an existing cache entry and completes successfully
    Given iid in inv_status
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: a "lambda" "function" is deployed then an "elasticache" "cluster" is created then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "elasticache" "cluster" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked then the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation then the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry then the "lambda" "function" invocation reads an existing cache entry and completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation reads an existing cache entry and completes successfully then the "lambda" "function" invocation fails because all cache entries have been evicted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation fails because all cache entries have been evicted then an "elasticache" "cluster" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    When an "elasticache" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: an "elasticache" "cluster" is created then a "lambda" "function" is deployed then the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When a "lambda" "function" is deployed
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: an "elasticache" "cluster" is created then the "lambda" "function" is invoked then the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When the "lambda" "function" is invoked
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: an "elasticache" "cluster" is created then the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation then the "lambda" "function" invocation reads an existing cache entry and completes successfully
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: an "elasticache" "cluster" is created then the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry then the "lambda" "function" invocation fails because all cache entries have been evicted
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: an "elasticache" "cluster" is created then the "lambda" "function" invocation reads an existing cache entry and completes successfully then a "lambda" "function" is deployed
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: an "elasticache" "cluster" is created then the "lambda" "function" invocation fails because all cache entries have been evicted then the "lambda" "function" is invoked
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed then the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" is invoked then an "elasticache" "cluster" is created then the "lambda" "function" invocation reads an existing cache entry and completes successfully
    Given fid in func_status
    When the "lambda" "function" is invoked
    When an "elasticache" "cluster" is created
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation then the "lambda" "function" invocation fails because all cache entries have been evicted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" invocation reads an existing cache entry and completes successfully then an "elasticache" "cluster" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    When an "elasticache" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" invocation fails because all cache entries have been evicted then the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation then a "lambda" "function" is deployed then the "lambda" "function" invocation reads an existing cache entry and completes successfully
    Given iid in inv_status
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation then an "elasticache" "cluster" is created then the "lambda" "function" invocation fails because all cache entries have been evicted
    Given iid in inv_status
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    When an "elasticache" "cluster" is created
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation then the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry then an "elasticache" "cluster" is created
    Given iid in inv_status
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    When an "elasticache" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation then the "lambda" "function" invocation reads an existing cache entry and completes successfully then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation then the "lambda" "function" invocation fails because all cache entries have been evicted then the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    Given iid in inv_status
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry then a "lambda" "function" is deployed then the "lambda" "function" invocation fails because all cache entries have been evicted
    Given kid in key_status
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry then an "elasticache" "cluster" is created then a "lambda" "function" is deployed
    Given kid in key_status
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    When an "elasticache" "cluster" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry then the "lambda" "function" is invoked then an "elasticache" "cluster" is created
    Given kid in key_status
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    When the "lambda" "function" is invoked
    When an "elasticache" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry then the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation then the "lambda" "function" is invoked
    Given kid in key_status
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry then the "lambda" "function" invocation reads an existing cache entry and completes successfully then the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Given kid in key_status
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry then the "lambda" "function" invocation fails because all cache entries have been evicted then the "lambda" "function" invocation reads an existing cache entry and completes successfully
    Given kid in key_status
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation reads an existing cache entry and completes successfully then a "lambda" "function" is deployed then an "elasticache" "cluster" is created
    Given iid in inv_status
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    When a "lambda" "function" is deployed
    When an "elasticache" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation reads an existing cache entry and completes successfully then an "elasticache" "cluster" is created then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    When an "elasticache" "cluster" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation reads an existing cache entry and completes successfully then the "lambda" "function" is invoked then the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Given iid in inv_status
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation reads an existing cache entry and completes successfully then the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation then the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    Given iid in inv_status
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation reads an existing cache entry and completes successfully then the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry then the "lambda" "function" invocation fails because all cache entries have been evicted
    Given iid in inv_status
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation reads an existing cache entry and completes successfully then the "lambda" "function" invocation fails because all cache entries have been evicted then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation fails because all cache entries have been evicted then a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation fails because all cache entries have been evicted then an "elasticache" "cluster" is created then the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Given iid in inv_status
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    When an "elasticache" "cluster" is created
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation fails because all cache entries have been evicted then the "lambda" "function" is invoked then the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    Given iid in inv_status
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    When the "lambda" "function" is invoked
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation fails because all cache entries have been evicted then the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation then the "lambda" "function" invocation reads an existing cache entry and completes successfully
    Given iid in inv_status
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation fails because all cache entries have been evicted then the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    When the "elasticache" "cluster" evicts a "cache" "entry" due to memory pressure or "TTL" expiry
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @sequence
  Scenario: the "lambda" "function" invocation fails because all cache entries have been evicted then the "lambda" "function" invocation reads an existing cache entry and completes successfully then an "elasticache" "cluster" is created
    Given iid in inv_status
    When the "lambda" "function" invocation fails because all cache entries have been evicted
    When the "lambda" "function" invocation reads an existing cache entry and completes successfully
    When an "elasticache" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"
