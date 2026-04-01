"""When: a permission is added to a "lambda" "function"'s resource policy"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_FUNCTION_NAME, INT_PRINCIPAL, INT_STATEMENT_ID


@when('a permission is added to a "lambda" "function"\'s resource policy')
def add_permission(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = client.post(
        f"/2015-03-31/functions/{INT_FUNCTION_NAME}/policy",
        json={
            "StatementId": INT_STATEMENT_ID,
            "Action": "lambda:InvokeFunction",
            "Principal": INT_PRINCIPAL,
        },
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
