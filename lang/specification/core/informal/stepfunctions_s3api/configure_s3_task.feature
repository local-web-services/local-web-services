@stepfunctionss3api @generated
Feature: StepfunctionsS3api - An "S3" Task Is Configured On The "Step Functions" "State Machine"

  # Generated from FizzBee spec: stepfunctions_s3api.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ObjectRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @configure_s3_task
  Scenario: an "s3" task is configured on the "step functions" "state machine"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" has no "s3" task configured
    And the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    When an "s3" task is configured on the "step functions" "state machine"
    Then the "step functions" "state machine" will read or write "s3" "objects" to the "s3" "bucket" when it reaches the task state
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every existing "s3" "object" belongs to an "ACTIVE" "s3" "bucket"

  @guard @negative @configure_s3_task
  Scenario: an "s3" task is configured on the "step functions" "state machine" fails when the "step functions" "state machine" did not exist
    Given the "step functions" "state machine" did not exist
    When an "s3" task is configured on the "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @configure_s3_task @lifecycle
  Scenario: an "s3" task is configured on the "step functions" "state machine" fails when the "step functions" "state machine" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was not "ACTIVE"
    When an "s3" task is configured on the "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @configure_s3_task
  Scenario: an "s3" task is configured on the "step functions" "state machine" fails when the "step functions" "state machine" already has an "s3" task configured
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" already has an "s3" task configured
    When an "s3" task is configured on the "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @configure_s3_task
  Scenario: an "s3" task is configured on the "step functions" "state machine" fails when the "s3" "bucket" did not exist
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" has no "s3" task configured
    And the "s3" "bucket" did not exist
    When an "s3" task is configured on the "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @configure_s3_task @lifecycle
  Scenario: an "s3" task is configured on the "step functions" "state machine" fails when the "s3" "bucket" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" has no "s3" task configured
    And the "s3" "bucket" existed
    And the "s3" "bucket" was not "ACTIVE"
    When an "s3" task is configured on the "step functions" "state machine"
    Then the operation is rejected
