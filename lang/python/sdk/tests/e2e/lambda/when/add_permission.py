"""When: a permission is added to a "lambda" "function"'s resource policy"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_FUNC, TEST_STATEMENT_ID


@when('a permission is added to a "lambda" "function"\'s resource policy')
def add_permission(lws_session, world):
    try:
        resp = lws_session.client("lambda").add_permission(
            FunctionName=TEST_FUNC,
            StatementId=TEST_STATEMENT_ID,
            Action="lambda:InvokeFunction",
            Principal="s3.amazonaws.com",
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
