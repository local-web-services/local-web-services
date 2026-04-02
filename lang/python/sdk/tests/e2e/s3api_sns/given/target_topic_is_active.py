"""Given: the target "sns" "topic" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSnsTestClient


@given('the target "sns" "topic" was "ACTIVE"')
def target_topic_is_active(lws_session):
    try:
        S3apiSnsTestClient(lws_session).create_topic()
    except Exception:
        pass
