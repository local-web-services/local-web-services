@lambdas3tables @generated
Feature: LambdaS3tables - The Lambda Function Writes A Record To An Active Table And Succeeds

  # Generated from FizzBee spec: lambda_s3tables.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingTable

  Background:
    Given the system is initialized

  @minimal @happy @write_record @internal
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given an invocation is "IN_PROGRESS"
    And a table is "ACTIVE"
    And a record slot is available
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    Then the record "EXISTS" and the invocation is "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @guard @negative @write_record @internal
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    Then the operation is rejected

  @guard @negative @write_record @internal
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds fails when no table is "ACTIVE"
    Given an invocation is "IN_PROGRESS"
    And no table is "ACTIVE"
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    Then the operation is rejected

  @guard @negative @write_record @internal
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds fails when no record slot is available
    Given an invocation is "IN_PROGRESS"
    And a table is "ACTIVE"
    And no record slot is available
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    Then the operation is rejected
