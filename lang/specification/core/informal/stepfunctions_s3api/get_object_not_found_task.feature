@stepfunctionss3api @generated
Feature: StepfunctionsS3api - A Running "Step Functions" "Execution" Fails To Read Because No Object Exists In The Bucket

  # Generated from FizzBee spec: stepfunctions_s3api.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ObjectRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @get_object_not_found_task
  Scenario: a running "step functions" "execution" fails to read because no object exists in the bucket
    Given a "step functions" "execution" was "RUNNING"
    And no "s3" "object" existed in the target "s3" "bucket"
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    Then the "step functions" "execution" will be "FAILED" with a NoSuchKey error
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "s3" "object" belongs to an "ACTIVE" "s3" "bucket"

  @guard @negative @get_object_not_found_task
  Scenario: a running "step functions" "execution" fails to read because no object exists in the bucket fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    Then the operation is rejected

  @guard @negative @get_object_not_found_task
  Scenario: a running "step functions" "execution" fails to read because no object exists in the bucket fails when an "s3" "object" existed in the target "s3" "bucket"
    Given a "step functions" "execution" was "RUNNING"
    And an "s3" "object" existed in the target "s3" "bucket"
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    Then the operation is rejected
