"""Given: a "sqs" "queue" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsSqsTestClient


@given('a "sqs" "queue" is created')
def sns_sqs_an_sqs_queue_has_been_created(lws_session):
    SnsSqsTestClient(lws_session).create_queue()
