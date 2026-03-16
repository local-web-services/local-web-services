@s3api @generated
Feature: S3Api - Deleting a bucket requires it to be empty

  # Generated from FizzBee spec: s3api.fizz

  Background:
    Given the system is initialized

  @invariant @delete_bucket_requires_empty
  Scenario: deleting a bucket requires it to be empty
    Then deleting a bucket requires it to be empty
