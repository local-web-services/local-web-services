@lambdamemorydb @generated
Feature: LambdaMemorydb - The Lambda Function Writes A Record To The Available Memorydb Cluster During Invocation

  # Generated from FizzBee spec: lambda_memorydb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingCluster

  Background:
    Given the system is initialized

  @minimal @happy @write_record @internal
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given an invocation is "IN_PROGRESS"
    And the cluster is "AVAILABLE"
    And a record slot is available
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Then the record "EXISTS" in the cluster and the invocation is "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @standard @negative @write_record @internal
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Then the operation is rejected

  @standard @negative @write_record @internal
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation fails when the cluster is not "AVAILABLE"
    Given an invocation is "IN_PROGRESS"
    And the cluster is not "AVAILABLE"
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Then the operation is rejected

  @standard @negative @write_record @internal
  Scenario: the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation fails when no record slot is available
    Given an invocation is "IN_PROGRESS"
    And the cluster is "AVAILABLE"
    And no record slot is available
    When the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Then the operation is rejected
