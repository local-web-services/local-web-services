@stepfunctionss3tables @generated
Feature: StepfunctionsS3tables - A Table Deletion Is Initiated

  # Generated from FizzBee spec: stepfunctions_s3tables.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledATable

  Background:
    Given the system is initialized

  @minimal @happy @delete_table
  Scenario: a table deletion is initiated
    Given the table exists
    And the table is "ACTIVE"
    When a table deletion is initiated
    Then the table is "DELETING" and "SDK" task calls targeting it will fail
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @standard @negative @delete_table
  Scenario: a table deletion is initiated fails when the table does not exist
    Given the table does not exist
    When a table deletion is initiated
    Then the operation is rejected

  @standard @negative @delete_table @lifecycle
  Scenario: a table deletion is initiated fails when the table is already "DELETING"
    Given the table exists
    And the table is already "DELETING"
    When a table deletion is initiated
    Then the operation is rejected
