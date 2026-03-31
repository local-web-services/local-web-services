"""Given: a "sns" "topic" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSnsTestClient


@given('a "sns" "topic" is created')
def sns_topic_has_been_created_seq(lws_session):
    LambdaSnsTestClient(lws_session).create_topic()
