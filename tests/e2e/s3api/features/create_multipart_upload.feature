@s3api @create_multipart_upload @dataplane
Feature: S3 CreateMultipartUpload

  @happy
  Scenario: Full multipart upload workflow
    Given a bucket "e2e-multipart" was created
    When I create a multipart upload for key "e2e-multi.bin" in bucket "e2e-multipart"
    Then the command will succeed
    And the output will contain an upload ID

  @happy
  Scenario: Multipart upload produces correct object content
    Given a bucket "e2e-multipart" was created
    And a multipart upload was created for key "e2e-multi.bin" in bucket "e2e-multipart"
    And part 1 with content "first-part-" was uploaded
    And part 2 with content "second-part" was uploaded
    When I complete the multipart upload
    Then the command will succeed
    And object "e2e-multi.bin" in bucket "e2e-multipart" will have binary content "first-part-second-part"
