@stepfunctionss3api @generated
Feature: StepfunctionsS3api - A Running Execution Writes An Object To The S3 Bucket And Succeeds

  # Generated from FizzBee spec: stepfunctions_s3api.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ObjectRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @put_object_task
  Scenario: a running execution writes an object to the S3 bucket and succeeds
    Given an execution is "RUNNING"
    And the target bucket is "ACTIVE"
    And an object slot is available
    When a running execution writes an object to the S3 bucket and succeeds
    Then the object "EXISTS" in the bucket and the execution is "SUCCEEDED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @standard @negative @put_object_task
  Scenario: a running execution writes an object to the S3 bucket and succeeds fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution writes an object to the S3 bucket and succeeds
    Then the operation is rejected

  @standard @negative @put_object_task @lifecycle @internal
  Scenario: a running execution writes an object to the S3 bucket and succeeds fails when the target bucket is not "ACTIVE"
    Given an execution is "RUNNING"
    And the target bucket is not "ACTIVE"
    When a running execution writes an object to the S3 bucket and succeeds
    Then the operation is rejected

  @standard @negative @put_object_task @capacity @internal
  Scenario: a running execution writes an object to the S3 bucket and succeeds fails when no object slot is available
    Given an execution is "RUNNING"
    And the target bucket is "ACTIVE"
    And no object slot is available
    When a running execution writes an object to the S3 bucket and succeeds
    Then the operation is rejected
