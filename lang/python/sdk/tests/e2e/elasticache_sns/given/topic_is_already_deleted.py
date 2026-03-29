"""Given: the topic is already "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheSnsTestClient
from ..constants import _topic_arn


@given('the topic is already "DELETED"')
def topic_is_already_deleted(lws_session, world):
    try:
        topic_arn = ElasticacheSnsTestClient(lws_session).create_topic()
    except Exception:
        topic_arn = _topic_arn()
    lws_session.lifecycle("sns").delete_dwell_ms(5000).apply()
    ElasticacheSnsTestClient(lws_session)._sns.delete_topic(TopicArn=topic_arn)
    world["result"] = None
    world["error"] = None
