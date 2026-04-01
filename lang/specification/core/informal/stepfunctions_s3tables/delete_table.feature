@stepfunctionss3tables @generated
Feature: StepfunctionsS3tables - A "S3 Tables" "Table" Deletion Is Initiated

  # Generated from FizzBee spec: stepfunctions_s3tables.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledATable

  Background:
    Given the system is initialized

  @minimal @happy @delete_table
  Scenario: a "s3 tables" "table" deletion is initiated
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was "ACTIVE"
    When a "s3 tables" "table" deletion is initiated
    Then the "s3 tables" "table" will be "DELETING" and "SDK" task calls targeting it will fail
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @guard @negative @delete_table
  Scenario: a "s3 tables" "table" deletion is initiated fails when the "s3 tables" "table" did not exist
    Given the "s3 tables" "table" did not exist
    When a "s3 tables" "table" deletion is initiated
    Then the operation is rejected

  @guard @negative @delete_table @lifecycle
  Scenario: a "s3 tables" "table" deletion is initiated fails when the "s3 tables" "table" is already "DELETING"
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" is already "DELETING"
    When a "s3 tables" "table" deletion is initiated
    Then the operation is rejected
