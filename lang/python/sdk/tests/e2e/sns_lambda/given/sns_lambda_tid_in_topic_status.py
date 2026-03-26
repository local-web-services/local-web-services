"""Given: tid in topic_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsLambdaTestClient


@given("tid in topic_status")
def sns_lambda_tid_in_topic_status(lws_session):
    SnsLambdaTestClient(lws_session).create_topic()
