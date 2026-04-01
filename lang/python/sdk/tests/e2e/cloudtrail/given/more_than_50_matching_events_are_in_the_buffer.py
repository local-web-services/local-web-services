"""Given: more than 50 matching events are in the buffer"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_SQS_QUEUE


@given("more than 50 matching events are in the buffer")
def more_than_50_matching_events_are_in_the_buffer(lws_session):
    sqs = lws_session.client("sqs")
    for i in range(55):
        try:
            sqs.create_queue(QueueName=f"{TEST_SQS_QUEUE}-page-{i}")
        except Exception:
            pass
