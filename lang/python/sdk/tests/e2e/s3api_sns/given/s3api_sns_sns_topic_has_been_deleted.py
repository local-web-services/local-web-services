"""Given: the "sns" "topic" is deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSnsTestClient
from ..constants import _topic_arn


@given('the "sns" "topic" is deleted')
def s3api_sns_sns_topic_has_been_deleted(lws_session):
    try:
        S3apiSnsTestClient(lws_session).create_topic()
    except Exception:
        pass
    S3apiSnsTestClient(lws_session)._sns.delete_topic(TopicArn=_topic_arn())
