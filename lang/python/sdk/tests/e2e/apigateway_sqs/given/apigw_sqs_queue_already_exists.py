"""Given: the queue already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewaySqsTestClient


@given("the queue already exists")
def apigw_sqs_queue_already_exists(lws_session):
    ApigatewaySqsTestClient(lws_session).create_queue()
