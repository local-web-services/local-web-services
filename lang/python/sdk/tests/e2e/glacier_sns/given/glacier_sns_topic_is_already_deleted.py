"""Given: the topic is already "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierSnsTestClient
from ..constants import _topic_arn


@given('the topic is already "DELETED"')
def glacier_sns_topic_is_already_deleted(lws_session, world):
    try:
        GlacierSnsTestClient(lws_session).create_topic()
    except Exception:
        pass
    lws_session.lifecycle("sns").delete_dwell_ms(5000).apply()
    GlacierSnsTestClient(lws_session)._sns.delete_topic(TopicArn=_topic_arn())
    world["result"] = None
    world["error"] = None
