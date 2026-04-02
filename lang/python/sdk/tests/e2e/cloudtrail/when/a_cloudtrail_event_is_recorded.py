"""When: a "cloudtrail" "event" is recorded"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_SQS_QUEUE


@when('a "cloudtrail" "event" is recorded')
def a_cloudtrail_event_is_recorded(lws_session, world):
    """Trigger an API call so a cloudtrail event is captured."""
    if world.get("event_already_exists") is True:
        world["result"] = None
        world["error"] = ValueError("Guard: event already exists")
        return
    try:
        world["result"] = lws_session.client("sqs").create_queue(QueueName=f"{TEST_SQS_QUEUE}-evt")
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
