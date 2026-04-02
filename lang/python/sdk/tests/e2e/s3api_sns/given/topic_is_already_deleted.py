"""Given: the "sns" "topic" is already "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSnsTestClient
from ..constants import _topic_arn


@given('the "sns" "topic" is already "DELETED"')
def topic_is_already_deleted(lws_session, world):
    try:
        S3apiSnsTestClient(lws_session).create_topic()
    except Exception:
        pass
    lws_session.lifecycle("sns").delete_dwell_ms(5000).apply()
    S3apiSnsTestClient(lws_session)._sns.delete_topic(TopicArn=_topic_arn())
    world["result"] = None
    world["error"] = None
