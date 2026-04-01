@stepfunctionss3api @generated
Feature: StepfunctionsS3api - A S3 Task Is Configured On The State Machine

  # Generated from FizzBee spec: stepfunctions_s3api.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ObjectRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @configure_s3_task
  Scenario: a S3 task is configured on the state machine
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the state machine has no S3 task configured
    And the bucket existed
    And the bucket was "ACTIVE"
    When a S3 task is configured on the state machine
    Then the state machine will read or write objects to the bucket when it reaches the task state
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @guard @negative @configure_s3_task
  Scenario: a S3 task is configured on the state machine fails when the "step functions" "state machine" did not exist
    Given the "step functions" "state machine" did not exist
    When a S3 task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_s3_task @lifecycle
  Scenario: a S3 task is configured on the state machine fails when the "step functions" "state machine" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was not "ACTIVE"
    When a S3 task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_s3_task
  Scenario: a S3 task is configured on the state machine fails when the state machine already has a S3 task configured
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the state machine already has a S3 task configured
    When a S3 task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_s3_task
  Scenario: a S3 task is configured on the state machine fails when the bucket did not exist
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the state machine has no S3 task configured
    And the bucket did not exist
    When a S3 task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_s3_task @lifecycle
  Scenario: a S3 task is configured on the state machine fails when the bucket was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the state machine has no S3 task configured
    And the bucket existed
    And the bucket was not "ACTIVE"
    When a S3 task is configured on the state machine
    Then the operation is rejected
