@s3api @delete_object @dataplane
Feature: S3 DeleteObject

  @happy
  Scenario: Delete an object from a bucket
    Given a bucket "e2e-del-obj" was created
    And an object "f.txt" was put into bucket "e2e-del-obj" with content "content"
    When I delete object "f.txt" from bucket "e2e-del-obj"
    Then the command will succeed
    And bucket "e2e-del-obj" will have 0 objects
