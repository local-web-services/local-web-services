"""Given: tid in topic_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewaySnsTestClient


@given("tid in topic_status")
def apigw_sns_tid_in_topic_status(lws_session):
    ApigatewaySnsTestClient(lws_session).create_topic()
