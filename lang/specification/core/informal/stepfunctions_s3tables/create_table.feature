@stepfunctionss3tables @generated
Feature: StepfunctionsS3tables - A "S3 Tables" "Table" Is Created

  # Generated from FizzBee spec: stepfunctions_s3tables.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledATable

  Background:
    Given the system is initialized

  @minimal @happy @create_table
  Scenario: a "s3 tables" "table" is created
    Given the "s3 tables" "table" did not already exist
    When a "s3 tables" "table" is created
    Then the "s3 tables" "table" will be "ACTIVE"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @guard @negative @create_table
  Scenario: a "s3 tables" "table" is created fails when the "s3 tables" "table" already existed
    Given the "s3 tables" "table" already existed
    When a "s3 tables" "table" is created
    Then the operation is rejected
