@s3api @delete_bucket_website @controlplane
Feature: S3 DeleteBucketWebsite

  @happy
  Scenario: Delete website configuration from a bucket
    Given a bucket "e2e-del-website-bkt" was created
    And website configuration was set on bucket "e2e-del-website-bkt" with index "index.html"
    When I delete website configuration from bucket "e2e-del-website-bkt"
    Then the command will succeed
    And bucket "e2e-del-website-bkt" will have no website configuration
