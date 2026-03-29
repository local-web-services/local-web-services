"""When: a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_PARAM


@when('a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus')
def delete_parameter_event_delivered(lws_session, world):
    try:
        world["result"] = lws_session.client("ssm").delete_parameter(Name=TEST_PARAM)
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
        return
    if lws_session.capacity("events").is_exhausted():
        world["result"] = None
        world["error"] = Exception("lws: event capacity exhausted")
        return
    world["error"] = None
