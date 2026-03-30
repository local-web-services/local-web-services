"""Given: the topic exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewaySnsTestClient


@given("the topic exists")
def apigw_sns_topic_exists(lws_session):
    ApigatewaySnsTestClient(lws_session).create_topic()
