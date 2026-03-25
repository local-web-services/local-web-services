@lambdamemorydb @generated
Feature: LambdaMemorydb - Action Sequences

  # Generated from FizzBee spec: lambda_memorydb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingCluster

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a MemoryDB cluster is created
    Given fid not in func_status
    When a Lambda function is deployed
    When a MemoryDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a MemoryDB cluster update begins
    Given fid not in func_status
    When a Lambda function is deployed
    When a MemoryDB cluster update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the MemoryDB cluster update completes
    Given fid not in func_status
    When a Lambda function is deployed
    When the MemoryDB cluster update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to write because the cluster is updating
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to write because the cluster is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a Lambda function is deployed
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a MemoryDB cluster update begins
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When a MemoryDB cluster update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then the MemoryDB cluster update completes
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When the MemoryDB cluster update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then the Lambda function is invoked
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then the Lambda function fails to write because the cluster is updating
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When the Lambda function fails to write because the cluster is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a Lambda function is deployed
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a MemoryDB cluster is created
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When a MemoryDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then the MemoryDB cluster update completes
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When the MemoryDB cluster update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then the Lambda function is invoked
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then the Lambda function fails to write because the cluster is updating
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When the Lambda function fails to write because the cluster is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a Lambda function is deployed
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a MemoryDB cluster is created
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When a MemoryDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a MemoryDB cluster update begins
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When a MemoryDB cluster update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then the Lambda function is invoked
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then the Lambda function fails to write because the cluster is updating
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When the Lambda function fails to write because the cluster is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a MemoryDB cluster is created
    Given fid in func_status
    When the Lambda function is invoked
    When a MemoryDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a MemoryDB cluster update begins
    Given fid in func_status
    When the Lambda function is invoked
    When a MemoryDB cluster update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the MemoryDB cluster update completes
    Given fid in func_status
    When the Lambda function is invoked
    When the MemoryDB cluster update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to write because the cluster is updating
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to write because the cluster is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a MemoryDB cluster is created
    Given iid in inv_status
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a MemoryDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a MemoryDB cluster update begins
    Given iid in inv_status
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a MemoryDB cluster update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the MemoryDB cluster update completes
    Given iid in inv_status
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When the MemoryDB cluster update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the Lambda function fails to write because the cluster is updating
    Given iid in inv_status
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When the Lambda function fails to write because the cluster is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to write because the cluster is updating
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then a MemoryDB cluster is created
    Given iid in inv_status
    When the Lambda function fails to write because the cluster is updating
    When a MemoryDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then a MemoryDB cluster update begins
    Given iid in inv_status
    When the Lambda function fails to write because the cluster is updating
    When a MemoryDB cluster update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then the MemoryDB cluster update completes
    Given iid in inv_status
    When the Lambda function fails to write because the cluster is updating
    When the MemoryDB cluster update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to write because the cluster is updating
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given iid in inv_status
    When the Lambda function fails to write because the cluster is updating
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a MemoryDB cluster is created then a MemoryDB cluster update begins
    Given fid not in func_status
    When a Lambda function is deployed
    When a MemoryDB cluster is created
    When a MemoryDB cluster update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a MemoryDB cluster update begins then the MemoryDB cluster update completes
    Given fid not in func_status
    When a Lambda function is deployed
    When a MemoryDB cluster update begins
    When the MemoryDB cluster update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the MemoryDB cluster update completes then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the MemoryDB cluster update completes
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the Lambda function fails to write because the cluster is updating
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When the Lambda function fails to write because the cluster is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to write because the cluster is updating then a MemoryDB cluster is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to write because the cluster is updating
    When a MemoryDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a Lambda function is deployed then the MemoryDB cluster update completes
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When a Lambda function is deployed
    When the MemoryDB cluster update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then a MemoryDB cluster update begins then the Lambda function is invoked
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When a MemoryDB cluster update begins
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then the MemoryDB cluster update completes then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When the MemoryDB cluster update completes
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then the Lambda function is invoked then the Lambda function fails to write because the cluster is updating
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When the Lambda function is invoked
    When the Lambda function fails to write because the cluster is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a Lambda function is deployed
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster is created then the Lambda function fails to write because the cluster is updating then a MemoryDB cluster update begins
    Given cid not in cluster_status
    When a MemoryDB cluster is created
    When the Lambda function fails to write because the cluster is updating
    When a MemoryDB cluster update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a Lambda function is deployed then the Lambda function is invoked
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then a MemoryDB cluster is created then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When a MemoryDB cluster is created
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then the MemoryDB cluster update completes then the Lambda function fails to write because the cluster is updating
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When the MemoryDB cluster update completes
    When the Lambda function fails to write because the cluster is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then the Lambda function is invoked then a Lambda function is deployed
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a MemoryDB cluster is created
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a MemoryDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: a MemoryDB cluster update begins then the Lambda function fails to write because the cluster is updating then the MemoryDB cluster update completes
    Given cid in cluster_status
    When a MemoryDB cluster update begins
    When the Lambda function fails to write because the cluster is updating
    When the MemoryDB cluster update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a Lambda function is deployed then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When a Lambda function is deployed
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a MemoryDB cluster is created then the Lambda function fails to write because the cluster is updating
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When a MemoryDB cluster is created
    When the Lambda function fails to write because the cluster is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then a MemoryDB cluster update begins then a Lambda function is deployed
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When a MemoryDB cluster update begins
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then the Lambda function is invoked then a MemoryDB cluster is created
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When the Lambda function is invoked
    When a MemoryDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a MemoryDB cluster update begins
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a MemoryDB cluster update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the MemoryDB cluster update completes then the Lambda function fails to write because the cluster is updating then the Lambda function is invoked
    Given cid in cluster_status
    When the MemoryDB cluster update completes
    When the Lambda function fails to write because the cluster is updating
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function fails to write because the cluster is updating
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda function fails to write because the cluster is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a MemoryDB cluster is created then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a MemoryDB cluster is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a MemoryDB cluster update begins then a MemoryDB cluster is created
    Given fid in func_status
    When the Lambda function is invoked
    When a MemoryDB cluster update begins
    When a MemoryDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the MemoryDB cluster update completes then a MemoryDB cluster update begins
    Given fid in func_status
    When the Lambda function is invoked
    When the MemoryDB cluster update completes
    When a MemoryDB cluster update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the MemoryDB cluster update completes
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When the MemoryDB cluster update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to write because the cluster is updating then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to write because the cluster is updating
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a Lambda function is deployed then a MemoryDB cluster is created
    Given iid in inv_status
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a Lambda function is deployed
    When a MemoryDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a MemoryDB cluster is created then a MemoryDB cluster update begins
    Given iid in inv_status
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a MemoryDB cluster is created
    When a MemoryDB cluster update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a MemoryDB cluster update begins then the MemoryDB cluster update completes
    Given iid in inv_status
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a MemoryDB cluster update begins
    When the MemoryDB cluster update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the MemoryDB cluster update completes then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When the MemoryDB cluster update completes
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the Lambda function is invoked then the Lambda function fails to write because the cluster is updating
    Given iid in inv_status
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When the Lambda function is invoked
    When the Lambda function fails to write because the cluster is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the Lambda function fails to write because the cluster is updating then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When the Lambda function fails to write because the cluster is updating
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then a Lambda function is deployed then a MemoryDB cluster update begins
    Given iid in inv_status
    When the Lambda function fails to write because the cluster is updating
    When a Lambda function is deployed
    When a MemoryDB cluster update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then a MemoryDB cluster is created then the MemoryDB cluster update completes
    Given iid in inv_status
    When the Lambda function fails to write because the cluster is updating
    When a MemoryDB cluster is created
    When the MemoryDB cluster update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then a MemoryDB cluster update begins then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to write because the cluster is updating
    When a MemoryDB cluster update begins
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then the MemoryDB cluster update completes then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given iid in inv_status
    When the Lambda function fails to write because the cluster is updating
    When the MemoryDB cluster update completes
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to write because the cluster is updating
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the cluster is updating then the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a MemoryDB cluster is created
    Given iid in inv_status
    When the Lambda function fails to write because the cluster is updating
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a MemoryDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists
