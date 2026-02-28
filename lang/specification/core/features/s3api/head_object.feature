@s3api @head_object @dataplane
Feature: S3 HeadObject

  @happy
  Scenario: Head an existing object
    Given a bucket "e2e-head-obj" was created
    And an object "h.txt" was put into bucket "e2e-head-obj" with content "data"
    When I head object "h.txt" in bucket "e2e-head-obj"
    Then the command will succeed
    And the output will contain "ContentLength"
