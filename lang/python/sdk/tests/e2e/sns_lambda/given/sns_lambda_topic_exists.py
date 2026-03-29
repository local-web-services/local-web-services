"""Given: the topic exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsLambdaTestClient


@given("the topic exists")
def sns_lambda_topic_exists(lws_session):
    SnsLambdaTestClient(lws_session).create_topic()
