@stepfunctionss3api @generated
Feature: StepfunctionsS3api - A Running "Step Functions" "Execution" Fails To Read Because No Object Exists In The Bucket

  # Generated from FizzBee spec: stepfunctions_s3api.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ObjectRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @get_object_not_found_task
  Scenario: a running "step functions" "execution" fails to read because no object exists in the bucket
    Given a "step functions" "execution" was "RUNNING"
    And no object existed in the target bucket
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    Then the "step functions" "execution" will be "FAILED" with a NoSuchKey error
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @guard @negative @get_object_not_found_task
  Scenario: a running "step functions" "execution" fails to read because no object exists in the bucket fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    Then the operation is rejected

  @guard @negative @get_object_not_found_task
  Scenario: a running "step functions" "execution" fails to read because no object exists in the bucket fails when an object existed in the target bucket
    Given a "step functions" "execution" was "RUNNING"
    And an object existed in the target bucket
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    Then the operation is rejected
