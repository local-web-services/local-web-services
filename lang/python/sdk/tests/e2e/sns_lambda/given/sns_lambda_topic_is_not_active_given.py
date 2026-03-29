"""Given: the topic is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsLambdaTestClient
from ..constants import _topic_arn


@given('the topic is not "ACTIVE"')
def sns_lambda_topic_is_not_active_given(lws_session, world):
    try:
        SnsLambdaTestClient(lws_session)._sns.delete_topic(TopicArn=_topic_arn())
    except Exception:
        pass
    lws_session.lifecycle("sns").create_dwell_ms(5000).apply()
    SnsLambdaTestClient(lws_session).create_topic()
    world["result"] = None
    world["error"] = None
