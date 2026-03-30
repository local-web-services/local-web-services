@lambdamemorydb @generated
Feature: LambdaMemorydb - The Lambda Function Fails To Write Because The Cluster Is Updating

  # Generated from FizzBee spec: lambda_memorydb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingCluster

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_cluster_updating @internal
  Scenario: the Lambda function fails to write because the cluster is updating
    Given an invocation is "IN_PROGRESS"
    And the cluster is "UPDATING"
    When the Lambda function fails to write because the cluster is updating
    Then the invocation is "FAILED" with a connection refused error
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a cluster that exists

  @guard @negative @invocation_fails_cluster_updating @internal
  Scenario: the Lambda function fails to write because the cluster is updating fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function fails to write because the cluster is updating
    Then the operation is rejected

  @guard @negative @invocation_fails_cluster_updating @internal
  Scenario: the Lambda function fails to write because the cluster is updating fails when the cluster is not "UPDATING"
    Given an invocation is "IN_PROGRESS"
    And the cluster is not "UPDATING"
    When the Lambda function fails to write because the cluster is updating
    Then the operation is rejected
