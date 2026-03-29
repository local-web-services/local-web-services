"""Given: the topic exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSnsTestClient


@given("the topic exists")
def topic_exists(lws_session):
    S3apiSnsTestClient(lws_session).create_topic()
