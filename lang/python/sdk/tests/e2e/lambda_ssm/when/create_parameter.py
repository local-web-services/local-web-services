"""When: a parameter is created in "SSM" Parameter Store"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import LambdaSsmTestClient
from ..constants import TEST_PARAM, TEST_PARAM_VALUE


@when('a parameter is created in "SSM" Parameter Store')
def create_parameter(lws_session, world):
    try:
        world["result"] = LambdaSsmTestClient(lws_session)._ssm.put_parameter(
            Name=TEST_PARAM, Value=TEST_PARAM_VALUE, Type="String"
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
