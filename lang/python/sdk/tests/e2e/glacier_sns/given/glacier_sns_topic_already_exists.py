"""Given: the "sns" "topic" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierSnsTestClient


@given('the "sns" "topic" already existed')
def glacier_sns_topic_already_exists(lws_session):
    GlacierSnsTestClient(lws_session).create_topic()
