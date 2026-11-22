Feature: S3 - Get Object

  Background:
    Given the s3 system is initialized
    And the "s3" "bucket" exists

  Scenario: an existing "s3" "object" is retrieved
    Given an object is stored in the "s3" "bucket"
    When the "s3" "object" is retrieved
    Then the "s3" "object" body will be returned

  Scenario: retrieving a missing "s3" "object" returns an error
    Given the "s3" "object" does not exist
    When the "s3" "object" is retrieved
    Then the s3 operation is rejected
