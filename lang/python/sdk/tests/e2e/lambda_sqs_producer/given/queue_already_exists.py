"""Given: the queue already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSqsProducerTestClient


@given("the queue already exists")
def queue_already_exists(lws_session):
    LambdaSqsProducerTestClient(lws_session).create_queue()
