"""When: a caller Lambda function is deployed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import LambdaLambdaTestClient
from ..constants import TEST_CALLER


@when("a caller Lambda function is deployed")
def deploy_caller(lws_session, world):
    try:
        LambdaLambdaTestClient(lws_session).create_function(TEST_CALLER)
        world["result"] = {"FunctionName": TEST_CALLER}
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
