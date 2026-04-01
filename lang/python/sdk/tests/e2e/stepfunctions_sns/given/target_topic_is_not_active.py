"""Given: the target topic was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSnsTestClient
from ..constants import _topic_arn


@given('the target topic was not "ACTIVE"')
def target_topic_is_not_active(lws_session, world):
    try:
        StepfunctionsSnsTestClient(lws_session)._sns.delete_topic(TopicArn=_topic_arn())
    except Exception:
        pass
    lws_session.lifecycle("sns").create_dwell_ms(5000).apply()
    StepfunctionsSnsTestClient(lws_session).create_topic()
    world["result"] = None
    world["error"] = None
