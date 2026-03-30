@apigateways3api @generated
Feature: ApigatewayS3api - A Get Request Is Received And The Api Retrieves An Existing Object From S3

  # Generated from FizzBee spec: apigateway_s3api.fizz
  # Safety invariants: ObjectReferencesExistingBucket, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @get_object_request_succeeds
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3
    Given the "API" is "ACTIVE"
    And the "API" has an S3 integration configured
    And an object "EXISTS" in the target bucket
    When a "GET" request is received and the "API" retrieves an existing object from S3
    Then the request is "SUCCESS"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @guard @negative @get_object_request_succeeds @lifecycle
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 fails when the "API" is not "ACTIVE"
    Given the "API" is not "ACTIVE"
    When a "GET" request is received and the "API" retrieves an existing object from S3
    Then the operation is rejected

  @guard @negative @get_object_request_succeeds
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 fails when the "API" has no S3 integration configured
    Given the "API" is "ACTIVE"
    And the "API" has no S3 integration configured
    When a "GET" request is received and the "API" retrieves an existing object from S3
    Then the operation is rejected

  @guard @negative @get_object_request_succeeds @lifecycle
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 fails when no object "EXISTS" in the target bucket
    Given the "API" is "ACTIVE"
    And the "API" has an S3 integration configured
    And no object "EXISTS" in the target bucket
    When a "GET" request is received and the "API" retrieves an existing object from S3
    Then the operation is rejected
