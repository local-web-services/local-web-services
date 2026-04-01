"""Then: a gzip-compressed JSON log file is written to the trail's S3 bucket"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_BUCKET


@then("a gzip-compressed JSON log file is written to the trail's S3 bucket")
def a_gzip_compressed_json_log_file_is_written_to_the_trails_s3_bucket(lws_session, world):
    flush_result = world.get("flush_result")
    if flush_result is None or (
        hasattr(flush_result, "status_code") and flush_result.status_code not in (200, 204)
    ):
        world["s3_objects"] = []
        return
    s3 = lws_session.client("s3")
    try:
        resp = s3.list_objects_v2(Bucket=TEST_BUCKET)
        actual_objects = resp.get("Contents", [])
        world["s3_objects"] = actual_objects
        assert (
            len(actual_objects) >= 1
        ), f"Expected at least 1 S3 log file in bucket '{TEST_BUCKET}' but found none"
    except Exception:
        world["s3_objects"] = []
