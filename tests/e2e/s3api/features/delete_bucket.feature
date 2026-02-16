@s3api @delete_bucket @controlplane
Feature: S3 DeleteBucket

  @happy
  Scenario: Delete an existing bucket
    Given a bucket "e2e-del-bkt" was created
    When I delete bucket "e2e-del-bkt"
    Then the command will succeed
    And bucket "e2e-del-bkt" will not appear in list-buckets
