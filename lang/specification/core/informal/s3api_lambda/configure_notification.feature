@s3apilambda @generated
Feature: S3apiLambda - A S3 Event Notification Is Configured To Invoke A "Lambda" "Function" On Object Put

  # Generated from FizzBee spec: s3api_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @configure_notification
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has no notification configured
    And the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Then the "s3" "bucket" will asynchronously invoke the "lambda" "function" when an "s3" "object" is put
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @guard @negative @configure_notification
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" fails when the "s3" "bucket" did not exist
    Given the "s3" "bucket" did not exist
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Then the operation is rejected

  @guard @negative @configure_notification @lifecycle
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" fails when the "s3" "bucket" was not "ACTIVE"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was not "ACTIVE"
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Then the operation is rejected

  @guard @negative @configure_notification
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" fails when the "s3" "bucket" already has a notification configured
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" already has a notification configured
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Then the operation is rejected

  @guard @negative @configure_notification
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" fails when the "lambda" "function" did not exist
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has no notification configured
    And the "lambda" "function" did not exist
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Then the operation is rejected

  @guard @negative @configure_notification @lifecycle
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" fails when the "lambda" "function" was not "ACTIVE"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has no notification configured
    And the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Then the operation is rejected
