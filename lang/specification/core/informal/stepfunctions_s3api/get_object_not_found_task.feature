@stepfunctionss3api @generated
Feature: StepfunctionsS3api - A Running Execution Fails To Read Because No Object Exists In The Bucket

  # Generated from FizzBee spec: stepfunctions_s3api.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ObjectRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @get_object_not_found_task
  Scenario: a running execution fails to read because no object exists in the bucket
    Given an execution is "RUNNING"
    And no object "EXISTS" in the target bucket
    When a running execution fails to read because no object exists in the bucket
    Then the execution is "FAILED" with a NoSuchKey error
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @guard @negative @get_object_not_found_task
  Scenario: a running execution fails to read because no object exists in the bucket fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution fails to read because no object exists in the bucket
    Then the operation is rejected

  @guard @negative @get_object_not_found_task
  Scenario: a running execution fails to read because no object exists in the bucket fails when an object "EXISTS" in the target bucket
    Given an execution is "RUNNING"
    And an object "EXISTS" in the target bucket
    When a running execution fails to read because no object exists in the bucket
    Then the operation is rejected
