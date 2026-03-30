"""Given: an "SQS" queue has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsSqsTestClient


@given('an "SQS" queue has been created')
def sns_sqs_an_sqs_queue_has_been_created(lws_session):
    SnsSqsTestClient(lws_session).create_queue()
