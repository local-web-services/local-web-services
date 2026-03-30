"""Then: the instance tag state is unchanged (no-op model)"""

from __future__ import annotations

from pytest_bdd import then


@then("the instance tag state is unchanged (no-op model)")
def instance_tag_state_unchanged(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected tag operation to succeed but got error: {world['error']}"
