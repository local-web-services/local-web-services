"""Given: the "sns" "topic" existed and was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierSnsTestClient


@given('the "sns" "topic" existed and was "ACTIVE"')
def glacier_sns_topic_exists_and_is_active(lws_session):
    GlacierSnsTestClient(lws_session).create_topic()
