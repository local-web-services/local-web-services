@stepfunctionss3tables @generated
Feature: StepfunctionsS3tables - A Running Execution Calls An Active S3 Tables Table And The Task Succeeds

  # Generated from FizzBee spec: stepfunctions_s3tables.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledATable

  Background:
    Given the system is initialized

  @minimal @happy @s3_tables_task_succeeds @internal
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Given an execution is "RUNNING"
    And the table is "ACTIVE"
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Then the execution is "SUCCEEDED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @guard @negative @s3_tables_task_succeeds @internal
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Then the operation is rejected

  @guard @negative @s3_tables_task_succeeds @internal
  Scenario: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds fails when the table does not exist or is "DELETING"
    Given an execution is "RUNNING"
    And the table does not exist or is "DELETING"
    When a running execution calls an "ACTIVE" S3 Tables table and the task succeeds
    Then the operation is rejected
