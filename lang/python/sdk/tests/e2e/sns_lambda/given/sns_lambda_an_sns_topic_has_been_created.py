"""Given: an "SNS" topic has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsLambdaTestClient


@given('an "SNS" topic has been created')
def sns_lambda_an_sns_topic_has_been_created(lws_session):
    SnsLambdaTestClient(lws_session).create_topic()
