@apigateways3api @generated
Feature: ApigatewayS3api - An "Api Gateway" "Api" Is Created

  # Generated from FizzBee spec: apigateway_s3api.fizz
  # Safety invariants: ObjectReferencesExistingBucket, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @create_rest_a_p_i
  Scenario: an "api gateway" "api" is created
    Given the "api gateway" "API" did not already exist
    When an "api gateway" "api" is created
    Then the "api gateway" "api" will be "ACTIVE" with no S3 integration configured
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @guard @negative @create_rest_a_p_i
  Scenario: an "api gateway" "api" is created fails when the "api gateway" "API" already existed
    Given the "api gateway" "API" already existed
    When an "api gateway" "api" is created
    Then the operation is rejected
