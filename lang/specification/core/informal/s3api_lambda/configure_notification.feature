@s3apilambda @generated
Feature: S3apiLambda - A S3 Event Notification Is Configured To Invoke A "Lambda" "Function" On Object Put

  # Generated from FizzBee spec: s3api_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @configure_notification
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Given the bucket existed
    And the bucket was "ACTIVE"
    And the bucket has no notification configured
    And the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Then the bucket will asynchronously invoke the function when an object is put
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @guard @negative @configure_notification
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" fails when the bucket did not exist
    Given the bucket did not exist
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Then the operation is rejected

  @guard @negative @configure_notification @lifecycle
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" fails when the bucket was not "ACTIVE"
    Given the bucket existed
    And the bucket was not "ACTIVE"
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Then the operation is rejected

  @guard @negative @configure_notification
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" fails when the bucket already has a notification configured
    Given the bucket existed
    And the bucket was "ACTIVE"
    And the bucket already has a notification configured
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Then the operation is rejected

  @guard @negative @configure_notification
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" fails when the "lambda" "function" did not exist
    Given the bucket existed
    And the bucket was "ACTIVE"
    And the bucket has no notification configured
    And the "lambda" "function" did not exist
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Then the operation is rejected

  @guard @negative @configure_notification @lifecycle
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" fails when the "lambda" "function" was not "ACTIVE"
    Given the bucket existed
    And the bucket was "ACTIVE"
    And the bucket has no notification configured
    And the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Then the operation is rejected
