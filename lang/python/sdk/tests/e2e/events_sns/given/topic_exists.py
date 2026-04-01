"""Given: the "sns" "topic" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSnsTestClient


@given('the "sns" "topic" existed')
def topic_exists(lws_session):
    EventsSnsTestClient(lws_session).create_topic()
