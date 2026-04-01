@lambdadocdb @generated
Feature: LambdaDocdb - A "Documentdb" "Cluster" Is Created

  # Generated from FizzBee spec: lambda_docdb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentReferencesExistingCluster

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: a "documentdb" "cluster" is created
    Given the "documentdb" "cluster" did not already exist
    When a "documentdb" "cluster" is created
    Then the "documentdb" "cluster" will be "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "documentdb" "cluster" that exists

  @guard @negative @create_cluster
  Scenario: a "documentdb" "cluster" is created fails when the "documentdb" "cluster" already existed
    Given the "documentdb" "cluster" already existed
    When a "documentdb" "cluster" is created
    Then the operation is rejected
