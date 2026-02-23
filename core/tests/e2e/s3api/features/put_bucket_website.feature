@s3api @put_bucket_website @controlplane
Feature: S3 PutBucketWebsite

  @happy
  Scenario: Set website configuration on a bucket
    Given a bucket "e2e-put-website-bkt" was created
    When I put website configuration on bucket "e2e-put-website-bkt" with index "index.html"
    Then the command will succeed
    And bucket "e2e-put-website-bkt" will have website index document "index.html"
