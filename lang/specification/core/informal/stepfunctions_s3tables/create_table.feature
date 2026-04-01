@stepfunctionss3tables @generated
Feature: StepfunctionsS3tables - A S3 Tables Table Is Created

  # Generated from FizzBee spec: stepfunctions_s3tables.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledATable

  Background:
    Given the system is initialized

  @minimal @happy @create_table
  Scenario: a S3 Tables table is created
    Given the table did not already exist
    When a S3 Tables table is created
    Then the table will be "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @guard @negative @create_table
  Scenario: a S3 Tables table is created fails when the table already existed
    Given the table already existed
    When a S3 Tables table is created
    Then the operation is rejected
