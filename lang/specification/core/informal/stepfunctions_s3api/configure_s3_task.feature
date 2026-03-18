@stepfunctionss3api @generated
Feature: StepfunctionsS3api - An S3 Task Is Configured On The State Machine

  # Generated from FizzBee spec: stepfunctions_s3api.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ObjectRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @configure_s3_task
  Scenario: an S3 task is configured on the state machine
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine has no S3 task configured
    And the bucket exists
    And the bucket is "ACTIVE"
    When an S3 task is configured on the state machine
    Then the state machine will read or write objects to the bucket when it reaches the task state
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @standard @negative @configure_s3_task
  Scenario: an S3 task is configured on the state machine fails when the state machine does not exist
    Given the state machine does not exist
    When an S3 task is configured on the state machine
    Then the operation is rejected

  @standard @negative @configure_s3_task @lifecycle @internal
  Scenario: an S3 task is configured on the state machine fails when the state machine is not "ACTIVE"
    Given the state machine exists
    And the state machine is not "ACTIVE"
    When an S3 task is configured on the state machine
    Then the operation is rejected

  @standard @negative @configure_s3_task
  Scenario: an S3 task is configured on the state machine fails when the state machine already has an S3 task configured
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine already has an S3 task configured
    When an S3 task is configured on the state machine
    Then the operation is rejected

  @standard @negative @configure_s3_task
  Scenario: an S3 task is configured on the state machine fails when the bucket does not exist
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine has no S3 task configured
    And the bucket does not exist
    When an S3 task is configured on the state machine
    Then the operation is rejected

  @standard @negative @configure_s3_task @lifecycle @internal
  Scenario: an S3 task is configured on the state machine fails when the bucket is not "ACTIVE"
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine has no S3 task configured
    And the bucket exists
    And the bucket is not "ACTIVE"
    When an S3 task is configured on the state machine
    Then the operation is rejected
