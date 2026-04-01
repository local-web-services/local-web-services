"""Given: the "sqs" "queue" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsSqsTestClient


@given('the "sqs" "queue" existed')
def queue_existed(lws_session):
    SnsSqsTestClient(lws_session).create_queue()
