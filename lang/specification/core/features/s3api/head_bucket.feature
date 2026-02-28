@s3api @head_bucket @controlplane
Feature: S3 HeadBucket

  @happy
  Scenario: Head an existing bucket
    Given a bucket "e2e-head-bkt" was created
    When I head bucket "e2e-head-bkt"
    Then the command will succeed
