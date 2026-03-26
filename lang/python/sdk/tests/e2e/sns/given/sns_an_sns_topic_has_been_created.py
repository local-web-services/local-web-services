"""Given: an "SNS" topic has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsTestClient


@given('an "SNS" topic has been created')
def sns_an_sns_topic_has_been_created(lws_session, world):
    world["topic_arn"] = SnsTestClient(lws_session).create_topic()
