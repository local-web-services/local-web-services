Feature: S3 - List Objects

  Background:
    Given the s3 system is initialized
    And the "s3" "bucket" exists

  Scenario: objects in a "s3" "bucket" are listed
    Given an object is stored in the "s3" "bucket"
    When the objects in the "s3" "bucket" are listed
    Then the "s3" "object" will appear in the listing
