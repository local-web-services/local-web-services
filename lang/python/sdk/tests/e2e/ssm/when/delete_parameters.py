"""When: multiple "ssm" "parameter"s are deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_PARAM


@when('multiple "ssm" "parameter"s are deleted')
def delete_parameters(lws_session, world):
    try:
        resp = lws_session.client("ssm").delete_parameters(Names=[TEST_PARAM])
        if resp.get("InvalidParameters"):
            raise ClientError(
                {
                    "Error": {
                        "Code": "ParameterNotFound",
                        "Message": f"Parameter not found: {resp['InvalidParameters']}",
                    }
                },
                "DeleteParameters",
            )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
