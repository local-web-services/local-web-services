"""When: a Lambda function is deployed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import ROLE_ARN, TEST_FUNC


@when("a Lambda function is deployed")
def deploy_lambda_function_apigw(lws_session, world):
    try:
        resp = lws_session.client("lambda").create_function(
            FunctionName=TEST_FUNC,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
