"""Given: the queue already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSqsTestClient


@given("the queue already existed")
def queue_exists(lws_session):
    EventsSqsTestClient(lws_session).create_queue()
