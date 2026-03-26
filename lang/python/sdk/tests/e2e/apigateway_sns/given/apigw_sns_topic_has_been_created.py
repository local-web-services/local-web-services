"""Given: an "SNS" topic has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewaySnsTestClient


@given('an "SNS" topic has been created')
def apigw_sns_topic_has_been_created(lws_session):
    ApigatewaySnsTestClient(lws_session).create_topic()
