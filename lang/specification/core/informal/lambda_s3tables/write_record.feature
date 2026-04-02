@lambdas3tables @generated
Feature: LambdaS3tables - The "Lambda" "Function" Writes A Record To An Active Table And Succeeds

  # Generated from FizzBee spec: lambda_s3tables.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingTable

  Background:
    Given the system is initialized

  @minimal @happy @write_record @internal
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And a "s3 tables" "table" was "ACTIVE"
    And a "s3 tables" "record" "slot" was "available"
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Then the "s3 tables" "record" will exist and the "lambda" "invocation" will be "SUCCESS"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @guard @negative @write_record @internal
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Then the operation is rejected

  @guard @negative @write_record @internal
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds fails when no "s3 tables" "table" was "ACTIVE"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And no "s3 tables" "table" was "ACTIVE"
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Then the operation is rejected

  @guard @negative @write_record @internal
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds fails when no "s3 tables" "record" "slot" was "available"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And a "s3 tables" "table" was "ACTIVE"
    And no "s3 tables" "record" "slot" was "available"
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Then the operation is rejected
