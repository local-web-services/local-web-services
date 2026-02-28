@s3api @list_buckets @controlplane
Feature: S3 ListBuckets

  @happy
  Scenario: List buckets includes a created bucket
    Given a bucket "e2e-list-bkts" was created
    When I list buckets
    Then the command will succeed
    And the bucket list will include "e2e-list-bkts"
