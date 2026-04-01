@lambdamemorydb @generated
Feature: LambdaMemorydb - Action Sequences

  # Generated from FizzBee spec: lambda_memorydb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingCluster

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "lambda" "function" is deployed then a "memorydb" "cluster" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "memorydb" "cluster" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a "memorydb" "cluster" update begins
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "memorydb" "cluster" update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "memorydb" "cluster" update completes
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "memorydb" "cluster" update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" is created then a "lambda" "function" is deployed
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" is created then a "memorydb" "cluster" update begins
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When a "memorydb" "cluster" update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" is created then the "memorydb" "cluster" update completes
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When the "memorydb" "cluster" update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" is created then the "lambda" "function" is invoked
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" is created then the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" is created then the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" update begins then a "lambda" "function" is deployed
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" update begins then a "memorydb" "cluster" is created
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When a "memorydb" "cluster" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" update begins then the "memorydb" "cluster" update completes
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When the "memorydb" "cluster" update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" update begins then the "lambda" "function" is invoked
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" update begins then the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" update begins then the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "memorydb" "cluster" update completes then a "lambda" "function" is deployed
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "memorydb" "cluster" update completes then a "memorydb" "cluster" is created
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When a "memorydb" "cluster" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "memorydb" "cluster" update completes then a "memorydb" "cluster" update begins
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When a "memorydb" "cluster" update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "memorydb" "cluster" update completes then the "lambda" "function" is invoked
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "memorydb" "cluster" update completes then the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "memorydb" "cluster" update completes then the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "memorydb" "cluster" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "memorydb" "cluster" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "memorydb" "cluster" update begins
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "memorydb" "cluster" update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "memorydb" "cluster" update completes
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "memorydb" "cluster" update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a "memorydb" "cluster" is created
    Given iid in inv_status
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a "memorydb" "cluster" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a "memorydb" "cluster" update begins
    Given iid in inv_status
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a "memorydb" "cluster" update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the "memorydb" "cluster" update completes
    Given iid in inv_status
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When the "memorydb" "cluster" update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    Given iid in inv_status
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "memorydb" "cluster" is updating then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "memorydb" "cluster" is updating then a "memorydb" "cluster" is created
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    When a "memorydb" "cluster" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "memorydb" "cluster" is updating then a "memorydb" "cluster" update begins
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    When a "memorydb" "cluster" update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "memorydb" "cluster" is updating then the "memorydb" "cluster" update completes
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    When the "memorydb" "cluster" update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "memorydb" "cluster" is updating then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "memorydb" "cluster" is updating then the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a "memorydb" "cluster" is created then a "memorydb" "cluster" update begins
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "memorydb" "cluster" is created
    When a "memorydb" "cluster" update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a "memorydb" "cluster" update begins then the "memorydb" "cluster" update completes
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "memorydb" "cluster" update begins
    When the "memorydb" "cluster" update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "memorydb" "cluster" update completes then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "memorydb" "cluster" update completes
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked then the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails to write because the "memorydb" "cluster" is updating then a "memorydb" "cluster" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    When a "memorydb" "cluster" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" is created then a "lambda" "function" is deployed then the "memorydb" "cluster" update completes
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When a "lambda" "function" is deployed
    When the "memorydb" "cluster" update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" is created then a "memorydb" "cluster" update begins then the "lambda" "function" is invoked
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When a "memorydb" "cluster" update begins
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" is created then the "memorydb" "cluster" update completes then the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When the "memorydb" "cluster" update completes
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" is created then the "lambda" "function" is invoked then the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" is created then the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a "lambda" "function" is deployed
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" is created then the "lambda" "function" fails to write because the "memorydb" "cluster" is updating then a "memorydb" "cluster" update begins
    Given cid not in cluster_status
    When a "memorydb" "cluster" is created
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    When a "memorydb" "cluster" update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" update begins then a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" update begins then a "memorydb" "cluster" is created then the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When a "memorydb" "cluster" is created
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" update begins then the "memorydb" "cluster" update completes then the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When the "memorydb" "cluster" update completes
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" update begins then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" update begins then the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a "memorydb" "cluster" is created
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a "memorydb" "cluster" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: a "memorydb" "cluster" update begins then the "lambda" "function" fails to write because the "memorydb" "cluster" is updating then the "memorydb" "cluster" update completes
    Given cid in cluster_status
    When a "memorydb" "cluster" update begins
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    When the "memorydb" "cluster" update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "memorydb" "cluster" update completes then a "lambda" "function" is deployed then the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When a "lambda" "function" is deployed
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "memorydb" "cluster" update completes then a "memorydb" "cluster" is created then the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When a "memorydb" "cluster" is created
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "memorydb" "cluster" update completes then a "memorydb" "cluster" update begins then a "lambda" "function" is deployed
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When a "memorydb" "cluster" update begins
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "memorydb" "cluster" update completes then the "lambda" "function" is invoked then a "memorydb" "cluster" is created
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When the "lambda" "function" is invoked
    When a "memorydb" "cluster" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "memorydb" "cluster" update completes then the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a "memorydb" "cluster" update begins
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a "memorydb" "cluster" update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "memorydb" "cluster" update completes then the "lambda" "function" fails to write because the "memorydb" "cluster" is updating then the "lambda" "function" is invoked
    Given cid in cluster_status
    When the "memorydb" "cluster" update completes
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed then the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "memorydb" "cluster" is created then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "memorydb" "cluster" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "memorydb" "cluster" update begins then a "memorydb" "cluster" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "memorydb" "cluster" update begins
    When a "memorydb" "cluster" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "memorydb" "cluster" update completes then a "memorydb" "cluster" update begins
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "memorydb" "cluster" update completes
    When a "memorydb" "cluster" update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the "memorydb" "cluster" update completes
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When the "memorydb" "cluster" update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails to write because the "memorydb" "cluster" is updating then the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a "lambda" "function" is deployed then a "memorydb" "cluster" is created
    Given iid in inv_status
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a "lambda" "function" is deployed
    When a "memorydb" "cluster" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a "memorydb" "cluster" is created then a "memorydb" "cluster" update begins
    Given iid in inv_status
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a "memorydb" "cluster" is created
    When a "memorydb" "cluster" update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a "memorydb" "cluster" update begins then the "memorydb" "cluster" update completes
    Given iid in inv_status
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a "memorydb" "cluster" update begins
    When the "memorydb" "cluster" update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the "memorydb" "cluster" update completes then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When the "memorydb" "cluster" update completes
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the "lambda" "function" is invoked then the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    Given iid in inv_status
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation then the "lambda" "function" fails to write because the "memorydb" "cluster" is updating then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "memorydb" "cluster" is updating then a "lambda" "function" is deployed then a "memorydb" "cluster" update begins
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    When a "lambda" "function" is deployed
    When a "memorydb" "cluster" update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "memorydb" "cluster" is updating then a "memorydb" "cluster" is created then the "memorydb" "cluster" update completes
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    When a "memorydb" "cluster" is created
    When the "memorydb" "cluster" update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "memorydb" "cluster" is updating then a "memorydb" "cluster" update begins then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    When a "memorydb" "cluster" update begins
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "memorydb" "cluster" is updating then the "memorydb" "cluster" update completes then the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    When the "memorydb" "cluster" update completes
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "memorydb" "cluster" is updating then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "memorydb" "cluster" is updating then the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation then a "memorydb" "cluster" is created
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "memorydb" "cluster" is updating
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    When a "memorydb" "cluster" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a "memorydb" "cluster" that exists
