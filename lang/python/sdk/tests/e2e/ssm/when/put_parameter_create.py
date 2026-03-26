"""When: a parameter is stored in "SSM" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SsmTestClient
from ..constants import TEST_PARAM, TEST_VALUE


@when('a parameter is stored in "SSM"')
def put_parameter_create(lws_session, world):
    try:
        resp = SsmTestClient(lws_session).put_parameter(
            Name=TEST_PARAM, Value=TEST_VALUE, Type="String"
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
