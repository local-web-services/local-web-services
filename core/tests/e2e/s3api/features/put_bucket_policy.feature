@s3api @put_bucket_policy @controlplane
Feature: S3 PutBucketPolicy

  @happy
  Scenario: Set a policy on a bucket
    Given a bucket "e2e-put-pol" was created
    When I put a policy on bucket "e2e-put-pol"
    Then the command will succeed
