@lambdas3tables @generated
Feature: LambdaS3tables - The "Lambda" "Function" Writes A Record To An Active Table And Succeeds

  # Generated from FizzBee spec: lambda_s3tables.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingTable

  Background:
    Given the system is initialized

  @minimal @happy @write_record @internal
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And a table was "ACTIVE"
    And a record slot is available
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Then the record will exist and the invocation will be "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @guard @negative @write_record @internal
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Then the operation is rejected

  @guard @negative @write_record @internal
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds fails when no table was "ACTIVE"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And no table was "ACTIVE"
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Then the operation is rejected

  @guard @negative @write_record @internal
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds fails when no record slot is available
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And a table was "ACTIVE"
    And no record slot is available
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Then the operation is rejected
