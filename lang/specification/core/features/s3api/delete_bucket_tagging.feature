@s3api @delete_bucket_tagging @controlplane
Feature: S3 DeleteBucketTagging

  @happy
  Scenario: Delete tags from a bucket
    Given a bucket "e2e-del-tags" was created
    And tags were set on bucket "e2e-del-tags" with key "env" and value "dev"
    When I delete tags from bucket "e2e-del-tags"
    Then the command will succeed
