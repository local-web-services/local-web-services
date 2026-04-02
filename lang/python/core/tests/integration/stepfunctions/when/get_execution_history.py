"""When: the event history of a "step functions" "execution" is retrieved"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SFN_TARGET


@when('the event history of a "step functions" "execution" is retrieved')
def get_execution_history(client: TestClient, world):
    execution_arn = world.get("execution_arn", "")
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.GetExecutionHistory"},
        json={"executionArn": execution_arn},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
