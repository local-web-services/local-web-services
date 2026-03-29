"""Given: the target topic is "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSnsTestClient
from ..constants import _topic_arn


@given('the target topic is "DELETED"')
def target_topic_is_deleted(lws_session, world):
    try:
        S3apiSnsTestClient(lws_session).create_topic()
    except Exception:
        pass
    lws_session.lifecycle("sns").delete_dwell_ms(5000).apply()
    S3apiSnsTestClient(lws_session)._sns.delete_topic(TopicArn=_topic_arn())
    world["_target_topic_deleted"] = True
    world["result"] = None
    world["error"] = None
