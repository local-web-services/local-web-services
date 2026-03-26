"""When: the callee Lambda function is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import LambdaLambdaTestClient
from ..constants import TEST_CALLEE


@when("the callee Lambda function is deleted")
def delete_callee(lws_session, world):
    try:
        LambdaLambdaTestClient(lws_session).delete_function(FunctionName=TEST_CALLEE)
        world["result"] = {"FunctionName": TEST_CALLEE}
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
