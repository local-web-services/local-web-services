@lambdadocdb @generated
Feature: LambdaDocdb - The "Documentdb" "Cluster" Is Stopped

  # Generated from FizzBee spec: lambda_docdb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentReferencesExistingCluster

  Background:
    Given the system is initialized

  @minimal @happy @stop_cluster
  Scenario: the "documentdb" "cluster" is stopped
    Given the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was "AVAILABLE"
    When the "documentdb" "cluster" is stopped
    Then the "documentdb" "cluster" will be "STOPPED" and connections will be rejected
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "documentdb" "cluster" that exists

  @guard @negative @stop_cluster
  Scenario: the "documentdb" "cluster" is stopped fails when the "documentdb" "cluster" did not exist
    Given the "documentdb" "cluster" did not exist
    When the "documentdb" "cluster" is stopped
    Then the operation is rejected

  @guard @negative @stop_cluster @lifecycle
  Scenario: the "documentdb" "cluster" is stopped fails when the "documentdb" "cluster" was not "AVAILABLE"
    Given the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was not "AVAILABLE"
    When the "documentdb" "cluster" is stopped
    Then the operation is rejected
