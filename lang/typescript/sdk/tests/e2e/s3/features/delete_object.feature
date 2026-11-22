Feature: S3 - Delete Object

  Background:
    Given the s3 system is initialized
    And the "s3" "bucket" exists

  Scenario: an existing "s3" "object" is deleted
    Given an object is stored in the "s3" "bucket"
    When the "s3" "object" is deleted
    Then the "s3" "object" will not exist in the "s3" "bucket"
