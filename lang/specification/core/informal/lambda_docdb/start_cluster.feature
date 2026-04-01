@lambdadocdb @generated
Feature: LambdaDocdb - The "Documentdb" "Cluster" Is Started

  # Generated from FizzBee spec: lambda_docdb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentReferencesExistingCluster

  Background:
    Given the system is initialized

  @minimal @happy @start_cluster
  Scenario: the "documentdb" "cluster" is started
    Given the "documentdb" "cluster" was "STOPPED"
    When the "documentdb" "cluster" is started
    Then the "documentdb" "cluster" will be "AVAILABLE" and ready to accept connections
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "documentdb" "cluster" that exists

  @guard @negative @start_cluster @lifecycle
  Scenario: the "documentdb" "cluster" is started fails when the "documentdb" "cluster" was not "STOPPED"
    Given the "documentdb" "cluster" was not "STOPPED"
    When the "documentdb" "cluster" is started
    Then the operation is rejected
