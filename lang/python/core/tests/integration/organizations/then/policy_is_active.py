"""Then: the policy is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@then('the policy is "ACTIVE"')
def policy_is_active(client: TestClient, world):
    assert world["error"] is None, f"Expected CreatePolicy to succeed but got: {world['error']}"
    policy_id = world["policy_id"]
    _, policy_body = OrganizationsTestClient(client).post("DescribePolicy", {"PolicyId": policy_id})
    actual_id = policy_body.get("Policy", {}).get("PolicySummary", {}).get("Id")
    assert (
        actual_id is not None
    ), f"Expected policy Id to be set but got None for policy_id={policy_id}"
