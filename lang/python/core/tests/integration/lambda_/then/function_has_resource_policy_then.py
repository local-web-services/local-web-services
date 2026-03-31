"""Then: the "lambda" "function" has a resource policy"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_FUNCTION_NAME


@then('the "lambda" "function" has a resource policy')
def function_has_resource_policy_then(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected permission to be added but got: {actual_error}"
    r = client.get(f"/2015-03-31/functions/{INT_FUNCTION_NAME}/policy")
    assert (
        r.status_code == 200
    ), f"Expected to retrieve function policy but got status {r.status_code}"
