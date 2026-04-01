@stepfunctionss3api @generated
Feature: StepfunctionsS3api - A "S3" "Bucket" Is Created

  # Generated from FizzBee spec: stepfunctions_s3api.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ObjectRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @create_bucket
  Scenario: a "s3" "bucket" is created
    Given the bucket did not already exist
    When a "s3" "bucket" is created
    Then the bucket will be "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @guard @negative @create_bucket
  Scenario: a "s3" "bucket" is created fails when the bucket already existed
    Given the bucket already existed
    When a "s3" "bucket" is created
    Then the operation is rejected
