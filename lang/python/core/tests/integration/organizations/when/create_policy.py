"""When: a service control policy is created"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient
from ..constants import INT_POLICY_NAME, INT_POLICY_TYPE


@when("a service control policy is created")
def create_policy(client: TestClient, world):
    status, body = OrganizationsTestClient(client).post(
        "CreatePolicy",
        {
            "Name": INT_POLICY_NAME,
            "Description": "integration test policy",
            "Content": "{}",
            "Type": INT_POLICY_TYPE,
        },
    )
    if status == 200:
        world["result"] = body
        world["policy_id"] = body.get("Policy", {}).get("PolicySummary", {}).get("Id")
    else:
        world["error"] = body
