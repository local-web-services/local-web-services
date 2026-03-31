"""Given: a "sqs" "queue" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSqsTestClient


@given('a "sqs" "queue" is created')
def sqs_queue_has_been_created(lws_session):
    StepfunctionsSqsTestClient(lws_session).create_queue()
