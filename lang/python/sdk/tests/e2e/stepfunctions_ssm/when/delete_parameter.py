"""When: a "ssm" "parameter" is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_PARAM


@when('a "ssm" "parameter" is deleted')
def delete_parameter(lws_session, world):
    try:
        world["result"] = lws_session.client("ssm").delete_parameter(Name=TEST_PARAM)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
