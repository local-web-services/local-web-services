@stepfunctionss3api @generated
Feature: StepfunctionsS3api - A Running Execution Reads An Existing Object From The S3 Bucket And Succeeds

  # Generated from FizzBee spec: stepfunctions_s3api.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ObjectRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @get_object_task
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds
    Given an execution is "RUNNING"
    And an object "EXISTS" in the target bucket
    When a running execution reads an existing object from the S3 bucket and succeeds
    Then the execution is "SUCCEEDED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @standard @negative @get_object_task
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution reads an existing object from the S3 bucket and succeeds
    Then the operation is rejected

  @standard @negative @get_object_task
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds fails when no object "EXISTS" in the target bucket
    Given an execution is "RUNNING"
    And no object "EXISTS" in the target bucket
    When a running execution reads an existing object from the S3 bucket and succeeds
    Then the operation is rejected
