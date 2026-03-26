"""Given: mid in msg_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SqsTestClient


@given("mid in msg_status")
def sqs_mid_in_msg_status(lws_session):
    SqsTestClient(lws_session).create_queue()
    SqsTestClient(lws_session).send_message()
