@apigateways3api @generated
Feature: ApigatewayS3api - A Request Fails Because The S3 Bucket Has Been Deleted

  # Generated from FizzBee spec: apigateway_s3api.fizz
  # Safety invariants: ObjectReferencesExistingBucket, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @request_fails
  Scenario: a request fails because the S3 bucket has been deleted
    Given the "API" is "ACTIVE"
    And the "API" has an S3 integration configured
    And the bucket is "DELETED"
    And a request slot is available
    When a request fails because the S3 bucket has been deleted
    Then the request is "FAILED" with a NoSuchBucket error
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @standard @negative @request_fails @lifecycle @internal
  Scenario: a request fails because the S3 bucket has been deleted fails when the "API" is not "ACTIVE"
    Given the "API" is not "ACTIVE"
    When a request fails because the S3 bucket has been deleted
    Then the operation is rejected

  @standard @negative @request_fails
  Scenario: a request fails because the S3 bucket has been deleted fails when the "API" has no S3 integration configured
    Given the "API" is "ACTIVE"
    And the "API" has no S3 integration configured
    When a request fails because the S3 bucket has been deleted
    Then the operation is rejected

  @standard @negative @request_fails @lifecycle @internal
  Scenario: a request fails because the S3 bucket has been deleted fails when the bucket is not "DELETED"
    Given the "API" is "ACTIVE"
    And the "API" has an S3 integration configured
    And the bucket is not "DELETED"
    When a request fails because the S3 bucket has been deleted
    Then the operation is rejected

  @standard @negative @request_fails @capacity @internal
  Scenario: a request fails because the S3 bucket has been deleted fails when no request slot is available
    Given the "API" is "ACTIVE"
    And the "API" has an S3 integration configured
    And the bucket is "DELETED"
    And no request slot is available
    When a request fails because the S3 bucket has been deleted
    Then the operation is rejected
