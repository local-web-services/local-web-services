@s3api @create_bucket @controlplane
Feature: S3 CreateBucket

  @happy
  Scenario: Create a new bucket
    When I create bucket "e2e-create-bkt"
    Then the command will succeed
    And bucket "e2e-create-bkt" will exist
