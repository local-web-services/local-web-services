@s3api @complete_multipart_upload @dataplane
Feature: S3 CompleteMultipartUpload

  @happy
  Scenario: Complete a multipart upload
    Given a bucket "e2e-complete-mp" was created
    And a multipart upload was created for key "e2e-complete.bin" in bucket "e2e-complete-mp"
    And part 1 with content "complete-data" was uploaded
    When I complete the multipart upload
    Then the command will succeed
