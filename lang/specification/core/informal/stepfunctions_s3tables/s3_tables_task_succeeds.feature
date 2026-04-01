@stepfunctionss3tables @generated
Feature: StepfunctionsS3tables - A Running "Step Functions" "Execution" Calls An Active S3 Tables Table And The Task Succeeds

  # Generated from FizzBee spec: stepfunctions_s3tables.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledATable

  Background:
    Given the system is initialized

  @minimal @happy @s3_tables_task_succeeds @internal
  Scenario: a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    Given a "step functions" "execution" was "RUNNING"
    And the table was "ACTIVE"
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    Then the "step functions" "execution" will be "SUCCEEDED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which table it called

  @guard @negative @s3_tables_task_succeeds @internal
  Scenario: a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    Then the operation is rejected

  @guard @negative @s3_tables_task_succeeds @internal
  Scenario: a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds fails when the table did not exist or was "DELETING"
    Given a "step functions" "execution" was "RUNNING"
    And the table did not exist or was "DELETING"
    When a running "step functions" "execution" calls an "ACTIVE" S3 Tables table and the task succeeds
    Then the operation is rejected
