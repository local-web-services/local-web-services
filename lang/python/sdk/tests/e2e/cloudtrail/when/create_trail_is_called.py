"""When: CreateTrail is called"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_BUCKET, TEST_TRAIL


@when("CreateTrail is called")
def create_trail_is_called(lws_session, world):
    try:
        world["result"] = lws_session.client("cloudtrail").create_trail(
            Name=TEST_TRAIL, S3BucketName=TEST_BUCKET
        )
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
