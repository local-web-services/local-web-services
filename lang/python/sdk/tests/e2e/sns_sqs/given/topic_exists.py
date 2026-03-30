"""Given: the topic exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsSqsTestClient


@given("the topic exists")
def topic_exists(lws_session):
    SnsSqsTestClient(lws_session).create_topic()
