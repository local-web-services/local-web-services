"""When: a "lambda" "function" is deployed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import LambdaMemorydbTestClient
from ..constants import TEST_FUNC


@when('a "lambda" "function" is deployed')
def deploy_lambda_function(lws_session, world):
    try:
        LambdaMemorydbTestClient(lws_session).create_function()
        world["result"] = {"FunctionName": TEST_FUNC}
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
