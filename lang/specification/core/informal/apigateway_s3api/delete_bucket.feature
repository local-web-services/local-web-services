@apigateways3api @generated
Feature: ApigatewayS3api - The "S3" "Bucket" Is Deleted

  # Generated from FizzBee spec: apigateway_s3api.fizz
  # Safety invariants: ObjectReferencesExistingBucket, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @delete_bucket
  Scenario: the "s3" "bucket" is deleted
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    When the "s3" "bucket" is deleted
    Then the "s3" "bucket" will be deleted and "API" requests targeting it will fail
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @guard @negative @delete_bucket
  Scenario: the "s3" "bucket" is deleted fails when the "s3" "bucket" did not exist
    Given the "s3" "bucket" did not exist
    When the "s3" "bucket" is deleted
    Then the operation is rejected

  @guard @negative @delete_bucket @lifecycle
  Scenario: the "s3" "bucket" is deleted fails when the "s3" "bucket" is already "DELETED"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" is already "DELETED"
    When the "s3" "bucket" is deleted
    Then the operation is rejected
