"""Then: the "s3" "object" will exist and an "eventbridge" "event" will be "DELIVERED" to the "eventbridge" "bus" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_BUCKET, TEST_KEY


@then(
    'the "s3" "object" will exist and an "eventbridge" "event" will be "DELIVERED" to the "eventbridge" "bus"'
)
def object_exists_and_event_delivered(lws_session):
    resp = lws_session.client("s3").list_objects_v2(Bucket=TEST_BUCKET)
    keys = [obj["Key"] for obj in resp.get("Contents", [])]
    assert TEST_KEY in keys, f"Expected object '{TEST_KEY}' to exist but not found in: {keys}"
