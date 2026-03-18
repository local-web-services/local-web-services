@lambdadocdb @generated
Feature: LambdaDocdb - The Lambda Function Fails To Connect Because The Documentdb Cluster Is Stopped

  # Generated from FizzBee spec: lambda_docdb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentReferencesExistingCluster

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_cluster_stopped
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given an invocation is "IN_PROGRESS"
    And the cluster is "STOPPED"
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    Then the invocation is "FAILED" with a connection error
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @standard @negative @invocation_fails_cluster_stopped @lifecycle
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    Then the operation is rejected

  @standard @negative @invocation_fails_cluster_stopped @lifecycle
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped fails when the cluster is not "STOPPED"
    Given an invocation is "IN_PROGRESS"
    And the cluster is not "STOPPED"
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    Then the operation is rejected
