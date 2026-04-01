"""When: an "organizations" "policy" is attached to a target"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@when('an "organizations" "policy" is attached to a target')
def attach_policy(client: TestClient, world):
    status, body = OrganizationsTestClient(client).post(
        "AttachPolicy", {"PolicyId": world["policy_id"], "TargetId": world["target_id"]}
    )
    if status == 200:
        world["result"] = body
    else:
        world["error"] = body
