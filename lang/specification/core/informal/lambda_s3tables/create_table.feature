@lambdas3tables @generated
Feature: LambdaS3tables - A Table Is Created In The Table Bucket

  # Generated from FizzBee spec: lambda_s3tables.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingTable

  Background:
    Given the system is initialized

  @minimal @happy @create_table
  Scenario: a table is created in the table bucket
    Given the table did not already exist
    And the table bucket was "ACTIVE"
    When a table is created in the table bucket
    Then the table will be "ACTIVE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @guard @negative @create_table
  Scenario: a table is created in the table bucket fails when the table already existed
    Given the table already existed
    When a table is created in the table bucket
    Then the operation is rejected

  @guard @negative @create_table @lifecycle
  Scenario: a table is created in the table bucket fails when the table bucket was not "ACTIVE"
    Given the table did not already exist
    And the table bucket was not "ACTIVE"
    When a table is created in the table bucket
    Then the operation is rejected
