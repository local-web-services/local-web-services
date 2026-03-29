"""Given: an "SNS" topic has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSnsTestClient


@given('an "SNS" topic has been created')
def s3api_sns_sns_topic_has_been_created(lws_session):
    S3apiSnsTestClient(lws_session).create_topic()
