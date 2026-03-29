"""Given: the queue already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsSqsTestClient


@given("the queue already exists")
def queue_already_exists(lws_session):
    SnsSqsTestClient(lws_session).create_queue()
