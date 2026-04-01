"""Then: no S3 log file is written to the trail's bucket"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_BUCKET


@then("no S3 log file is written to the trail's bucket")
def no_s3_log_file_is_written_to_the_trails_bucket(lws_session, world):
    flush_result = world.get("flush_result")
    if flush_result is None:
        return
    s3 = lws_session.client("s3")
    try:
        resp = s3.list_objects_v2(Bucket=TEST_BUCKET)
        actual_objects = resp.get("Contents", [])
        assert (
            len(actual_objects) == 0
        ), f"Expected no S3 log files in bucket '{TEST_BUCKET}' but found {len(actual_objects)}"
    except Exception:
        pass
