"""When: UpdateTrail is called with a new S3 bucket name"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_BUCKET_2, TEST_TRAIL


@when("UpdateTrail is called with a new S3 bucket name")
def update_trail_is_called_with_a_new_s3_bucket_name(lws_session, world):
    try:
        world["result"] = lws_session.client("cloudtrail").update_trail(
            Name=TEST_TRAIL, S3BucketName=TEST_BUCKET_2
        )
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
