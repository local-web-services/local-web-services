"""Given: the topic already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsTestClient


@given("the topic already exists")
def topic_already_exists(lws_session, world):
    world["topic_arn"] = SnsTestClient(lws_session).create_topic()
