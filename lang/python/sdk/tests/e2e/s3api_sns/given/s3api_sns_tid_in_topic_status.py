"""Given: tid in topic_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSnsTestClient


@given("tid in topic_status")
def s3api_sns_tid_in_topic_status(lws_session):
    S3apiSnsTestClient(lws_session).create_topic()
