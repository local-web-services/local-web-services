"""Given: the dead-letter "sqs" "queue" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSqsTestClient


@given('the dead-letter "sqs" "queue" existed')
def dlq_exists(lws_session):
    LambdaSqsTestClient(lws_session).create_dlq()
