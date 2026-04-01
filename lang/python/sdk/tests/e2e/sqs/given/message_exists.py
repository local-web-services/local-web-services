"""Given: the "sqs" "message" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SqsTestClient


@given('the "sqs" "message" existed')
def message_exists(lws_session, world):
    SqsTestClient(lws_session).create_queue()
    SqsTestClient(lws_session).send_message()
