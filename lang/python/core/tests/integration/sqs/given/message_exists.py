"""Given: the "sqs" "message" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SqsTestClient


@given('the "sqs" "message" existed')
def message_exists(client):
    SqsTestClient(client).create_queue()
    SqsTestClient(client).send_message()
