@s3api @put_object @dataplane
Feature: S3 PutObject

  @happy
  Scenario: Put an object into a bucket
    Given a bucket "e2e-put-obj" was created
    And a file was created with content "upload content"
    When I put object "file.txt" into bucket "e2e-put-obj" from the file
    Then the command will succeed
    And object "file.txt" in bucket "e2e-put-obj" will have content "upload content"
