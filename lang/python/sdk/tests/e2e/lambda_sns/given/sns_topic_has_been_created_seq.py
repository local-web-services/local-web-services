"""Given: an "SNS" topic has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSnsTestClient


@given('an "SNS" topic has been created')
def sns_topic_has_been_created_seq(lws_session):
    LambdaSnsTestClient(lws_session).create_topic()
