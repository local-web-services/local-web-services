@apigateways3api @generated
Feature: ApigatewayS3api - A Request Fails Because The "S3" "Bucket" Has Been Deleted

  # Generated from FizzBee spec: apigateway_s3api.fizz
  # Safety invariants: ObjectReferencesExistingBucket, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @request_fails
  Scenario: a request fails because the "s3" "bucket" has been deleted
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a S3 integration configured
    And the "s3" "bucket" was "DELETED"
    And a "request" "slot" was "available"
    When a request fails because the "s3" "bucket" has been deleted
    Then the "api gateway" "request" will be "FAILED" with a NoSuchBucket error
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @guard @negative @request_fails @lifecycle
  Scenario: a request fails because the "s3" "bucket" has been deleted fails when the "api gateway" "api" was not "ACTIVE"
    Given the "api gateway" "api" was not "ACTIVE"
    When a request fails because the "s3" "bucket" has been deleted
    Then the operation is rejected

  @guard @negative @request_fails
  Scenario: a request fails because the "s3" "bucket" has been deleted fails when the "api gateway" "api" has no S3 integration configured
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has no S3 integration configured
    When a request fails because the "s3" "bucket" has been deleted
    Then the operation is rejected

  @guard @negative @request_fails @lifecycle
  Scenario: a request fails because the "s3" "bucket" has been deleted fails when the "s3" "bucket" was not "DELETED"
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a S3 integration configured
    And the "s3" "bucket" was not "DELETED"
    When a request fails because the "s3" "bucket" has been deleted
    Then the operation is rejected

  @guard @negative @request_fails @capacity
  Scenario: a request fails because the "s3" "bucket" has been deleted fails when no "request" "slot" was "available"
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a S3 integration configured
    And the "s3" "bucket" was "DELETED"
    And no "request" "slot" was "available"
    When a request fails because the "s3" "bucket" has been deleted
    Then the operation is rejected
