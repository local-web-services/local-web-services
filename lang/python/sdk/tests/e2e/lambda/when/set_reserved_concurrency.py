"""When: reserved concurrency is set for a "lambda" "function" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_FUNC


@when('reserved concurrency is set for a "lambda" "function"')
def set_reserved_concurrency(lws_session, world):
    try:
        resp = lws_session.client("lambda").put_function_concurrency(
            FunctionName=TEST_FUNC, ReservedConcurrentExecutions=5
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
