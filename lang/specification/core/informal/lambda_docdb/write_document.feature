@lambdadocdb @generated
Feature: LambdaDocdb - The Lambda Function Writes A Document To The Available Documentdb Cluster And Succeeds

  # Generated from FizzBee spec: lambda_docdb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentReferencesExistingCluster

  Background:
    Given the system is initialized

  @minimal @happy @write_document @internal
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given an invocation is "IN_PROGRESS"
    And the cluster is "AVAILABLE"
    And a document slot is available
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Then the document "EXISTS" and the invocation is "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @guard @negative @write_document @internal
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Then the operation is rejected

  @guard @negative @write_document @internal
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds fails when the cluster is not "AVAILABLE"
    Given an invocation is "IN_PROGRESS"
    And the cluster is not "AVAILABLE"
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Then the operation is rejected

  @guard @negative @write_document @internal
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds fails when no document slot is available
    Given an invocation is "IN_PROGRESS"
    And the cluster is "AVAILABLE"
    And no document slot is available
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Then the operation is rejected
