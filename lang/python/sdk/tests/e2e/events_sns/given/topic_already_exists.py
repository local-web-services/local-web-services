"""Given: the topic already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSnsTestClient


@given("the topic already existed")
def topic_already_exists(lws_session):
    EventsSnsTestClient(lws_session).create_topic()
