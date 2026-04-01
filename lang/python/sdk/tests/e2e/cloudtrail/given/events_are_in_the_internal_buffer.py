"""Given: events are in the internal buffer"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_SQS_QUEUE


@given("events are in the internal buffer")
def events_are_in_the_internal_buffer(lws_session):
    sqs = lws_session.client("sqs")
    try:
        sqs.create_queue(QueueName=TEST_SQS_QUEUE)
    except Exception:  # noqa: BLE001
        pass
