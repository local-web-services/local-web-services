"""When: a running execution is stopped"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SFN_TARGET


@when("a running execution is stopped")
def stop_execution(client: TestClient, world):
    execution_arn = world.get("execution_arn", "")
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.StopExecution"},
        json={"executionArn": execution_arn},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
