@s3api @upload_part @dataplane
Feature: S3 UploadPart

  @happy
  Scenario: Upload a part to a multipart upload
    Given a bucket "e2e-upload-part" was created
    And a multipart upload was created for key "e2e-part.bin" in bucket "e2e-upload-part"
    When I upload part 1 with content "part-data"
    Then the command will succeed
    And the output will contain an ETag
