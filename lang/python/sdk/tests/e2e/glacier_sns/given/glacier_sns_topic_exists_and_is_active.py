"""Given: the topic exists and is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierSnsTestClient


@given('the topic exists and is "ACTIVE"')
def glacier_sns_topic_exists_and_is_active(lws_session):
    GlacierSnsTestClient(lws_session).create_topic()
