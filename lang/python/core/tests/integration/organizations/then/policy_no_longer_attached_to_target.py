"""Then: the policy is no longer attached to the target"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@then("the policy is no longer attached to the target")
def policy_no_longer_attached_to_target(client: TestClient, world):
    assert world["error"] is None, f"Expected DetachPolicy to succeed but got: {world['error']}"
    policy_id = world["policy_id"]
    target_id = world["target_id"]
    _, list_body = OrganizationsTestClient(client).post(
        "ListTargetsForPolicy", {"PolicyId": policy_id}
    )
    actual_target_ids = [t["TargetId"] for t in list_body.get("Targets", [])]
    assert (
        target_id not in actual_target_ids
    ), f"Expected target '{target_id}' to be removed but still found in: {actual_target_ids}"
