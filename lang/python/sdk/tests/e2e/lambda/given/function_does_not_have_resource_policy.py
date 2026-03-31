"""Given: the "lambda" "function" did not have a resource policy"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaTestClient
from ..constants import TEST_FUNC, TEST_STATEMENT_ID


@given('the "lambda" "function" did not have a resource policy')
def function_does_not_have_resource_policy(lws_session):
    try:
        LambdaTestClient(lws_session).remove_permission(
            FunctionName=TEST_FUNC, StatementId=TEST_STATEMENT_ID
        )
    except Exception:
        pass
