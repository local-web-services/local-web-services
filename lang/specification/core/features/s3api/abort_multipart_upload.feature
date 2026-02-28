@s3api @abort_multipart_upload @dataplane
Feature: S3 AbortMultipartUpload

  @happy
  Scenario: Abort a multipart upload
    Given a bucket "e2e-abort-mp" was created
    And a multipart upload was created for key "e2e-abort.bin" in bucket "e2e-abort-mp"
    When I abort the multipart upload
    Then the command will succeed
