@lambdadocdb @generated
Feature: LambdaDocdb - The "Lambda" "Function" Writes A Document To The "Documentdb" "Cluster" That Was "Available" And Succeeds

  # Generated from FizzBee spec: lambda_docdb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentReferencesExistingCluster

  Background:
    Given the system is initialized

  @minimal @happy @write_document @internal
  Scenario: the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "documentdb" "cluster" was "AVAILABLE"
    And a document slot is available
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    Then the document will exist and the invocation will be "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "documentdb" "cluster" that exists

  @guard @negative @write_document @internal
  Scenario: the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    Then the operation is rejected

  @guard @negative @write_document @internal
  Scenario: the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds fails when the "documentdb" "cluster" was not "AVAILABLE"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "documentdb" "cluster" was not "AVAILABLE"
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    Then the operation is rejected

  @guard @negative @write_document @internal
  Scenario: the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds fails when no document slot is available
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "documentdb" "cluster" was "AVAILABLE"
    And no document slot is available
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    Then the operation is rejected
