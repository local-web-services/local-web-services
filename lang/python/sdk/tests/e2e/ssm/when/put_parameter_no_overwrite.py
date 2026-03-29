"""When: a parameter is written without overwrite when it already exists"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_PARAM, TEST_VALUE2


@when("a parameter is written without overwrite when it already exists")
def put_parameter_no_overwrite(lws_session, world):
    try:
        desc = lws_session.client("ssm").describe_parameters(
            Filters=[{"Key": "Name", "Values": [TEST_PARAM]}]
        )
        if not desc.get("Parameters"):
            raise ClientError(
                {
                    "Error": {
                        "Code": "ParameterNotFound",
                        "Message": f"Parameter {TEST_PARAM} does not exist",
                    }
                },
                "PutParameter",
            )
        resp = lws_session.client("ssm").put_parameter(
            Name=TEST_PARAM, Value=TEST_VALUE2, Type="String"
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
