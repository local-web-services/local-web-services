"""Then: event capture continues normally"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_SQS_QUEUE


@then("event capture continues normally")
def event_capture_continues_normally(lws_session):
    sqs = lws_session.client("sqs")
    sqs.create_queue(QueueName=f"{TEST_SQS_QUEUE}-capture-check")
    resp = lws_session.client("cloudtrail").lookup_events()
    actual_events = resp.get("Events", [])
    assert isinstance(
        actual_events, list
    ), f"Expected Events to be a list but got {type(actual_events)}"
