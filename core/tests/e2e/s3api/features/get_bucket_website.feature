@s3api @get_bucket_website @controlplane
Feature: S3 GetBucketWebsite

  @happy
  Scenario: Get website configuration from a bucket
    Given a bucket "e2e-get-website-bkt" was created
    And website configuration was set on bucket "e2e-get-website-bkt" with index "index.html"
    When I get website configuration from bucket "e2e-get-website-bkt"
    Then the command will succeed
    And the output will contain website index document "index.html"
