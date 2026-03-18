@stepfunctionss3tables @generated
Feature: StepfunctionsS3tables - An S3 Tables Table Is Created

  # Generated from FizzBee spec: stepfunctions_s3tables.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledATable

  Background:
    Given the system is initialized

  @minimal @happy @create_table
  Scenario: an S3 Tables table is created
    Given the table does not already exist
    When an S3 Tables table is created
    Then the table is "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @standard @negative @create_table
  Scenario: an S3 Tables table is created fails when the table already exists
    Given the table already exists
    When an S3 Tables table is created
    Then the operation is rejected
