"""When: parameters under a path are retrieved from "SSM" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_PATH


@when('parameters under a path are retrieved from "SSM"')
def get_parameters_by_path(lws_session, world):
    try:
        resp = lws_session.client("ssm").get_parameters_by_path(Path=TEST_PATH)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
