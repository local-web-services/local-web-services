@s3api @get_bucket_policy @controlplane
Feature: S3 GetBucketPolicy

  @happy
  Scenario: Get a policy from a bucket
    Given a bucket "e2e-get-pol" was created
    And a policy was set on bucket "e2e-get-pol"
    When I get the policy of bucket "e2e-get-pol"
    Then the command will succeed
