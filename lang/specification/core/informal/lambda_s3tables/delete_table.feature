@lambdas3tables @generated
Feature: LambdaS3tables - A Table Deletion Is Initiated

  # Generated from FizzBee spec: lambda_s3tables.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingTable

  Background:
    Given the system is initialized

  @minimal @happy @delete_table
  Scenario: a table deletion is initiated
    Given the table existed
    And the table was "ACTIVE"
    When a table deletion is initiated
    Then the table will be "DELETING" and write operations will fail
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @guard @negative @delete_table
  Scenario: a table deletion is initiated fails when the table did not exist
    Given the table did not exist
    When a table deletion is initiated
    Then the operation is rejected

  @guard @negative @delete_table @lifecycle
  Scenario: a table deletion is initiated fails when the table is already "DELETING"
    Given the table existed
    And the table is already "DELETING"
    When a table deletion is initiated
    Then the operation is rejected
