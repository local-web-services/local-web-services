@s3api @get_object @dataplane
Feature: S3 GetObject

  @happy
  Scenario: Get an object from a bucket
    Given a bucket "e2e-get-obj" was created
    And an object "doc.txt" was put into bucket "e2e-get-obj" with content "hello world"
    When I get object "doc.txt" from bucket "e2e-get-obj"
    Then the command will succeed
    And the downloaded file will have content "hello world"
