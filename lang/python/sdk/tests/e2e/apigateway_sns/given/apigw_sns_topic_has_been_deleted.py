"""Given: the "sns" "topic" is deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewaySnsTestClient
from ..constants import _topic_arn


@given('the "sns" "topic" is deleted')
def apigw_sns_topic_has_been_deleted(lws_session):
    ApigatewaySnsTestClient(lws_session).create_topic()
    ApigatewaySnsTestClient(lws_session)._sns.delete_topic(TopicArn=_topic_arn())
