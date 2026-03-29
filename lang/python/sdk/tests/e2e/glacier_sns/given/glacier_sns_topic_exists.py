"""Given: the topic exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierSnsTestClient


@given("the topic exists")
def glacier_sns_topic_exists(lws_session):
    GlacierSnsTestClient(lws_session).create_topic()
