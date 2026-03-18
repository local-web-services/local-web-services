@lambdas3tables @generated
Feature: LambdaS3tables - A Table Is Created In The Table Bucket

  # Generated from FizzBee spec: lambda_s3tables.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingTable

  Background:
    Given the system is initialized

  @minimal @happy @create_table
  Scenario: a table is created in the table bucket
    Given the table does not already exist
    And the table bucket is "ACTIVE"
    When a table is created in the table bucket
    Then the table is "ACTIVE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @standard @negative @create_table
  Scenario: a table is created in the table bucket fails when the table already exists
    Given the table already exists
    When a table is created in the table bucket
    Then the operation is rejected

  @standard @negative @create_table @lifecycle @internal
  Scenario: a table is created in the table bucket fails when the table bucket is not "ACTIVE"
    Given the table does not already exist
    And the table bucket is not "ACTIVE"
    When a table is created in the table bucket
    Then the operation is rejected
