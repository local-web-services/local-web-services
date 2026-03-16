@apigateways3api @generated
Feature: ApigatewayS3api - A Put Request Is Received And The Api Writes An Object To The S3 Bucket

  # Generated from FizzBee spec: apigateway_s3api.fizz
  # Safety invariants: ObjectReferencesExistingBucket, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @put_object_request_succeeds
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given the "API" is "ACTIVE"
    And the "API" has an S3 integration configured
    And the bucket is "ACTIVE"
    And a request slot is available
    And an object slot is available
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    Then the object "EXISTS" and the request is "SUCCESS"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @standard @negative @put_object_request_succeeds @lifecycle
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket fails when the "API" is not "ACTIVE"
    Given the "API" is not "ACTIVE"
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    Then the operation is rejected

  @standard @negative @put_object_request_succeeds
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket fails when the "API" has no S3 integration configured
    Given the "API" is "ACTIVE"
    And the "API" has no S3 integration configured
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    Then the operation is rejected

  @standard @negative @put_object_request_succeeds @lifecycle
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket fails when the bucket is not "ACTIVE"
    Given the "API" is "ACTIVE"
    And the "API" has an S3 integration configured
    And the bucket is not "ACTIVE"
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    Then the operation is rejected

  @standard @negative @put_object_request_succeeds @capacity
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket fails when no request slot is available
    Given the "API" is "ACTIVE"
    And the "API" has an S3 integration configured
    And the bucket is "ACTIVE"
    And no request slot is available
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    Then the operation is rejected

  @standard @negative @put_object_request_succeeds @capacity
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket fails when no object slot is available
    Given the "API" is "ACTIVE"
    And the "API" has an S3 integration configured
    And the bucket is "ACTIVE"
    And a request slot is available
    And no object slot is available
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    Then the operation is rejected
