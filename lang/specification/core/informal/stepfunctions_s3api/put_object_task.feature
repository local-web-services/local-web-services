@stepfunctionss3api @generated
Feature: StepfunctionsS3api - A Running "Step Functions" "Execution" Writes An Object To The "S3" "Bucket" And Succeeds

  # Generated from FizzBee spec: stepfunctions_s3api.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ObjectRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @put_object_task
  Scenario: a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    Given a "step functions" "execution" was "RUNNING"
    And the target "s3" "bucket" was "ACTIVE"
    And a "s3" "object" "slot" was "available"
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    Then the "s3" "object" will exist in the "s3" "bucket" and the "step functions" "execution" will be "SUCCEEDED"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "s3" "object" belongs to an "ACTIVE" "s3" "bucket"

  @guard @negative @put_object_task
  Scenario: a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    Then the operation is rejected

  @guard @negative @put_object_task @lifecycle
  Scenario: a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds fails when the target "s3" "bucket" was not "ACTIVE"
    Given a "step functions" "execution" was "RUNNING"
    And the target "s3" "bucket" was not "ACTIVE"
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    Then the operation is rejected

  @guard @negative @put_object_task @capacity
  Scenario: a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds fails when no "s3" "object" "slot" was "available"
    Given a "step functions" "execution" was "RUNNING"
    And the target "s3" "bucket" was "ACTIVE"
    And no "s3" "object" "slot" was "available"
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    Then the operation is rejected
