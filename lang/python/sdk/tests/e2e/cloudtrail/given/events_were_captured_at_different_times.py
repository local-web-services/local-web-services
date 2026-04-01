"""Given: events were captured at different times"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_SQS_QUEUE


@given("events were captured at different times")
def events_were_captured_at_different_times(lws_session):
    sqs = lws_session.client("sqs")
    try:
        sqs.create_queue(QueueName=TEST_SQS_QUEUE)
    except Exception:  # noqa: BLE001
        pass
    try:
        sqs.create_queue(QueueName=f"{TEST_SQS_QUEUE}-2")
    except Exception:  # noqa: BLE001
        pass
    try:
        sqs.create_queue(QueueName=f"{TEST_SQS_QUEUE}-3")
    except Exception:  # noqa: BLE001
        pass
