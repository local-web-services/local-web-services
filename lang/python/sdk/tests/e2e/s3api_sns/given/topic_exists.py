"""Given: the "sns" "topic" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSnsTestClient


@given('the "sns" "topic" existed')
def topic_exists(lws_session):
    S3apiSnsTestClient(lws_session).create_topic()
