@stepfunctionss3tables @generated
Feature: StepfunctionsS3tables - A Running Execution Fails Because The S3 Tables Table Is Being Deleted

  # Generated from FizzBee spec: stepfunctions_s3tables.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledATable

  Background:
    Given the system is initialized

  @minimal @happy @s3_tables_task_fails @internal
  Scenario: a running execution fails because the S3 Tables table is being deleted
    Given an execution is "RUNNING"
    And the table is "DELETING"
    When a running execution fails because the S3 Tables table is being deleted
    Then the execution is "FAILED" with a ResourceNotFoundException
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @guard @negative @s3_tables_task_fails @internal
  Scenario: a running execution fails because the S3 Tables table is being deleted fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution fails because the S3 Tables table is being deleted
    Then the operation is rejected

  @guard @negative @s3_tables_task_fails @internal
  Scenario: a running execution fails because the S3 Tables table is being deleted fails when the table is not "DELETING"
    Given an execution is "RUNNING"
    And the table is not "DELETING"
    When a running execution fails because the S3 Tables table is being deleted
    Then the operation is rejected
