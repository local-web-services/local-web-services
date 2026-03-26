"""When: a parameter is retrieved from "SSM" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SsmTestClient
from ..constants import TEST_PARAM


@when('a parameter is retrieved from "SSM"')
def get_parameter(lws_session, world):
    try:
        resp = SsmTestClient(lws_session).get_parameter(Name=TEST_PARAM)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
