"""When: a cloudtrail trail is created"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_BUCKET, TEST_TRAIL


@when("a cloudtrail trail is created")
@when('a "cloudtrail" "trail" is created')
def a_cloudtrail_trail_is_created(lws_session, world):
    try:
        world["result"] = lws_session.client("cloudtrail").create_trail(
            Name=TEST_TRAIL, S3BucketName=TEST_BUCKET
        )
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
