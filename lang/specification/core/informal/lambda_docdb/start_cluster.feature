@lambdadocdb @generated
Feature: LambdaDocdb - The Documentdb Cluster Is Started

  # Generated from FizzBee spec: lambda_docdb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentReferencesExistingCluster

  Background:
    Given the system is initialized

  @minimal @happy @start_cluster
  Scenario: the DocumentDB cluster is started
    Given the cluster is "STOPPED"
    When the DocumentDB cluster is started
    Then the cluster is "AVAILABLE" and ready to accept connections
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @standard @negative @start_cluster @lifecycle
  Scenario: the DocumentDB cluster is started fails when the cluster is not "STOPPED"
    Given the cluster is not "STOPPED"
    When the DocumentDB cluster is started
    Then the operation is rejected
