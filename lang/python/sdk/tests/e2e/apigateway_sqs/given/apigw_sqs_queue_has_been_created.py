"""Given: a "sqs" "queue" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewaySqsTestClient


@given('a "sqs" "queue" is created')
def apigw_sqs_queue_has_been_created(lws_session):
    ApigatewaySqsTestClient(lws_session).create_queue()
