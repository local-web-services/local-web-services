"""When: a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SsmEventsTestClient
from ..constants import TEST_PARAM


@when('a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus')
def delete_parameter_event_delivered(lws_session, world):
    try:
        world["result"] = SsmEventsTestClient(lws_session)._ssm.delete_parameter(Name=TEST_PARAM)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
