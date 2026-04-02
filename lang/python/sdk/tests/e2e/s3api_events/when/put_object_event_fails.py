"""When: an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BODY, TEST_BUCKET, TEST_BUS, TEST_KEY


@when(
    'an "s3" "object" is uploaded but "eventbridge" "event" delivery fails because the "eventbridge" "bus" has been deleted'
)
def put_object_event_fails(lws_session, world):
    try:
        world["result"] = lws_session.client("s3").put_object(
            Bucket=TEST_BUCKET, Key=TEST_KEY, Body=TEST_BODY
        )
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
        return
    # Verify precondition: event delivery must have failed, so bus must not exist
    try:
        lws_session.client("events").describe_event_bus(Name=TEST_BUS)
        # Bus still exists — event delivery would NOT have failed
        world["result"] = None
        world["error"] = Exception(f"Expected bus '{TEST_BUS}' to be deleted but it still exists")
    except Exception:
        # Bus does not exist — event delivery correctly failed
        world["error"] = None
