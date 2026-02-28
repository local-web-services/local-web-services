@s3api @copy_object @dataplane
Feature: S3 CopyObject

  @happy
  Scenario: Copy an object to a new key
    Given a bucket "e2e-copy-obj" was created
    And an object "source.txt" was put into bucket "e2e-copy-obj" with content "copy me"
    When I copy object "dest.txt" in bucket "e2e-copy-obj" from source "e2e-copy-obj/source.txt"
    Then the command will succeed
    And object "dest.txt" in bucket "e2e-copy-obj" will have content "copy me"
