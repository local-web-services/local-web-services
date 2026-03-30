"""Given: the dead-letter queue exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSqsTestClient


@given("the dead-letter queue exists")
def dlq_exists(lws_session):
    LambdaSqsTestClient(lws_session).create_dlq()
