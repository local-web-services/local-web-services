@s3apilambda @generated
Feature: S3apiLambda - An "S3" "Object" Is Put Into The "S3" "Bucket" And Asynchronously Invokes The Configured "Lambda" "Function"

  # Generated from FizzBee spec: s3api_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @put_object_and_notify
  Scenario: an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has a notification configured
    And the notification target "lambda" "function" was "ACTIVE"
    And a "s3" "object" "slot" was "available"
    And a "lambda" "invocation" "slot" was "available"
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    Then the "s3" "object" will exist in the "s3" "bucket" and a "lambda" "invocation" will be "IN_PROGRESS"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @guard @negative @put_object_and_notify
  Scenario: an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function" fails when the "s3" "bucket" did not exist
    Given the "s3" "bucket" did not exist
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    Then the operation is rejected

  @guard @negative @put_object_and_notify @lifecycle
  Scenario: an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function" fails when the "s3" "bucket" was not "ACTIVE"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was not "ACTIVE"
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    Then the operation is rejected

  @guard @negative @put_object_and_notify
  Scenario: an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function" fails when the "s3" "bucket" has no notification configured
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has no notification configured
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    Then the operation is rejected

  @guard @negative @put_object_and_notify @lifecycle
  Scenario: an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function" fails when the notification target "lambda" "function" was not "ACTIVE"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has a notification configured
    And the notification target "lambda" "function" was not "ACTIVE"
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    Then the operation is rejected

  @guard @negative @put_object_and_notify @capacity
  Scenario: an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function" fails when no "s3" "object" "slot" was "available"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has a notification configured
    And the notification target "lambda" "function" was "ACTIVE"
    And no "s3" "object" "slot" was "available"
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    Then the operation is rejected

  @guard @negative @put_object_and_notify @capacity
  Scenario: an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function" fails when no "lambda" "invocation" "slot" was "available"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has a notification configured
    And the notification target "lambda" "function" was "ACTIVE"
    And a "s3" "object" "slot" was "available"
    And no "lambda" "invocation" "slot" was "available"
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    Then the operation is rejected
