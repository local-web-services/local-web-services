@s3api @delete_objects @dataplane
Feature: S3 DeleteObjects

  @happy
  Scenario: Batch delete multiple objects
    Given a bucket "e2e-del-objs" was created
    And an object "a.txt" was put into bucket "e2e-del-objs" with content "aaa"
    And an object "b.txt" was put into bucket "e2e-del-objs" with content "bbb"
    When I delete objects "a.txt" and "b.txt" from bucket "e2e-del-objs"
    Then the command will succeed
    And bucket "e2e-del-objs" will have 0 objects
