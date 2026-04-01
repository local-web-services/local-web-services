"""Then: the "organizations" "organizational unit" children will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then('the "organizations" "organizational unit" children will be returned')
def ou_children_returned(world):
    actual_ids = {c["Id"] for c in world["result"].get("Children", [])}
    expected_ou_ids = set(world["ou_ids"])
    assert (
        expected_ou_ids == actual_ids
    ), f"Expected OU children {expected_ou_ids} but got {actual_ids}"
