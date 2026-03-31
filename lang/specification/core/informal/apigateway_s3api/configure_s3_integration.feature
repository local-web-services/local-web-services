@apigateways3api @generated
Feature: ApigatewayS3api - A Direct S3 Integration Is Configured On The "Api Gateway" "Api"

  # Generated from FizzBee spec: apigateway_s3api.fizz
  # Safety invariants: ObjectReferencesExistingBucket, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @configure_s3_integration
  Scenario: a direct S3 integration is configured on the "api gateway" "API"
    Given the "api gateway" "API" existed and was "ACTIVE"
    And the "api gateway" "api" has no S3 integration configured
    And the "s3" "bucket" existed and was "ACTIVE"
    When a direct S3 integration is configured on the "api gateway" "API"
    Then the "api gateway" "API" will proxy requests to the "s3" "bucket"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @guard @negative @configure_s3_integration
  Scenario: a direct S3 integration is configured on the "api gateway" "API" fails when the "api gateway" "API" did not exist or was "ACTIVE"
    Given the "api gateway" "API" did not exist or was "ACTIVE"
    When a direct S3 integration is configured on the "api gateway" "API"
    Then the operation is rejected

  @guard @negative @configure_s3_integration
  Scenario: a direct S3 integration is configured on the "api gateway" "API" fails when the "api gateway" "API" already has a S3 integration configured
    Given the "api gateway" "API" existed and was "ACTIVE"
    And the "api gateway" "API" already has a S3 integration configured
    When a direct S3 integration is configured on the "api gateway" "API"
    Then the operation is rejected

  @guard @negative @configure_s3_integration
  Scenario: a direct S3 integration is configured on the "api gateway" "API" fails when the "s3" "bucket" did not exist or was "ACTIVE"
    Given the "api gateway" "API" existed and was "ACTIVE"
    And the "api gateway" "api" has no S3 integration configured
    And the "s3" "bucket" did not exist or was "ACTIVE"
    When a direct S3 integration is configured on the "api gateway" "API"
    Then the operation is rejected
