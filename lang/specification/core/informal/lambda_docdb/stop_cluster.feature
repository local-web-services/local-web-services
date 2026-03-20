@lambdadocdb @generated
Feature: LambdaDocdb - The Documentdb Cluster Is Stopped

  # Generated from FizzBee spec: lambda_docdb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentReferencesExistingCluster

  Background:
    Given the system is initialized

  @minimal @happy @stop_cluster
  Scenario: the DocumentDB cluster is stopped
    Given the cluster exists
    And the cluster is "AVAILABLE"
    When the DocumentDB cluster is stopped
    Then the cluster is "STOPPED" and connections will be rejected
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @standard @negative @stop_cluster
  Scenario: the DocumentDB cluster is stopped fails when the cluster does not exist
    Given the cluster does not exist
    When the DocumentDB cluster is stopped
    Then the operation is rejected

  @standard @negative @stop_cluster @lifecycle
  Scenario: the DocumentDB cluster is stopped fails when the cluster is not "AVAILABLE"
    Given the cluster exists
    And the cluster is not "AVAILABLE"
    When the DocumentDB cluster is stopped
    Then the operation is rejected
