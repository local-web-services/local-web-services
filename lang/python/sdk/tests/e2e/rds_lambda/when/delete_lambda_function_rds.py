"""When: the Lambda function is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_FUNC


@when("the Lambda function is deleted")
def delete_lambda_function_rds(lws_session, world):
    try:
        resp = lws_session.client("lambda").delete_function(FunctionName=TEST_FUNC)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
