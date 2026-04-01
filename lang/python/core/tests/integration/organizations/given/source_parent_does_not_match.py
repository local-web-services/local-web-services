"""Given: the source parent did not match the "organizations" "account"'s current parent"""

from __future__ import annotations

from pytest_bdd import given


@given('the source parent did not match the "organizations" "account"\'s current parent')
def source_parent_does_not_match(world):
    world["source_parent_id"] = "wrong-parent-id"
    if world.get("dest_parent_id") is None:
        world["dest_parent_id"] = world.get("root_id", "nonexistent-dest")
