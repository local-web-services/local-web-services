"""When: a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SsmEventsTestClient
from ..constants import TEST_PARAM, TEST_VALUE


@when('a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus')
def put_parameter_event_delivered(lws_session, world):
    try:
        world["result"] = SsmEventsTestClient(lws_session)._ssm.put_parameter(
            Name=TEST_PARAM, Value=TEST_VALUE, Type="String"
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
