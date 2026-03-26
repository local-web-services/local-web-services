"""When: reserved concurrency is set for a function"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import LambdaTestClient
from ..constants import TEST_FUNC


@when("reserved concurrency is set for a function")
def set_reserved_concurrency(lws_session, world):
    try:
        resp = LambdaTestClient(lws_session).put_function_concurrency(
            FunctionName=TEST_FUNC, ReservedConcurrentExecutions=5
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
