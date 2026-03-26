"""Then: the policy is attached to the target"""

from __future__ import annotations

from pytest_bdd import then

from ..client import OrganizationsTestClient


@then("the policy is attached to the target")
def policy_is_attached_to_target(lws_session, world):
    assert world["error"] is None, f"Expected AttachPolicy to succeed but got: {world['error']}"
    policy_id = world["policy_id"]
    target_id = world["target_id"]
    list_resp = OrganizationsTestClient(lws_session).list_targets_for_policy(PolicyId=policy_id)
    actual_target_ids = [t["TargetId"] for t in list_resp.get("Targets", [])]
    assert (
        target_id in actual_target_ids
    ), f"Expected target '{target_id}' in policy targets but found: {actual_target_ids}"
