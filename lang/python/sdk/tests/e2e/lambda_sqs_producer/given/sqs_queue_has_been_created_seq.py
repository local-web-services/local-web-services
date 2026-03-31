"""Given: a "sqs" "queue" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSqsProducerTestClient


@given('a "sqs" "queue" is created')
def sqs_queue_has_been_created_seq(lws_session):
    LambdaSqsProducerTestClient(lws_session).create_queue()
