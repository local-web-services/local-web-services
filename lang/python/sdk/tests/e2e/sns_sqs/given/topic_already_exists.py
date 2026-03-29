"""Given: the topic already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsSqsTestClient


@given("the topic already exists")
def topic_already_exists(lws_session):
    SnsSqsTestClient(lws_session).create_topic()
