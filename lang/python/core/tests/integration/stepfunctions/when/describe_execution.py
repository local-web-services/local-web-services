"""When: a "step functions" "execution" is described"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SFN_TARGET


@when('a "step functions" "execution" is described')
def describe_execution(client: TestClient, world):
    execution_arn = world.get("execution_arn", "")
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.DescribeExecution"},
        json={"executionArn": execution_arn},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
