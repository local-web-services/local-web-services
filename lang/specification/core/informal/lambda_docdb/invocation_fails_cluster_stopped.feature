@lambdadocdb @generated
Feature: LambdaDocdb - The "Lambda" "Function" Fails To Connect Because The "Documentdb" "Cluster" Is Stopped

  # Generated from FizzBee spec: lambda_docdb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentReferencesExistingCluster

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_cluster_stopped
  Scenario: the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "documentdb" "cluster" was "STOPPED"
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    Then the "lambda" "invocation" will be "FAILED" with a connection error
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @guard @negative @invocation_fails_cluster_stopped @lifecycle
  Scenario: the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    Then the operation is rejected

  @guard @negative @invocation_fails_cluster_stopped @lifecycle
  Scenario: the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped fails when the "documentdb" "cluster" was not "STOPPED"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "documentdb" "cluster" was not "STOPPED"
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    Then the operation is rejected
