@apigateways3api @generated
Feature: ApigatewayS3api - A Get Request Is Received And The "Api Gateway" "Api" Retrieves An Existing Object From S3

  # Generated from FizzBee spec: apigateway_s3api.fizz
  # Safety invariants: ObjectReferencesExistingBucket, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @get_object_request_succeeds
  Scenario: a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a S3 integration configured
    And an "s3" "object" existed in the target bucket
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    Then the "api gateway" "request" will be "SUCCESS"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @guard @negative @get_object_request_succeeds @lifecycle
  Scenario: a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3 fails when the "api gateway" "api" was not "ACTIVE"
    Given the "api gateway" "api" was not "ACTIVE"
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    Then the operation is rejected

  @guard @negative @get_object_request_succeeds
  Scenario: a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3 fails when the "api gateway" "api" has no S3 integration configured
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has no S3 integration configured
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    Then the operation is rejected

  @guard @negative @get_object_request_succeeds @lifecycle
  Scenario: a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3 fails when no "s3" "object" existed in the target "s3" "bucket"
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a S3 integration configured
    And no "s3" "object" existed in the target "s3" "bucket"
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    Then the operation is rejected
