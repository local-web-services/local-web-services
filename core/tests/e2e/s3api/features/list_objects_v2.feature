@s3api @list_objects_v2 @dataplane
Feature: S3 ListObjectsV2

  @happy
  Scenario: List objects includes a created object
    Given a bucket "e2e-listobj" was created
    And an object "l.txt" was put into bucket "e2e-listobj" with content "x"
    When I list objects in bucket "e2e-listobj"
    Then the command will succeed
    And the object list will include "l.txt"
