"""Then: the "organizations" "account" children will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then('the "organizations" "account" children will be returned')
def account_children_returned(world):
    assert world["error"] is None, f"Expected success but got: {world['error']}"
    actual_ids = {c["Id"] for c in world["result"].get("Children", [])}
    expected_account_id = world["account_id"]
    assert (
        expected_account_id in actual_ids
    ), f"Expected account '{expected_account_id}' in children but got {actual_ids}"
