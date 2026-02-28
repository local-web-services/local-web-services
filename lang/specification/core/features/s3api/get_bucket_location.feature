@s3api @get_bucket_location @controlplane
Feature: S3 GetBucketLocation

  @happy
  Scenario: Get the location of a bucket
    Given a bucket "e2e-get-loc" was created
    When I get the location of bucket "e2e-get-loc"
    Then the command will succeed
