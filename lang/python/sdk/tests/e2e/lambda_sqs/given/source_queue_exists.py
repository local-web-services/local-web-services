"""Given: the source "sqs" "queue" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSqsTestClient


@given('the source "sqs" "queue" existed')
def source_queue_exists(lws_session):
    LambdaSqsTestClient(lws_session).create_queue()
