"""When: a "ssm" "parameter" is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_PARAM, TEST_PARAM_VALUE


@when('a "ssm" "parameter" is created')
def create_parameter(lws_session, world):
    try:
        world["result"] = lws_session.client("ssm").put_parameter(
            Name=TEST_PARAM, Value=TEST_PARAM_VALUE, Type="String"
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
