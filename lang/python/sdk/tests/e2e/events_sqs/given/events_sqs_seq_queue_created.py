"""Given: an "SQS" queue has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSqsTestClient


@given('an "SQS" queue has been created')
def events_sqs_seq_queue_created(lws_session):
    EventsSqsTestClient(lws_session).create_queue()
