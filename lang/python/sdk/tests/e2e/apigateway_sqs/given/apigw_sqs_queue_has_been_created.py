"""Given: an "SQS" queue has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewaySqsTestClient


@given('an "SQS" queue has been created')
def apigw_sqs_queue_has_been_created(lws_session):
    ApigatewaySqsTestClient(lws_session).create_queue()
