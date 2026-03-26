"""Given: qid in queue_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSqsTestClient


@given("qid in queue_status")
def events_sqs_qid_in_queue_status(lws_session):
    EventsSqsTestClient(lws_session).create_queue()
