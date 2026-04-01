@stepfunctionss3api @generated
Feature: StepfunctionsS3api - A Running "Step Functions" "Execution" Reads An Existing Object From The "S3" "Bucket" And Succeeds

  # Generated from FizzBee spec: stepfunctions_s3api.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ObjectRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @get_object_task
  Scenario: a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    Given a "step functions" "execution" was "RUNNING"
    And an "s3" "object" existed in the target "s3" "bucket"
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    Then the "step functions" "execution" will be "SUCCEEDED"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "s3" "object" belongs to an "ACTIVE" "s3" "bucket"

  @guard @negative @get_object_task
  Scenario: a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    Then the operation is rejected

  @guard @negative @get_object_task
  Scenario: a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds fails when no "s3" "object" existed in the target "s3" "bucket"
    Given a "step functions" "execution" was "RUNNING"
    And no "s3" "object" existed in the target "s3" "bucket"
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    Then the operation is rejected
