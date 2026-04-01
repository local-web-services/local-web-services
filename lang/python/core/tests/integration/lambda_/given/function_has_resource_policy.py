"""Given: the "lambda" "function" has a resource policy"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import LambdaTestClient
from ..constants import INT_FUNCTION_NAME, INT_PRINCIPAL, INT_STATEMENT_ID


@given('the "lambda" "function" had a resource policy')
@given('the "lambda" "function" has a resource policy')
def function_has_resource_policy(client: TestClient):
    LambdaTestClient(client).create_function()
    client.post(
        f"/2015-03-31/functions/{INT_FUNCTION_NAME}/policy",
        json={
            "StatementId": INT_STATEMENT_ID,
            "Action": "lambda:InvokeFunction",
            "Principal": INT_PRINCIPAL,
        },
    )
