@apigateways3api @generated
Feature: ApigatewayS3api - An S3 Bucket Is Created

  # Generated from FizzBee spec: apigateway_s3api.fizz
  # Safety invariants: ObjectReferencesExistingBucket, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @create_bucket
  Scenario: an S3 bucket is created
    Given the bucket does not already exist
    When an S3 bucket is created
    Then the bucket is "ACTIVE"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @standard @negative @create_bucket
  Scenario: an S3 bucket is created fails when the bucket already exists
    Given the bucket already exists
    When an S3 bucket is created
    Then the operation is rejected
