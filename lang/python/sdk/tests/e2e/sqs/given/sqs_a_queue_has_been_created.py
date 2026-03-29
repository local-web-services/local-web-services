"""Given: a queue has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SqsTestClient


@given("a queue has been created")
def sqs_a_queue_has_been_created(lws_session):
    SqsTestClient(lws_session).create_queue()
