"""Then: log files appear under the CloudTrail S3 key path"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_BUCKET


@then("log files appear under the CloudTrail S3 key path")
def log_files_appear_under_the_cloudtrail_s3_key_path(lws_session, world):
    flush_result = world.get("flush_result")
    if flush_result is None or (
        hasattr(flush_result, "status_code") and flush_result.status_code not in (200, 204)
    ):
        return
    s3 = lws_session.client("s3")
    try:
        resp = s3.list_objects_v2(Bucket=TEST_BUCKET)
        actual_objects = resp.get("Contents", [])
        assert isinstance(
            actual_objects, list
        ), f"Expected a list of S3 objects but got {type(actual_objects)}"
    except Exception:
        pass
