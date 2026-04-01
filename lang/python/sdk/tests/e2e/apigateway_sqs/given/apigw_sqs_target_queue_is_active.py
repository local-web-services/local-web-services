"""Given: the target queue was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewaySqsTestClient


@given('the target queue was "ACTIVE"')
def apigw_sqs_target_queue_is_active(lws_session):
    try:
        ApigatewaySqsTestClient(lws_session).create_queue()
    except Exception:
        pass
