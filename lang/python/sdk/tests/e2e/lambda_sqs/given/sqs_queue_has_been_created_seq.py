"""Given: an "SQS" queue has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSqsTestClient


@given('an "SQS" queue has been created')
def sqs_queue_has_been_created_seq(lws_session):
    LambdaSqsTestClient(lws_session).create_queue()
