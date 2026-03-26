"""When: a permission is removed from a function's resource policy"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import LambdaTestClient
from ..constants import TEST_FUNC, TEST_STATEMENT_ID


@when("a permission is removed from a function's resource policy")
def remove_permission(lws_session, world):
    try:
        resp = LambdaTestClient(lws_session).remove_permission(
            FunctionName=TEST_FUNC, StatementId=TEST_STATEMENT_ID
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
