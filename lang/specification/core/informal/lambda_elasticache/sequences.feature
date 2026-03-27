@lambdaelasticache @generated
Feature: LambdaElasticache - Action Sequences

  # Generated from FizzBee spec: lambda_elasticache.fizz
  # Safety invariants: InvocationRequiresActiveFunction, CachedEntryRequiresAvailableCluster

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an ElastiCache cluster is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    When an ElastiCache cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes a value to the ElastiCache cluster during invocation
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function writes a value to the ElastiCache cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Given fid not in func_status
    Given a Lambda function has been deployed
    When ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation reads an existing cache entry and completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda invocation reads an existing cache entry and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails because all cache entries have been evicted
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda invocation fails because all cache entries have been evicted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then a Lambda function is deployed
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then the Lambda function is invoked
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then the Lambda function writes a value to the ElastiCache cluster during invocation
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    When the Lambda function writes a value to the ElastiCache cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    When ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then the Lambda invocation reads an existing cache entry and completes successfully
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    When the Lambda invocation reads an existing cache entry and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then the Lambda invocation fails because all cache entries have been evicted
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    When the Lambda invocation fails because all cache entries have been evicted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an ElastiCache cluster is created
    Given fid in func_status
    Given the Lambda function has been invoked
    When an ElastiCache cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes a value to the ElastiCache cluster during invocation
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function writes a value to the ElastiCache cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Given fid in func_status
    Given the Lambda function has been invoked
    When ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation reads an existing cache entry and completes successfully
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda invocation reads an existing cache entry and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails because all cache entries have been evicted
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda invocation fails because all cache entries have been evicted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function writes a value to the ElastiCache cluster during invocation then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has written a value to the ElastiCache cluster during invocation
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function writes a value to the ElastiCache cluster during invocation then an ElastiCache cluster is created
    Given iid in inv_status
    Given the Lambda function has written a value to the ElastiCache cluster during invocation
    When an ElastiCache cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function writes a value to the ElastiCache cluster during invocation then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has written a value to the ElastiCache cluster during invocation
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function writes a value to the ElastiCache cluster during invocation then ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Given iid in inv_status
    Given the Lambda function has written a value to the ElastiCache cluster during invocation
    When ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function writes a value to the ElastiCache cluster during invocation then the Lambda invocation reads an existing cache entry and completes successfully
    Given iid in inv_status
    Given the Lambda function has written a value to the ElastiCache cluster during invocation
    When the Lambda invocation reads an existing cache entry and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function writes a value to the ElastiCache cluster during invocation then the Lambda invocation fails because all cache entries have been evicted
    Given iid in inv_status
    Given the Lambda function has written a value to the ElastiCache cluster during invocation
    When the Lambda invocation fails because all cache entries have been evicted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry then a Lambda function is deployed
    Given kid in key_status
    Given ElastiCache has evicted a cache entry due to memory pressure or "TTL" expiry
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry then an ElastiCache cluster is created
    Given kid in key_status
    Given ElastiCache has evicted a cache entry due to memory pressure or "TTL" expiry
    When an ElastiCache cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry then the Lambda function is invoked
    Given kid in key_status
    Given ElastiCache has evicted a cache entry due to memory pressure or "TTL" expiry
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry then the Lambda function writes a value to the ElastiCache cluster during invocation
    Given kid in key_status
    Given ElastiCache has evicted a cache entry due to memory pressure or "TTL" expiry
    When the Lambda function writes a value to the ElastiCache cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry then the Lambda invocation reads an existing cache entry and completes successfully
    Given kid in key_status
    Given ElastiCache has evicted a cache entry due to memory pressure or "TTL" expiry
    When the Lambda invocation reads an existing cache entry and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry then the Lambda invocation fails because all cache entries have been evicted
    Given kid in key_status
    Given ElastiCache has evicted a cache entry due to memory pressure or "TTL" expiry
    When the Lambda invocation fails because all cache entries have been evicted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation reads an existing cache entry and completes successfully then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has read an existing cache entry and completed successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation reads an existing cache entry and completes successfully then an ElastiCache cluster is created
    Given iid in inv_status
    Given the Lambda invocation has read an existing cache entry and completed successfully
    When an ElastiCache cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation reads an existing cache entry and completes successfully then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda invocation has read an existing cache entry and completed successfully
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation reads an existing cache entry and completes successfully then the Lambda function writes a value to the ElastiCache cluster during invocation
    Given iid in inv_status
    Given the Lambda invocation has read an existing cache entry and completed successfully
    When the Lambda function writes a value to the ElastiCache cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation reads an existing cache entry and completes successfully then ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Given iid in inv_status
    Given the Lambda invocation has read an existing cache entry and completed successfully
    When ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation reads an existing cache entry and completes successfully then the Lambda invocation fails because all cache entries have been evicted
    Given iid in inv_status
    Given the Lambda invocation has read an existing cache entry and completed successfully
    When the Lambda invocation fails because all cache entries have been evicted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation fails because all cache entries have been evicted then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has failed because all cache entries have been evicted
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation fails because all cache entries have been evicted then an ElastiCache cluster is created
    Given iid in inv_status
    Given the Lambda invocation has failed because all cache entries have been evicted
    When an ElastiCache cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation fails because all cache entries have been evicted then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda invocation has failed because all cache entries have been evicted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation fails because all cache entries have been evicted then the Lambda function writes a value to the ElastiCache cluster during invocation
    Given iid in inv_status
    Given the Lambda invocation has failed because all cache entries have been evicted
    When the Lambda function writes a value to the ElastiCache cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation fails because all cache entries have been evicted then ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Given iid in inv_status
    Given the Lambda invocation has failed because all cache entries have been evicted
    When ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation fails because all cache entries have been evicted then the Lambda invocation reads an existing cache entry and completes successfully
    Given iid in inv_status
    Given the Lambda invocation has failed because all cache entries have been evicted
    When the Lambda invocation reads an existing cache entry and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an ElastiCache cluster is created then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given an ElastiCache cluster has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function writes a value to the ElastiCache cluster during invocation
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has been invoked
    When the Lambda function writes a value to the ElastiCache cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes a value to the ElastiCache cluster during invocation then ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has written a value to the ElastiCache cluster during invocation
    When ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry then the Lambda invocation reads an existing cache entry and completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given ElastiCache has evicted a cache entry due to memory pressure or "TTL" expiry
    When the Lambda invocation reads an existing cache entry and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation reads an existing cache entry and completes successfully then the Lambda invocation fails because all cache entries have been evicted
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda invocation has read an existing cache entry and completed successfully
    When the Lambda invocation fails because all cache entries have been evicted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails because all cache entries have been evicted then an ElastiCache cluster is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda invocation has failed because all cache entries have been evicted
    When an ElastiCache cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then a Lambda function is deployed then the Lambda function writes a value to the ElastiCache cluster during invocation
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    Given a Lambda function has been deployed
    When the Lambda function writes a value to the ElastiCache cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then the Lambda function is invoked then ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    Given the Lambda function has been invoked
    When ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then the Lambda function writes a value to the ElastiCache cluster during invocation then the Lambda invocation reads an existing cache entry and completes successfully
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    Given the Lambda function has written a value to the ElastiCache cluster during invocation
    When the Lambda invocation reads an existing cache entry and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry then the Lambda invocation fails because all cache entries have been evicted
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    Given ElastiCache has evicted a cache entry due to memory pressure or "TTL" expiry
    When the Lambda invocation fails because all cache entries have been evicted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then the Lambda invocation reads an existing cache entry and completes successfully then a Lambda function is deployed
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    Given the Lambda invocation has read an existing cache entry and completed successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then the Lambda invocation fails because all cache entries have been evicted then the Lambda function is invoked
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    Given the Lambda invocation has failed because all cache entries have been evicted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Lambda function has been deployed
    When ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an ElastiCache cluster is created then the Lambda invocation reads an existing cache entry and completes successfully
    Given fid in func_status
    Given the Lambda function has been invoked
    Given an ElastiCache cluster has been created
    When the Lambda invocation reads an existing cache entry and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes a value to the ElastiCache cluster during invocation then the Lambda invocation fails because all cache entries have been evicted
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has written a value to the ElastiCache cluster during invocation
    When the Lambda invocation fails because all cache entries have been evicted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    Given ElastiCache has evicted a cache entry due to memory pressure or "TTL" expiry
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation reads an existing cache entry and completes successfully then an ElastiCache cluster is created
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda invocation has read an existing cache entry and completed successfully
    When an ElastiCache cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails because all cache entries have been evicted then the Lambda function writes a value to the ElastiCache cluster during invocation
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda invocation has failed because all cache entries have been evicted
    When the Lambda function writes a value to the ElastiCache cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function writes a value to the ElastiCache cluster during invocation then a Lambda function is deployed then the Lambda invocation reads an existing cache entry and completes successfully
    Given iid in inv_status
    Given the Lambda function has written a value to the ElastiCache cluster during invocation
    Given a Lambda function has been deployed
    When the Lambda invocation reads an existing cache entry and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function writes a value to the ElastiCache cluster during invocation then an ElastiCache cluster is created then the Lambda invocation fails because all cache entries have been evicted
    Given iid in inv_status
    Given the Lambda function has written a value to the ElastiCache cluster during invocation
    Given an ElastiCache cluster has been created
    When the Lambda invocation fails because all cache entries have been evicted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function writes a value to the ElastiCache cluster during invocation then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has written a value to the ElastiCache cluster during invocation
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function writes a value to the ElastiCache cluster during invocation then ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry then an ElastiCache cluster is created
    Given iid in inv_status
    Given the Lambda function has written a value to the ElastiCache cluster during invocation
    Given ElastiCache has evicted a cache entry due to memory pressure or "TTL" expiry
    When an ElastiCache cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function writes a value to the ElastiCache cluster during invocation then the Lambda invocation reads an existing cache entry and completes successfully then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has written a value to the ElastiCache cluster during invocation
    Given the Lambda invocation has read an existing cache entry and completed successfully
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda function writes a value to the ElastiCache cluster during invocation then the Lambda invocation fails because all cache entries have been evicted then ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Given iid in inv_status
    Given the Lambda function has written a value to the ElastiCache cluster during invocation
    Given the Lambda invocation has failed because all cache entries have been evicted
    When ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry then a Lambda function is deployed then the Lambda invocation fails because all cache entries have been evicted
    Given kid in key_status
    Given ElastiCache has evicted a cache entry due to memory pressure or "TTL" expiry
    Given a Lambda function has been deployed
    When the Lambda invocation fails because all cache entries have been evicted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry then an ElastiCache cluster is created then a Lambda function is deployed
    Given kid in key_status
    Given ElastiCache has evicted a cache entry due to memory pressure or "TTL" expiry
    Given an ElastiCache cluster has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry then the Lambda function is invoked then an ElastiCache cluster is created
    Given kid in key_status
    Given ElastiCache has evicted a cache entry due to memory pressure or "TTL" expiry
    Given the Lambda function has been invoked
    When an ElastiCache cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry then the Lambda function writes a value to the ElastiCache cluster during invocation then the Lambda function is invoked
    Given kid in key_status
    Given ElastiCache has evicted a cache entry due to memory pressure or "TTL" expiry
    Given the Lambda function has written a value to the ElastiCache cluster during invocation
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry then the Lambda invocation reads an existing cache entry and completes successfully then the Lambda function writes a value to the ElastiCache cluster during invocation
    Given kid in key_status
    Given ElastiCache has evicted a cache entry due to memory pressure or "TTL" expiry
    Given the Lambda invocation has read an existing cache entry and completed successfully
    When the Lambda function writes a value to the ElastiCache cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry then the Lambda invocation fails because all cache entries have been evicted then the Lambda invocation reads an existing cache entry and completes successfully
    Given kid in key_status
    Given ElastiCache has evicted a cache entry due to memory pressure or "TTL" expiry
    Given the Lambda invocation has failed because all cache entries have been evicted
    When the Lambda invocation reads an existing cache entry and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation reads an existing cache entry and completes successfully then a Lambda function is deployed then an ElastiCache cluster is created
    Given iid in inv_status
    Given the Lambda invocation has read an existing cache entry and completed successfully
    Given a Lambda function has been deployed
    When an ElastiCache cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation reads an existing cache entry and completes successfully then an ElastiCache cluster is created then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda invocation has read an existing cache entry and completed successfully
    Given an ElastiCache cluster has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation reads an existing cache entry and completes successfully then the Lambda function is invoked then the Lambda function writes a value to the ElastiCache cluster during invocation
    Given iid in inv_status
    Given the Lambda invocation has read an existing cache entry and completed successfully
    Given the Lambda function has been invoked
    When the Lambda function writes a value to the ElastiCache cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation reads an existing cache entry and completes successfully then the Lambda function writes a value to the ElastiCache cluster during invocation then ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Given iid in inv_status
    Given the Lambda invocation has read an existing cache entry and completed successfully
    Given the Lambda function has written a value to the ElastiCache cluster during invocation
    When ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation reads an existing cache entry and completes successfully then ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry then the Lambda invocation fails because all cache entries have been evicted
    Given iid in inv_status
    Given the Lambda invocation has read an existing cache entry and completed successfully
    Given ElastiCache has evicted a cache entry due to memory pressure or "TTL" expiry
    When the Lambda invocation fails because all cache entries have been evicted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation reads an existing cache entry and completes successfully then the Lambda invocation fails because all cache entries have been evicted then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has read an existing cache entry and completed successfully
    Given the Lambda invocation has failed because all cache entries have been evicted
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation fails because all cache entries have been evicted then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda invocation has failed because all cache entries have been evicted
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation fails because all cache entries have been evicted then an ElastiCache cluster is created then the Lambda function writes a value to the ElastiCache cluster during invocation
    Given iid in inv_status
    Given the Lambda invocation has failed because all cache entries have been evicted
    Given an ElastiCache cluster has been created
    When the Lambda function writes a value to the ElastiCache cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation fails because all cache entries have been evicted then the Lambda function is invoked then ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Given iid in inv_status
    Given the Lambda invocation has failed because all cache entries have been evicted
    Given the Lambda function has been invoked
    When ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation fails because all cache entries have been evicted then the Lambda function writes a value to the ElastiCache cluster during invocation then the Lambda invocation reads an existing cache entry and completes successfully
    Given iid in inv_status
    Given the Lambda invocation has failed because all cache entries have been evicted
    Given the Lambda function has written a value to the ElastiCache cluster during invocation
    When the Lambda invocation reads an existing cache entry and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation fails because all cache entries have been evicted then ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has failed because all cache entries have been evicted
    Given ElastiCache has evicted a cache entry due to memory pressure or "TTL" expiry
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @exhaustive @sequence
  Scenario: the Lambda invocation fails because all cache entries have been evicted then the Lambda invocation reads an existing cache entry and completes successfully then an ElastiCache cluster is created
    Given iid in inv_status
    Given the Lambda invocation has failed because all cache entries have been evicted
    Given the Lambda invocation has read an existing cache entry and completed successfully
    When an ElastiCache cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster
