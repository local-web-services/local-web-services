@s3api @put_bucket_tagging @controlplane
Feature: S3 PutBucketTagging

  @happy
  Scenario: Set tags on a bucket
    Given a bucket "e2e-put-tags" was created
    When I put tags on bucket "e2e-put-tags" with key "env" and value "test"
    Then the command will succeed
