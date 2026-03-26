"""Given: qid in queue_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSqsTestClient


@given("qid in queue_status")
def qid_in_queue_status(lws_session):
    LambdaSqsTestClient(lws_session).create_queue()
