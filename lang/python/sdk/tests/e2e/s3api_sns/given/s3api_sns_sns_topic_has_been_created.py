"""Given: a "sns" "topic" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSnsTestClient


@given('a "sns" "topic" is created')
def s3api_sns_sns_topic_has_been_created(lws_session):
    S3apiSnsTestClient(lws_session).create_topic()
