Feature: S3 - Create Bucket

  Background:
    Given the s3 system is initialized

  Scenario: a "s3" "bucket" is created
    When a "s3" "bucket" is created
    Then the "s3" "bucket" will exist
