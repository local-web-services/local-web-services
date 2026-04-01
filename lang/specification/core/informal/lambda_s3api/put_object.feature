@lambdas3api @generated
Feature: LambdaS3api - The "Lambda" "Function" Writes An "S3" "Object" To The "S3" "Bucket" During Invocation

  # Generated from FizzBee spec: lambda_s3api.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ObjectRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @put_object
  Scenario: the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And an "s3" "object" slot is available
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    Then the object will exist in the "s3" "bucket"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3" "object" belongs to an "ACTIVE" "s3" "bucket"

  @guard @negative @put_object @lifecycle
  Scenario: the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    Then the operation is rejected

  @guard @negative @put_object
  Scenario: the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation fails when the "s3" "bucket" did not exist
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "s3" "bucket" did not exist
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    Then the operation is rejected

  @guard @negative @put_object @lifecycle
  Scenario: the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation fails when the "s3" "bucket" was not "ACTIVE"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "s3" "bucket" existed
    And the "s3" "bucket" was not "ACTIVE"
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    Then the operation is rejected

  @guard @negative @put_object @capacity
  Scenario: the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation fails when no "s3" "object" "slot" was "available"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And no "s3" "object" "slot" was "available"
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    Then the operation is rejected
