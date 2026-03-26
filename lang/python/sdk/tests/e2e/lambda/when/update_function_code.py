"""When: a function's code is updated"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import LambdaTestClient
from ..constants import TEST_FUNC


@when("a function's code is updated")
def update_function_code(lws_session, world):
    try:
        resp = LambdaTestClient(lws_session).update_function_code(
            FunctionName=TEST_FUNC, ZipFile=b"updated-fake"
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
