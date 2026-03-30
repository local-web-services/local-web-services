"""Given: qname in queue_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SqsTestClient


@given("qname in queue_status")
def sqs_qname_in_queue_status(lws_session):
    SqsTestClient(lws_session).create_queue()
