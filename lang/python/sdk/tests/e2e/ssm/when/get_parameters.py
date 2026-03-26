"""When: multiple parameters are retrieved from "SSM" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SsmTestClient
from ..constants import TEST_PARAM


@when('multiple parameters are retrieved from "SSM"')
def get_parameters(lws_session, world):
    try:
        resp = SsmTestClient(lws_session).get_parameters(Names=[TEST_PARAM])
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
