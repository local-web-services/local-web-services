"""Given: the function has a resource policy entry"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaTestClient
from ..constants import TEST_FUNC, TEST_STATEMENT_ID


@given("the function has a resource policy entry")
def function_has_resource_policy_entry(lws_session):
    LambdaTestClient(lws_session).create_function()
    try:
        LambdaTestClient(lws_session).add_permission(
            FunctionName=TEST_FUNC,
            StatementId=TEST_STATEMENT_ID,
            Action="lambda:InvokeFunction",
            Principal="s3.amazonaws.com",
        )
    except Exception:
        pass
