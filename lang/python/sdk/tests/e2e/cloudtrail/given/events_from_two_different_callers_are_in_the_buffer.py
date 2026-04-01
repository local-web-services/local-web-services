"""Given: events from two different callers are in the buffer"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_SQS_QUEUE


@given("events from two different callers are in the buffer")
def events_from_two_different_callers_are_in_the_buffer(lws_session):
    sqs = lws_session.client("sqs")
    try:
        sqs.create_queue(QueueName=TEST_SQS_QUEUE)
    except Exception:  # noqa: BLE001
        pass
    try:
        sqs.create_queue(QueueName=f"{TEST_SQS_QUEUE}-2")
    except Exception:  # noqa: BLE001
        pass
