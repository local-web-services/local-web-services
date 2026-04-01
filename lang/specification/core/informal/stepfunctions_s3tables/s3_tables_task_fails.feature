@stepfunctionss3tables @generated
Feature: StepfunctionsS3tables - A Running "Step Functions" "Execution" Fails Because The S3 Tables Table Is Being Deleted

  # Generated from FizzBee spec: stepfunctions_s3tables.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledATable

  Background:
    Given the system is initialized

  @minimal @happy @s3_tables_task_fails @internal
  Scenario: a running "step functions" "execution" fails because the S3 Tables table is being deleted
    Given a "step functions" "execution" was "RUNNING"
    And the "s3 tables" "table" was "DELETING"
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    Then the "step functions" "execution" will be "FAILED" with a ResourceNotFoundException
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "s3 tables" "table" it called

  @guard @negative @s3_tables_task_fails @internal
  Scenario: a running "step functions" "execution" fails because the S3 Tables table is being deleted fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    Then the operation is rejected

  @guard @negative @s3_tables_task_fails @internal
  Scenario: a running "step functions" "execution" fails because the S3 Tables table is being deleted fails when the "s3 tables" "table" was not "DELETING"
    Given a "step functions" "execution" was "RUNNING"
    And the "s3 tables" "table" was not "DELETING"
    When a running "step functions" "execution" fails because the S3 Tables table is being deleted
    Then the operation is rejected
