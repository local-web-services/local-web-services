"""Given: the queue exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSqsTestClient


@given("the queue exists")
def queue_exists(lws_session):
    LambdaSqsTestClient(lws_session).create_queue()
