@lambdamemorydb @generated
Feature: LambdaMemorydb - Action Sequences

  # Generated from FizzBee spec: lambda_memorydb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingCluster

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a MemoryDB cluster is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a MemoryDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a MemoryDB cluster update begins
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a MemoryDB cluster update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the MemoryDB cluster update completes
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the MemoryDB cluster update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to write because the cluster is updating
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function fails to write because the cluster is updating
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a Lambda function is deployed
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a MemoryDB cluster update begins
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    When a MemoryDB cluster update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then the MemoryDB cluster update completes
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    When the MemoryDB cluster update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then the Lambda function is invoked
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then the Lambda function fails to write because the cluster is updating
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    When the Lambda function fails to write because the cluster is updating
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a Lambda function is deployed
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a MemoryDB cluster is created
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    When a MemoryDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then the MemoryDB cluster update completes
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    When the MemoryDB cluster update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then the Lambda function is invoked
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then the Lambda function fails to write because the cluster is updating
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    When the Lambda function fails to write because the cluster is updating
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a Lambda function is deployed
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a MemoryDB cluster is created
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    When a MemoryDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a MemoryDB cluster update begins
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    When a MemoryDB cluster update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then the Lambda function is invoked
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then the Lambda function fails to write because the cluster is updating
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    When the Lambda function fails to write because the cluster is updating
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a MemoryDB cluster is created
    Given fid in func_status
    Given the Lambda function has been invoked
    When a MemoryDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a MemoryDB cluster update begins
    Given fid in func_status
    Given the Lambda function has been invoked
    When a MemoryDB cluster update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the MemoryDB cluster update completes
    Given fid in func_status
    Given the Lambda function has been invoked
    When the MemoryDB cluster update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to write because the cluster is updating
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function fails to write because the cluster is updating
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has written a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a MemoryDB cluster is created
    Given iid in inv_status
    Given the Lambda function has written a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a MemoryDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a MemoryDB cluster update begins
    Given iid in inv_status
    Given the Lambda function has written a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a MemoryDB cluster update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the MemoryDB cluster update completes
    Given iid in inv_status
    Given the Lambda function has written a record to the "AVAILABLE" MemoryDB cluster during invocation
    When the MemoryDB cluster update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has written a record to the "AVAILABLE" MemoryDB cluster during invocation
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the Lambda function fails to write because the cluster is updating
    Given iid in inv_status
    Given the Lambda function has written a record to the "AVAILABLE" MemoryDB cluster during invocation
    When the Lambda function fails to write because the cluster is updating
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has failed to write because the cluster is updating
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then a MemoryDB cluster is created
    Given iid in inv_status
    Given the Lambda function has failed to write because the cluster is updating
    When a MemoryDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then a MemoryDB cluster update begins
    Given iid in inv_status
    Given the Lambda function has failed to write because the cluster is updating
    When a MemoryDB cluster update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then the MemoryDB cluster update completes
    Given iid in inv_status
    Given the Lambda function has failed to write because the cluster is updating
    When the MemoryDB cluster update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has failed to write because the cluster is updating
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given iid in inv_status
    Given the Lambda function has failed to write because the cluster is updating
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a MemoryDB cluster is created then a MemoryDB cluster update begins
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a MemoryDB cluster has been created
    When a MemoryDB cluster update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a MemoryDB cluster update begins then the MemoryDB cluster update completes
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a MemoryDB cluster update has begun
    When the MemoryDB cluster update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the MemoryDB cluster update completes then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the MemoryDB cluster update has completed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has been invoked
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the Lambda function fails to write because the cluster is updating
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has written a record to the "AVAILABLE" MemoryDB cluster during invocation
    When the Lambda function fails to write because the cluster is updating
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to write because the cluster is updating then a MemoryDB cluster is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has failed to write because the cluster is updating
    When a MemoryDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a Lambda function is deployed then the MemoryDB cluster update completes
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    Given a Lambda function has been deployed
    When the MemoryDB cluster update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a MemoryDB cluster update begins then the Lambda function is invoked
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    Given a MemoryDB cluster update has begun
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then the MemoryDB cluster update completes then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    Given the MemoryDB cluster update has completed
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then the Lambda function is invoked then the Lambda function fails to write because the cluster is updating
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    Given the Lambda function has been invoked
    When the Lambda function fails to write because the cluster is updating
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a Lambda function is deployed
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    Given the Lambda function has written a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then the Lambda function fails to write because the cluster is updating then a MemoryDB cluster update begins
    Given cid not in cluster_status
    Given a MemoryDB cluster has been created
    Given the Lambda function has failed to write because the cluster is updating
    When a MemoryDB cluster update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a Lambda function is deployed then the Lambda function is invoked
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a MemoryDB cluster is created then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    Given a MemoryDB cluster has been created
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then the MemoryDB cluster update completes then the Lambda function fails to write because the cluster is updating
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    Given the MemoryDB cluster update has completed
    When the Lambda function fails to write because the cluster is updating
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then the Lambda function is invoked then a Lambda function is deployed
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a MemoryDB cluster is created
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    Given the Lambda function has written a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a MemoryDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then the Lambda function fails to write because the cluster is updating then the MemoryDB cluster update completes
    Given cid in cluster_status
    Given a MemoryDB cluster update has begun
    Given the Lambda function has failed to write because the cluster is updating
    When the MemoryDB cluster update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a Lambda function is deployed then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    Given a Lambda function has been deployed
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a MemoryDB cluster is created then the Lambda function fails to write because the cluster is updating
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    Given a MemoryDB cluster has been created
    When the Lambda function fails to write because the cluster is updating
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a MemoryDB cluster update begins then a Lambda function is deployed
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    Given a MemoryDB cluster update has begun
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then the Lambda function is invoked then a MemoryDB cluster is created
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    Given the Lambda function has been invoked
    When a MemoryDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a MemoryDB cluster update begins
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    Given the Lambda function has written a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a MemoryDB cluster update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then the Lambda function fails to write because the cluster is updating then the Lambda function is invoked
    Given cid in cluster_status
    Given the MemoryDB cluster update has completed
    Given the Lambda function has failed to write because the cluster is updating
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function fails to write because the cluster is updating
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Lambda function has been deployed
    When the Lambda function fails to write because the cluster is updating
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a MemoryDB cluster is created then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a MemoryDB cluster has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a MemoryDB cluster update begins then a MemoryDB cluster is created
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a MemoryDB cluster update has begun
    When a MemoryDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the MemoryDB cluster update completes then a MemoryDB cluster update begins
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the MemoryDB cluster update has completed
    When a MemoryDB cluster update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the MemoryDB cluster update completes
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has written a record to the "AVAILABLE" MemoryDB cluster during invocation
    When the MemoryDB cluster update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to write because the cluster is updating then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has failed to write because the cluster is updating
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a Lambda function is deployed then a MemoryDB cluster is created
    Given iid in inv_status
    Given the Lambda function has written a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given a Lambda function has been deployed
    When a MemoryDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a MemoryDB cluster is created then a MemoryDB cluster update begins
    Given iid in inv_status
    Given the Lambda function has written a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given a MemoryDB cluster has been created
    When a MemoryDB cluster update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a MemoryDB cluster update begins then the MemoryDB cluster update completes
    Given iid in inv_status
    Given the Lambda function has written a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given a MemoryDB cluster update has begun
    When the MemoryDB cluster update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the MemoryDB cluster update completes then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has written a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given the MemoryDB cluster update has completed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the Lambda function is invoked then the Lambda function fails to write because the cluster is updating
    Given iid in inv_status
    Given the Lambda function has written a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given the Lambda function has been invoked
    When the Lambda function fails to write because the cluster is updating
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the Lambda function fails to write because the cluster is updating then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has written a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given the Lambda function has failed to write because the cluster is updating
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then a Lambda function is deployed then a MemoryDB cluster update begins
    Given iid in inv_status
    Given the Lambda function has failed to write because the cluster is updating
    Given a Lambda function has been deployed
    When a MemoryDB cluster update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then a MemoryDB cluster is created then the MemoryDB cluster update completes
    Given iid in inv_status
    Given the Lambda function has failed to write because the cluster is updating
    Given a MemoryDB cluster has been created
    When the MemoryDB cluster update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then a MemoryDB cluster update begins then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has failed to write because the cluster is updating
    Given a MemoryDB cluster update has begun
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then the MemoryDB cluster update completes then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given iid in inv_status
    Given the Lambda function has failed to write because the cluster is updating
    Given the MemoryDB cluster update has completed
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has failed to write because the cluster is updating
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a MemoryDB cluster is created
    Given iid in inv_status
    Given the Lambda function has failed to write because the cluster is updating
    Given the Lambda function has written a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a MemoryDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists
