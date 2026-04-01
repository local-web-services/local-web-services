"""Then: no new cloudtrail event is buffered for the logging trail"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_SQS_QUEUE


@then("no new cloudtrail event is buffered for the logging trail")
def no_new_cloudtrail_event_is_buffered_for_the_logging_trail(lws_session, world):
    pre_count = world.get("pre_op_count", 0)
    resp = lws_session.client("cloudtrail").lookup_events(
        LookupAttributes=[{"AttributeKey": "EventName", "AttributeValue": "CreateQueue"}]
    )
    actual_events = resp.get("Events", [])
    actual_count = len(
        [
            e
            for e in actual_events
            if TEST_SQS_QUEUE in str(e.get("CloudTrailEvent", ""))
            or TEST_SQS_QUEUE in str(e.get("Resources", []))
        ]
    )
    assert (
        actual_count <= pre_count
    ), f"Expected no new events after stop_logging but count went from {pre_count} to {actual_count}"
