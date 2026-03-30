@lambdadocdb @generated
Feature: LambdaDocdb - A Documentdb Cluster Is Created

  # Generated from FizzBee spec: lambda_docdb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentReferencesExistingCluster

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: a DocumentDB cluster is created
    Given the cluster does not already exist
    When a DocumentDB cluster is created
    Then the cluster is "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @guard @negative @create_cluster
  Scenario: a DocumentDB cluster is created fails when the cluster already exists
    Given the cluster already exists
    When a DocumentDB cluster is created
    Then the operation is rejected
