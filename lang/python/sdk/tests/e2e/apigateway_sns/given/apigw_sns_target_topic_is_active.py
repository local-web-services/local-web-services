"""Given: the target topic was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewaySnsTestClient


@given('the target topic was "ACTIVE"')
def apigw_sns_target_topic_is_active(lws_session):
    try:
        ApigatewaySnsTestClient(lws_session).create_topic()
    except Exception:
        pass
