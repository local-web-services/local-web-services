@s3apilambda @generated
Feature: S3apiLambda - An Object Is Put Into The Bucket And Asynchronously Invokes The Configured Lambda Function

  # Generated from FizzBee spec: s3api_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @put_object_and_notify
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given the bucket existed
    And the bucket was "ACTIVE"
    And the bucket has a notification configured
    And the notification target function was "ACTIVE"
    And an object slot is available
    And a "lambda" "invocation" slot is available
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    Then the object will exist in the bucket and an invocation will be "IN_PROGRESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @guard @negative @put_object_and_notify
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function fails when the bucket did not exist
    Given the bucket did not exist
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    Then the operation is rejected

  @guard @negative @put_object_and_notify @lifecycle
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function fails when the bucket was not "ACTIVE"
    Given the bucket existed
    And the bucket was not "ACTIVE"
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    Then the operation is rejected

  @guard @negative @put_object_and_notify
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function fails when the bucket has no notification configured
    Given the bucket existed
    And the bucket was "ACTIVE"
    And the bucket has no notification configured
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    Then the operation is rejected

  @guard @negative @put_object_and_notify @lifecycle
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function fails when the notification target function was not "ACTIVE"
    Given the bucket existed
    And the bucket was "ACTIVE"
    And the bucket has a notification configured
    And the notification target function was not "ACTIVE"
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    Then the operation is rejected

  @guard @negative @put_object_and_notify @capacity
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function fails when no object slot is available
    Given the bucket existed
    And the bucket was "ACTIVE"
    And the bucket has a notification configured
    And the notification target function was "ACTIVE"
    And no object slot is available
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    Then the operation is rejected

  @guard @negative @put_object_and_notify @capacity
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function fails when no invocation slot is available
    Given the bucket existed
    And the bucket was "ACTIVE"
    And the bucket has a notification configured
    And the notification target function was "ACTIVE"
    And an object slot is available
    And no invocation slot is available
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    Then the operation is rejected
