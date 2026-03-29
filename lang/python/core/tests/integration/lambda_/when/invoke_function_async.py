"""When: a function is invoked asynchronously"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_FUNCTION_NAME


@when("a function is invoked asynchronously")
def invoke_function_async(client: TestClient, world):
    r = client.post(
        f"/2015-03-31/functions/{INT_FUNCTION_NAME}/invocations",
        headers={"X-Amz-Invocation-Type": "Event"},
        json={},
    )
    if r.status_code < 300:
        world["result"] = {} if r.status_code == 202 else r.json()
    else:
        world["error"] = r.json() if r.content else {"__type": "Error"}
