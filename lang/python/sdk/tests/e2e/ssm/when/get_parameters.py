"""When: multiple "ssm" "parameter"s are retrieved"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_PARAM


@when('multiple "ssm" "parameter"s are retrieved')
def get_parameters(lws_session, world):
    try:
        resp = lws_session.client("ssm").get_parameters(Names=[TEST_PARAM])
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
