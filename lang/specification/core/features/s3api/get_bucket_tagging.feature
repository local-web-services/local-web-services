@s3api @get_bucket_tagging @controlplane
Feature: S3 GetBucketTagging

  @happy
  Scenario: Get tags from a bucket
    Given a bucket "e2e-get-tags" was created
    And tags were set on bucket "e2e-get-tags" with key "env" and value "staging"
    When I get tags from bucket "e2e-get-tags"
    Then the command will succeed
