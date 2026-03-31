@apigateways3api @generated
Feature: ApigatewayS3api - A Put Request Is Received And The "Api Gateway" "Api" Writes An "S3" "Object" To The "S3" "Bucket"

  # Generated from FizzBee spec: apigateway_s3api.fizz
  # Safety invariants: ObjectReferencesExistingBucket, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @put_object_request_succeeds
  Scenario: a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a S3 integration configured
    And the "s3" "bucket" was "ACTIVE"
    And a request slot is available
    And an "s3" "object" slot is available
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    Then the "s3" "object" will exist and the request will be "SUCCESS"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @guard @negative @put_object_request_succeeds @lifecycle
  Scenario: a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" fails when the "api gateway" "api" was not "ACTIVE"
    Given the "api gateway" "api" was not "ACTIVE"
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    Then the operation is rejected

  @guard @negative @put_object_request_succeeds
  Scenario: a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" fails when the "api gateway" "api" has no S3 integration configured
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has no S3 integration configured
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    Then the operation is rejected

  @guard @negative @put_object_request_succeeds @lifecycle
  Scenario: a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" fails when the "s3" "bucket" was not "ACTIVE"
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a S3 integration configured
    And the "s3" "bucket" was not "ACTIVE"
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    Then the operation is rejected

  @guard @negative @put_object_request_succeeds @capacity
  Scenario: a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" fails when no request slot is available
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a S3 integration configured
    And the "s3" "bucket" was "ACTIVE"
    And no request slot is available
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    Then the operation is rejected

  @guard @negative @put_object_request_succeeds @capacity
  Scenario: a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" fails when no object slot is available
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a S3 integration configured
    And the "s3" "bucket" was "ACTIVE"
    And a request slot is available
    And no object slot is available
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    Then the operation is rejected
