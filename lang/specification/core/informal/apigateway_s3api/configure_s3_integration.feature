@apigateways3api @generated
Feature: ApigatewayS3api - A Direct S3 Integration Is Configured On The Api

  # Generated from FizzBee spec: apigateway_s3api.fizz
  # Safety invariants: ObjectReferencesExistingBucket, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @configure_s3_integration
  Scenario: a direct S3 integration is configured on the "API"
    Given the "API" exists and is "ACTIVE"
    And the "API" has no S3 integration configured
    And the bucket exists and is "ACTIVE"
    When a direct S3 integration is configured on the "API"
    Then the "API" will proxy requests to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @standard @negative @configure_s3_integration
  Scenario: a direct S3 integration is configured on the "API" fails when the "API" does not exist or is not "ACTIVE"
    Given the "API" does not exist or is not "ACTIVE"
    When a direct S3 integration is configured on the "API"
    Then the operation is rejected

  @standard @negative @configure_s3_integration
  Scenario: a direct S3 integration is configured on the "API" fails when the "API" already has an S3 integration configured
    Given the "API" exists and is "ACTIVE"
    And the "API" already has an S3 integration configured
    When a direct S3 integration is configured on the "API"
    Then the operation is rejected

  @standard @negative @configure_s3_integration
  Scenario: a direct S3 integration is configured on the "API" fails when the bucket does not exist or is not "ACTIVE"
    Given the "API" exists and is "ACTIVE"
    And the "API" has no S3 integration configured
    And the bucket does not exist or is not "ACTIVE"
    When a direct S3 integration is configured on the "API"
    Then the operation is rejected
