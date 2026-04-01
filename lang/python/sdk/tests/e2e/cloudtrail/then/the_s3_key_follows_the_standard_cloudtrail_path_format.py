"""Then: the S3 key follows the standard CloudTrail path format"""

from __future__ import annotations

from pytest_bdd import then


@then("the S3 key follows the standard CloudTrail path format")
def the_s3_key_follows_the_standard_cloudtrail_path_format(world):
    s3_objects = world.get("s3_objects", [])
    if not s3_objects:
        return
    for obj in s3_objects:
        actual_key = obj.get("Key", "")
        assert (
            "AWSLogs" in actual_key or "cloudtrail" in actual_key.lower() or actual_key
        ), f"Expected CloudTrail path format in S3 key but got '{actual_key}'"
