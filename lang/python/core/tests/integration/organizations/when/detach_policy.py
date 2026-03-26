"""When: a policy is detached from a target"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@when("a policy is detached from a target")
def detach_policy(client: TestClient, world):
    status, body = OrganizationsTestClient(client).post(
        "DetachPolicy", {"PolicyId": world["policy_id"], "TargetId": world["target_id"]}
    )
    if status == 200:
        world["result"] = body
    else:
        world["error"] = body
