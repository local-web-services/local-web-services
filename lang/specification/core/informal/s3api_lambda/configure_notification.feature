@s3apilambda @generated
Feature: S3apiLambda - An S3 Event Notification Is Configured To Invoke A Lambda Function On Object Put

  # Generated from FizzBee spec: s3api_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @configure_notification
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the bucket has no notification configured
    And the function exists
    And the function is "ACTIVE"
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Then the bucket will asynchronously invoke the function when an object is put
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @standard @negative @configure_notification
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" fails when the bucket does not exist
    Given the bucket does not exist
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Then the operation is rejected

  @standard @negative @configure_notification @lifecycle @internal
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" fails when the bucket is not "ACTIVE"
    Given the bucket exists
    And the bucket is not "ACTIVE"
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Then the operation is rejected

  @standard @negative @configure_notification
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" fails when the bucket already has a notification configured
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the bucket already has a notification configured
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Then the operation is rejected

  @standard @negative @configure_notification
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" fails when the function does not exist
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the bucket has no notification configured
    And the function does not exist
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Then the operation is rejected

  @standard @negative @configure_notification @lifecycle @internal
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" fails when the function is not "ACTIVE"
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the bucket has no notification configured
    And the function exists
    And the function is not "ACTIVE"
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Then the operation is rejected
