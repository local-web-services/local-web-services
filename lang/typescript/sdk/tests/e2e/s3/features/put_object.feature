Feature: S3 - Put Object

  Background:
    Given the s3 system is initialized
    And the "s3" "bucket" exists

  Scenario: an object is stored in a "s3" "bucket"
    When a "s3" "object" is put into the "s3" "bucket"
    Then the "s3" "object" will exist in the "s3" "bucket"
