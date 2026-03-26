"""Given: the queue exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSqsTestClient


@given("the queue exists")
def queue_exists(lws_session):
    StepfunctionsSqsTestClient(lws_session).create_queue()
