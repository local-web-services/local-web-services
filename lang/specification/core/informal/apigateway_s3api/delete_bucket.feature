@apigateways3api @generated
Feature: ApigatewayS3api - The S3 Bucket Is Deleted

  # Generated from FizzBee spec: apigateway_s3api.fizz
  # Safety invariants: ObjectReferencesExistingBucket, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @delete_bucket
  Scenario: the S3 bucket is deleted
    Given the bucket exists
    And the bucket is "ACTIVE"
    When the S3 bucket is deleted
    Then the bucket is "DELETED" and "API" requests targeting it will fail
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @standard @negative @delete_bucket
  Scenario: the S3 bucket is deleted fails when the bucket does not exist
    Given the bucket does not exist
    When the S3 bucket is deleted
    Then the operation is rejected

  @standard @negative @delete_bucket @lifecycle
  Scenario: the S3 bucket is deleted fails when the bucket is already "DELETED"
    Given the bucket exists
    And the bucket is already "DELETED"
    When the S3 bucket is deleted
    Then the operation is rejected
