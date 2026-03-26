"""Given: an "SQS" queue has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSqsProducerTestClient


@given('an "SQS" queue has been created')
def sqs_queue_has_been_created_seq(lws_session):
    LambdaSqsProducerTestClient(lws_session).create_queue()
