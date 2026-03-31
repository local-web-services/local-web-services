"""Given: a "sqs" "queue" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSqsTestClient


@given('a "sqs" "queue" is created')
def events_sqs_seq_queue_created(lws_session):
    EventsSqsTestClient(lws_session).create_queue()
