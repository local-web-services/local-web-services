"""When: a parameter is created but the "CREATED" event delivery fails because the bus is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_PARAM, TEST_VALUE


@when('a parameter is created but the "CREATED" event delivery fails because the bus is deleted')
def put_parameter_event_fails(lws_session, world):
    try:
        world["result"] = lws_session.client("ssm").put_parameter(
            Name=TEST_PARAM, Value=TEST_VALUE, Type="String"
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
