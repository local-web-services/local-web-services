@s3api @list_parts @dataplane
Feature: S3 ListParts

  @happy
  Scenario: List parts of a multipart upload
    Given a bucket "e2e-list-parts" was created
    And a multipart upload was created for key "bigfile.bin" in bucket "e2e-list-parts"
    And part 1 with content "part1data" was uploaded
    When I list parts of the multipart upload
    Then the command will succeed
