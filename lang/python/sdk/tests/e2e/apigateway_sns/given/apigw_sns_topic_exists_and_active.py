"""Given: the "sns" "topic" existed and was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewaySnsTestClient


@given('the "sns" "topic" existed and was "ACTIVE"')
def apigw_sns_topic_exists_and_active(lws_session):
    ApigatewaySnsTestClient(lws_session).create_topic()
