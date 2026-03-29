"""Given: an "SNS" topic has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSnsTestClient


@given('an "SNS" topic has been created')
def sns_topic_has_been_created(lws_session):
    StepfunctionsSnsTestClient(lws_session).create_topic()
