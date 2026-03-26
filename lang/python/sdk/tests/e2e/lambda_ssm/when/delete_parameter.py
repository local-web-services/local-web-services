"""When: a parameter is deleted from "SSM" Parameter Store"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import LambdaSsmTestClient
from ..constants import TEST_PARAM


@when('a parameter is deleted from "SSM" Parameter Store')
def delete_parameter(lws_session, world):
    try:
        world["result"] = LambdaSsmTestClient(lws_session)._ssm.delete_parameter(Name=TEST_PARAM)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
