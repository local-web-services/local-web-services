"""Given: the topic exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSnsTestClient


@given("the topic exists")
def topic_exists(lws_session):
    LambdaSnsTestClient(lws_session).create_topic()
